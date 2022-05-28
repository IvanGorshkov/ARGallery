//
//  SpecificationsDescCellModel.swift
//  MilliArt
//
//  Created by Ivan Gorshkov on 29.10.2021.
//

import Foundation

final class SpecificationsDescCellModel: BaseCellModel {
    override var cellIdentifier: String {
        return SpecificationsDescCell.cellIdentifier
    }

    let title: String
    let specification: String
    init(_ model: Info) {
        title = model.type
        specification = model.value
    }
}
