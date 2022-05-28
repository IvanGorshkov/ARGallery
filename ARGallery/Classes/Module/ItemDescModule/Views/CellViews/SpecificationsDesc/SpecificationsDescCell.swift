//
//  SpecificationsDescCell.swift
//  MilliArt
//
//  Created by Ivan Gorshkov on 29.10.2021.
//

import UIKit

final class SpecificationsDescCell: BaseCell {
    internal var titleLabel = UILabel()
    internal var specification = UILabel()

    static let cellIdentifier = "SpecificationsDescCell"

    override func updateViews() {
        guard let model = model as? SpecificationsDescCellModel else {
            return
        }
        titleLabel.text = model.title
        specification.text = model.specification
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        [titleLabel, specification].forEach({
            contentView.addSubview($0)
        })
        addConstraintsSpecifications()
        setUp()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setUp() {
        setUpBase()
        [titleLabel, specification].forEach({
            $0.numberOfLines = 0
            $0.textColor = ColorConstants.BlackColor
        })
    }

    private func setUpBase() {
        backgroundColor = .clear
        separatorInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
    }
}
