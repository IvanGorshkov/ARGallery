//
//  BaseCell.swift
//  MilliArt
//
//  Created by Ivan Gorshkov on 29.10.2021.
//

import Foundation

import UIKit

class BaseCell: UITableViewCell, ModelRepresentable {
    var model: CellIdentifiable? {
        didSet {
            updateViews()
        }
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
            super.init(style: style, reuseIdentifier: reuseIdentifier)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func updateViews() { fatalError("Abstract class, dont use") }
}
