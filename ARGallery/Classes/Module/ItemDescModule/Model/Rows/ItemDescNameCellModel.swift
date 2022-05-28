//
//  ItemDescNameCellModel.swift
//  MilliArt
//
//  Created by Ivan Gorshkov on 29.10.2021.
//

import Foundation

final class ItemDescNameCellModel: BaseCellModel {
    override var cellIdentifier: String {
        return ItemNameCell.cellIdentifier
    }

    var name: String

    var showBtn: Bool
    
    typealias ActionHandler = () -> Void

    var actionAR: ActionHandler?
    
    init(_ model: ItemDescResponse, actionAR: ActionHandler?) {
        self.name = model.name
        showBtn = false
        if let actionAR = actionAR {
            self.actionAR = actionAR
            showBtn = true
        }
    }
}
