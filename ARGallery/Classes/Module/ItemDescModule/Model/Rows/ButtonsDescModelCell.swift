//
//  ButtonsDescModelCell.swift
//  MilliArt
//
//  Created by Ivan Gorshkov on 29.10.2021.
//

import Foundation

final class ButtonsDescModelCell: BaseCellModel {
    override var cellIdentifier: String {
        return ButtonsDescCell.cellIdentifier
    }

    typealias ActionHandler = () -> Void
    typealias ActionSelectedHandler = (Bool) -> Void

    var actionAR: ActionHandler?
    var actionFav: ActionSelectedHandler?
    var selected: Bool
    
    init(
        _ model: ItemDescResponse,
        actionAR: ActionHandler?,
        actionFav: ActionSelectedHandler?) {
            self.actionAR = actionAR
            self.actionFav = actionFav
            self.selected = model.isSelected ?? false
    }
}
