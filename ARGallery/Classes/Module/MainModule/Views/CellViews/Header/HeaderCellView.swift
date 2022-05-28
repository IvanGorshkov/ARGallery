//
//  HeaderCellView.swift
//  MilliArt
//
//  Created by Alekhin Sergey on 04.11.2021.
//

import UIKit

final class HeaderCellView: BaseCell {
    internal var titleLabel = UILabel()
    internal var allButton = UIButton()

    static let cellIdentifier = "HeaderCellModel"

    override func updateViews() {
        guard let model = model as? HeaderCellViewModel else { return }
        titleLabel.text = model.title

        if model.action == nil {
            allButton.isHidden = true
        } else {
            allButton.setTitle(TitlesConstants.all, for: .normal)
            allButton.isHidden = false
        }
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        [titleLabel, allButton].forEach { [weak self] in
            self?.contentView.addSubview($0)
        }
        addConstraintsHeader()
        setUp()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setUp() {
        setUpBase()
        setUpLabel()
        setUpButton()
    }

    @objc
    private func clickAll() {
        guard let model = model as? HeaderCellViewModel else { return }
        model.action?()
    }

    private func setUpButton() {
        allButton.addTarget(self, action: #selector(clickAll), for: .touchUpInside)
        allButton.setTitleColor(ColorConstants.MainPurpleColor, for: .normal)
        allButton.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: UIFont.Weight.bold)
    }

    private func setUpBase() {
        backgroundColor = .clear
        separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: UIScreen.main.bounds.width)
    }

    private func setUpLabel() {
        titleLabel.numberOfLines = 0
        titleLabel.textColor = ColorConstants.BlackColor
        titleLabel.font = UIFont.systemFont(ofSize: 24, weight: UIFont.Weight.heavy)
    }
}
