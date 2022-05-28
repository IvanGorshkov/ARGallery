//
//  AllCompilationsInteractor.swift
//  MilliArt
//
//  Created by Ivan Gorshkov on 05.11.2021.
//  
//

import Foundation

final class AllGalleriesInteractor {
	weak var output: AllInteractorOutput?
    private var galleries: AllGalleriesResponse?
    private var filterGalleries: AllGalleriesResponse?
    
    init() { }
}

extension AllGalleriesInteractor: AllInteractorInput {
    func enterText(text: String) {
        SearchRequest(parameters: [
            "name": text
        ]).perform { content, err in
            if err != nil {
                self.output?.receiveData(data: [])
                return
            }
            guard let content = content else {
                self.output?.receiveData(data: [])
                return
            }
            self.filterGalleries?.items = content.museums
            guard let museums = self.filterGalleries?.items else {
                self.output?.receiveData(data: [])
                return
            }
            
            let data = museums.compactMap({ card in
                return HorizontalViewModel(card: card)
            })
            self.output?.receiveData(data: data)
        }
    }
    
    func receiveId(with index: Int) -> Int {
        return filterGalleries?.items?[index].id ?? 0
    }
    
    func receiveTitle(with index: Int) -> String {
        return filterGalleries?.items?[index].name ?? ""
    }
    
    func getTitle() -> String {
        return TitlesConstants.galleriesTitle
    }

    func loadData() {
        AllGalleriesRequest().perform { items, err in
            if err != nil {
                return
            }
            guard let items = items else {
                return
            }
            
            self.galleries = items
            self.filterGalleries = items
            guard let galleries = self.galleries?.items else {
                self.output?.receiveData(data: [])
                return
            }
        
            self.output?.receiveData(data: galleries.map({ gallery in
                return HorizontalViewModel(card: gallery)
            }))
        }
    }
}
