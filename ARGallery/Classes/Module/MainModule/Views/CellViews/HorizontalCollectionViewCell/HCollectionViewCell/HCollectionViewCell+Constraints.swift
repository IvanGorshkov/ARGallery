//
//  HCollectionViewCell+Constraints.swift
//  MilliArt
//
//  Created by Alekhin Sergey on 04.11.2021.
//

import UIKit

extension HCollectionViewCell {
    internal func addConstraints() {
        self.imageView.translatesAutoresizingMaskIntoConstraints = false
        self.imageView.topAnchor.constraint(equalTo: self.contentView.topAnchor).isActive = true
        self.imageView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor).isActive = true
        self.imageView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor).isActive = true
        self.imageView.heightAnchor.constraint(equalToConstant: 170).isActive = true

        self.nameLabel.translatesAutoresizingMaskIntoConstraints = false
        self.nameLabel.topAnchor.constraint(equalTo: self.imageView.bottomAnchor, constant: 5).isActive = true
        self.nameLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor).isActive = true
        self.nameLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor).isActive = true
        self.nameLabel.heightAnchor.constraint(equalToConstant: 300).isActive = true
        self.nameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
    }

    internal func updateWidth(with width: CGFloat) {
        if myWidthAnchor == nil {
            myWidthAnchor = self.imageView.widthAnchor.constraint(equalToConstant: width)
            myWidthAnchor.isActive = true
        } else {
            myWidthAnchor.constant = width
        }
    }
}
