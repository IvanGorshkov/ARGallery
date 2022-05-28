//
//  HCollectionViewModel.swift
//  MilliArt
//
//  Created by Alekhin Sergey on 04.11.2021.
//

import Foundation

final class VCollectionViewModel: BaseCellModel {
    typealias ActionHandler = (Int) -> Void
    var action: ActionHandler?

    override var cellIdentifier: String {
        return VCollectionViewTableViewCell.cellIdentifier
    }
    let array: [VerticalViewModel]

    init(action: ActionHandler? = nil, cards: [Card]) {
        self.action = action
        self.array = cards.map({ card in
            return VerticalViewModel(
                id: card.id,
                pic: card.picture,
                name: card.name,
                frameHeight: card.pictureSize.height,
                frameWidth: card.pictureSize.width)
        })
    }
}
