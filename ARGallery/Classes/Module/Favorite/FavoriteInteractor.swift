//
//  FavoriteInteractor.swift
//  ARGallery
//
//  Created by Ivan Gorshkov on 05.04.2022.
//  
//

import Foundation

final class FavoriteInteractor {
	weak var output: FavoriteInteractorOutput?
    private var cards = [Card]()
}

extension FavoriteInteractor: FavoriteInteractorInput {
    func loadData() {
        FavoriteRequest(parameters: [
            "id": FavStorage().getAllIds().map({ num in
                String(num)
            }).joined(separator: ",")
        ]).perform { content, err in
            if err != nil {
                return
            }
            guard let content = content else {
                return
            }
            self.cards = content
        
            self.output?.receiveData(data: self.cards)
        }
    }
    
    func receiveId(with index: Int) -> Int {
        return cards[index].id
    }
    
}
