//
//  File.swift
//  MilliArt
//
//  Created by Alekhin Sergey on 04.11.2021.
//

import UIKit
import Kingfisher

final class HCollectionViewCell: UICollectionViewCell {
    static let cellIdentifier = "HorizontalCollectionView"

    internal var imageView = UIImageView()
    internal var nameLabel = MUILabel()
    internal var myWidthAnchor: NSLayoutConstraint!

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
        setUpTitle()
    }

    private func setUpImageView() {
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 10
        contentView.clipsToBounds = true
    }

    private func setUpTitle() {
        nameLabel.textColor = ColorConstants.TextColor
        nameLabel.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.light)
        nameLabel.numberOfLines = 0
        nameLabel.top = true
    }


    
    func configure(model: CellIdentifiable?, complition: @escaping () -> (Bool)) {
        self.imageView.image = nil
        guard let model = model as? HorizontalViewModel else { return }
        nameLabel.text = model.name
        self.updateWidth(with: model.widthConstrint)
        imageView.kf.indicatorType = .image(imageData: gifData)
        KF.url(URL(string: model.pic))
            .cacheOriginalImage()
            .transition(.fade(1))
            .set(to: imageView)
    }
}

let gifData: Data = {
    let url = Bundle.main.url(forResource: "loader", withExtension: "gif")!
    return try! Data(contentsOf: url)
}()


