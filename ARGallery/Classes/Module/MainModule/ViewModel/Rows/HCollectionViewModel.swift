//
//  HCollectionViewModel.swift
//  MilliArt
//
//  Created by Alekhin Sergey on 04.11.2021.
//

import Foundation

final class HCollectionViewModel: BaseCellModel {
    typealias ActionHandler = (Int) -> Void
    var action: ActionHandler?

    override var cellIdentifier: String {
        return HCollectionViewTableViewCell.cellIdentifier
    }

    let array: [HorizontalViewModel]

    init(array: [HorizontalViewModel], action: ActionHandler? = nil) {
        self.action = action
        self.array = array
    }
}
