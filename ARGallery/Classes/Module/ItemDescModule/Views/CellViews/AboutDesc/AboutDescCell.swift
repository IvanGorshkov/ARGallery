//
//  AboutDescCell.swift
//  MilliArt
//
//  Created by Ivan Gorshkov on 29.10.2021.
//

import UIKit

final class AboutDescCell: BaseCell {
    internal var descriptionLabel = UILabel()
    static let cellIdentifier = "AboutDescCellModel"
    private var stringValue: String? {
        didSet {
            descriptionLabel.attributedText = stringValue?.textWithLineSpace()
        }
    }

    override func updateViews() {
        guard let model = model as? AboutDescCellModel else { return }
        stringValue = "\(TitlesConstants.AboutTitle)\n\(model.text)"
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        [descriptionLabel].forEach({
            contentView.addSubview($0)
        })
        addConstraintsDescription()
        setUp()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setUp() {
        setUpBase()
        setUpDescription()
    }

    private func setUpBase() {
        backgroundColor = .clear
        separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: UIScreen.main.bounds.width)
    }

    private func setUpDescription() {
        descriptionLabel.numberOfLines = 0
        descriptionLabel.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.thin)
        descriptionLabel.lineBreakMode = .byWordWrapping
        descriptionLabel.textColor = ColorConstants.BlackColor
    }
}
