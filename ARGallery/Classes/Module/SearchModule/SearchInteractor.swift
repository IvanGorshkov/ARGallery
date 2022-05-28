//
//  SearchInteractor.swift
//  MilliArt
//
//  Created by Alekhin Sergey on 28.10.2021.
//  
//

import Foundation

final class SearchInteractor {
    weak var output: SearchInteractorOutput?
    private var totalPainingsArray = SearchResponse()
    private var filterPainingsArray = SearchResponse()
    
    
    init() {
    }
}

extension SearchInteractor: SearchInteractorInput {
    func receiveId(with index: Int) -> Int {
        if let pictures = filterPainingsArray.pictures, pictures.isEmpty {
            return totalPainingsArray.pictures?[index].id ?? 0
        }
        
        return filterPainingsArray.pictures?[index].id ?? 0
    }
    
    func loadData() {
        SearchRequest(parameters: [
            "name": ""
        ]).perform { items, err in
            if err != nil {
                return
            }
            guard let items = items else {
                return
            }
            
            self.totalPainingsArray = items
            self.filterPainingsArray = items
            guard let pictures = self.filterPainingsArray.pictures else {
                self.output?.receiveData(data: [])
                return
            }
        
            self.output?.receiveData(data: pictures)
        }
    }
    
    func enterText(text: String) {
        SearchRequest(parameters: [
            "name": text
        ]).perform { items, err in
            if err != nil {
                self.output?.receiveData(data: [])
                return
            }
            guard let items = items else {
                self.output?.receiveData(data: [])
                return
            }
            self.filterPainingsArray = items
            guard let pictures = self.filterPainingsArray.pictures else {
                self.output?.receiveData(data: [])
                return
            }
        
            self.output?.receiveData(data: pictures)
        }
    }
}
