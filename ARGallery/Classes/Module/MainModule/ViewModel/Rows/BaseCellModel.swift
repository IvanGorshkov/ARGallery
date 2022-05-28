//
//  BaseCellModel.swift
//  MilliArt
//
//  Created by Ivan Gorshkov on 29.10.2021.
//

import Foundation

class BaseCellModel: CellIdentifiable {
    var height: Float = -1.0

    var cellIdentifier: String {
        return ""
    }

    var cellHeight: Float {
        return height
    }
}
