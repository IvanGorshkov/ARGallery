//
//  HeaderCellViewModel.swift
//  MilliArt
//
//  Created by Alekhin Sergey on 04.11.2021.
//

import Foundation

final class HeaderCellViewModel: BaseCellModel {
    typealias ActionHandler = () -> Void
    var action: ActionHandler?

    override var cellIdentifier: String {
        return HeaderCellView.cellIdentifier
    }

    var title: String
    var seeAll: String

    init(title: String, action: ActionHandler? = nil) {
        self.title = title
        self.seeAll = TitlesConstants.all
        self.action = action
    }
}
