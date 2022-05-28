//
//  ButtonsDescCell.swift
//  MilliArt
//
//  Created by Ivan Gorshkov on 30.10.2021.
//

import UIKit

final class ButtonsDescCell: BaseCell {
    internal var arButton = UIButton()
    internal var favButton = UIButton()

    static let cellIdentifier = "ButtonsDescCellModel"

    override func updateViews() {
        arButton.setImage(UIImage(named: "ar"), for: .normal)
        arButton.setTitle("AR", for: .normal)
        arButton.setTitleColor(ColorConstants.MainPurpleColor, for: .normal)
        favButton.setImage(UIImage(named: "fav"), for: .normal)
        favButton.setImage(UIImage(named: "fav_fill"), for: .selected)
        
        guard let model = model as? ButtonsDescModelCell else { return }
        favButton.isSelected = model.selected
        
        let spacing: CGFloat = 10
        arButton.setInsets(forContentPadding: UIEdgeInsets(top: 0, left: spacing, bottom: 0, right: 0), imageTitlePadding: spacing)
        
    }

    @objc
    private func clickAR() {
        guard let model = model as? ButtonsDescModelCell else { return }
        model.actionAR?()
    }

    @objc
    private func clickFav() {
        guard let model = model as? ButtonsDescModelCell else { return }
        favButton.isSelected = !favButton.isSelected
        model.actionFav?(favButton.isSelected)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        [arButton, favButton].forEach({ contentView.addSubview($0)
        })

        addConstraints()
        setUp()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setUp() {
        setUpBase()
        setUpUIElements()
    }

    private func setUpBase() {
        backgroundColor = .clear
        separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: UIScreen.main.bounds.width)
    }

    private func setUpUIElements() {
        [(arButton, #selector(clickAR)),
         (favButton, #selector(clickFav))
        ].forEach { $0.0.addTarget(self, action: $0.1, for: .touchUpInside) }
    }
}
