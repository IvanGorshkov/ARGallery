//
//  AllCollectionViewCell.swift
//  MilliArt
//
//  Created by Ivan Gorshkov on 04.11.2021.
//

import UIKit
import Kingfisher

final class AllCollectionViewCell: UICollectionViewCell {
    static let cellIdentifier = "AllCollectionViewCell"

    internal var myHeightAnchor: NSLayoutConstraint!
    internal var imageView = UIImageView()
    internal var nameLabel = MUILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        [imageView, nameLabel].forEach { [weak self] view in
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
        self.imageView.image = nil
        guard let model = model as? HorizontalViewModel else { return }
        nameLabel.text = model.name
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
