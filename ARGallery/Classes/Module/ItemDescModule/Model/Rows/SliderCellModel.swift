//
//  SliderCellModel.swift
//  MilliArt
//
//  Created by Ivan Gorshkov on 29.10.2021.
//

import Foundation

final class SliderCellModel: BaseCellModel {
    typealias ActionHandler = (ImageSlideshow) -> Void
    var action: ActionHandler?

    override var cellIdentifier: String {
        return ItemSliderCell.cellIdentifier
    }

    var pics: [String]

    init(_ model: ItemDescResponse, action: ActionHandler? = nil) {
        self.pics = model.picture.components(separatedBy: ",")
        self.action = action
    }
}
