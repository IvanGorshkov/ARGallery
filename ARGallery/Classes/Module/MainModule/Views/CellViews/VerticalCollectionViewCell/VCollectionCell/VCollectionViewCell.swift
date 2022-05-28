//
//  VCollectionViewCell.swift
//  MilliArt
//
//  Created by Alekhin Sergey on 04.11.2021.
//

import UIKit
import NVActivityIndicatorView
import Kingfisher

final class VCollectionViewCell: UICollectionViewCell {
    static let cellIdentifier = "VerticalCollectionCell"

    internal var myHeightAnchor: NSLayoutConstraint!
    internal var imageView = UIImageView()
    internal var nameLabel = MUILabel()
    internal var sizeLabel = MUILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        [imageView, nameLabel, sizeLabel].forEach { [weak self] view in
            self?.contentView.addSubview(view)
        }
        addConstraints()
        setUp()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setUp() {
        setUpImageView()
        setUpLables()
        contentView.clipsToBounds = true
    }

    private func setUpImageView() {
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 10
    }

    private func setUpLables() {
        setUplabel(label: nameLabel, alignment: .left, textColor: ColorConstants.TextColor, fontSize: 16, numberOfLines: 3, verticalAlignment: true)
        
        setUplabel(label: sizeLabel, alignment: .right, textColor: .white, fontSize: 16, numberOfLines: 1)
        sizeLabel.layer.cornerRadius = 10
        sizeLabel.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMaxYCorner]
        sizeLabel.backgroundColor = ColorConstants.MainPurpleColor
        sizeLabel.padding(5, 5, 5, 5)
    }

    private func setUplabel(label: MUILabel, alignment: NSTextAlignment, textColor: UIColor, fontSize: CGFloat, numberOfLines: Int, verticalAlignment: Bool = false) {
        label.textAlignment = alignment
        label.textColor = textColor
        label.font = UIFont.systemFont(ofSize: fontSize, weight: UIFont.Weight.light)
        label.numberOfLines = numberOfLines
        label.clipsToBounds = true
        label.top = verticalAlignment
    }

    func configure(model: CellIdentifiable?, complition: @escaping () -> (Bool)) {
        guard let model = model as? VerticalViewModel else { return }
        nameLabel.text = model.name
        sizeLabel.text = "\(model.frameHeight)x\(model.frameWidth)"
        imageView.kf.indicatorType = .image(imageData: gifData)
        KF.url(URL(string: model.pic))
            .cacheOriginalImage()
            .transition(.fade(1))
            .set(to: imageView)
    }

    override func apply(_ layoutAttributes: UICollectionViewLayoutAttributes) {
        super.apply(layoutAttributes)
        guard let attributes = layoutAttributes as? MosaicLayoutAttributes else {
            return
        }
        updateHeight(with: attributes)
    }
}
