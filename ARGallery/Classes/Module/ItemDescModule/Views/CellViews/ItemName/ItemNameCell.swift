//
//  ItemNameCell.swift
//  MilliArt
//
//  Created by Ivan Gorshkov on 29.10.2021.
//

import UIKit

final class ItemNameCell: BaseCell {
    internal var nameLabel = UILabel()

    static let cellIdentifier = "ItemDescNameCellModel"
    internal var arButton = UIButton()
    
    
    @objc
    private func clickAR() {
        guard let model = model as? ItemDescNameCellModel else { return }
        model.actionAR?()
    }

    override func updateViews() {
        guard let model = model as? ItemDescNameCellModel else {
            return
        }
        nameLabel.text = model.name
        layoutIfNeeded()
        arButton.setImage(UIImage(named: "ar"), for: .normal)
        arButton.addTarget(self, action: #selector(clickAR), for: .touchUpInside)
        if model.showBtn == false {
            arButton.isHidden = true
        }
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        [nameLabel, arButton].forEach({
            contentView.addSubview($0)
        })
        
        addConstraintsName()
        setUp()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setUp() {
        setUpBase()
        setUpLabel()
    }

    private func setUpBase() {
        backgroundColor = .clear
        separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: UIScreen.main.bounds.width)
    }

    private func setUpLabel() {
        nameLabel.numberOfLines = 0
        nameLabel.textColor = ColorConstants.BlackColor
        nameLabel.font = UIFont.systemFont(ofSize: 24, weight: UIFont.Weight.heavy)
    }
}
