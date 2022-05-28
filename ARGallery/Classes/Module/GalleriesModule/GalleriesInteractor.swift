//
//  GalleriesInteractor.swift
//  MilliArt
//
//  Created by Ivan Gorshkov on 01.12.2021.
//  
//

import Foundation

final class GalleriesInteractor {
    private var galleriesResponse: GalleriesResponse?
    private var filterGalleriesResponse: GalleriesResponse?
	weak var output: GalleriesInteractorOutput?
    init() {}
}

extension GalleriesInteractor: GalleriesInteractorInput {
    func enterText(text: String) {
        SearchRequest(parameters: [
            "name": text,
            "type": "museum",
            "id": "\(self.output?.receiveId() ?? 0)"
        ]).perform { content, err in
            if err != nil {
                self.output?.receiveData(data: [])
                return
            }
            guard let content = content else {
                self.output?.receiveData(data: [])
                return
            }
            self.filterGalleriesResponse?.exhibitions = content.exhibitions
            guard let exhibitions = self.filterGalleriesResponse?.exhibitions else {
                self.output?.receiveData(data: [])
                return
            }
        
            self.output?.receiveData(data: exhibitions)
        }
    }
    
    func getExhibition() -> GalleriesResponse? {
        return self.galleriesResponse
    }
    
    func receiveId(with index: Int) -> Int {
        guard let exhibitions = self.filterGalleriesResponse?.exhibitions else {
            return 0
        }
        return exhibitions[index].id
    }
    
    func receiveTitle(with index: Int) -> String {
        guard let exhibitions = self.filterGalleriesResponse?.exhibitions else {
            return ""
        }
        
        return exhibitions[index].name
    }
    
    func loadData(with id: Int) {
        GalleriesRequest(id: id).perform { [weak self] response, err in
            if err != nil {
                self?.output?.receiveData(data: [])
                return
            }
            guard let response = response else {
                self?.output?.receiveData(data: [])
                return
            }
            guard let self = self else { return }
            self.galleriesResponse = response
            self.filterGalleriesResponse = response
            
            guard let exhibitions = self.galleriesResponse?.exhibitions else {
                self.output?.receiveData(data: [])
                return
            }
            
            self.output?.receiveData(data: exhibitions)
        }
    }
}
