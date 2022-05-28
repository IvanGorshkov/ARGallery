//
//  AllAuthorsInteractor.swift
//  MilliArt
//
//  Created by Ivan Gorshkov on 05.11.2021.
//  
//

import Foundation

final class AllExhibitionsInteractor {
	weak var output: AllInteractorOutput?
    private var exhibitions: AllExhibitionsResponse?
    private var filterExhibitions: AllExhibitionsResponse?
    private var searchText: String = ""
    private var intType: Int = 0
    private var filterType: String {
        if intType == 0 {
            return "all"
        }
        if intType == 1 {
            return "now"
        }
        return "old"
    }
    
    init() {
    }
}

extension AllExhibitionsInteractor: AllInteractorInput, SegmentedControlDelegate {
    func segmentedControlDidChange(index: Int) {
        intType = index
        enterText(text: searchText)
    }

    func enterText(text: String) {
        searchText = text
        SearchRequest(parameters: [
            "name": text,
            "filter": filterType
        ]).perform { content, err in
            if err != nil {
                self.output?.receiveData(data: [])
                return
            }
            guard let content = content else {
                self.output?.receiveData(data: [])
                return
            }
            self.filterExhibitions?.items = content.exhibitions
            guard let exhibitions = self.filterExhibitions?.items else {
                self.output?.receiveData(data: [])
                return
            }
            
            let data = exhibitions.compactMap({ card in
                return HorizontalViewModel(card: card)
            })
            self.output?.receiveData(data: data)
        }
    }
    
    func receiveId(with index: Int) -> Int {
        return filterExhibitions?.items?[index].id ?? 0
    }
    
    func receiveTitle(with index: Int) -> String {
        return filterExhibitions?.items?[index].name ?? ""
    }
        
    func getTitle() -> String {
        return TitlesConstants.exhibitionsTitle
    }

    func loadData() {
        AllExhibitionsRequest().perform { items, err in
            if err != nil {
                return
            }
            guard let items = items else {
                return
            }
            
            self.exhibitions = items
            self.filterExhibitions = items
            guard let exhibitions = self.exhibitions?.items else {
                self.output?.receiveData(data: [])
                return
            }
        
            self.output?.receiveData(data: exhibitions.map({ exhibition in
                return HorizontalViewModel(card: exhibition)
            }))
        }
    }
}
