//
//  HCollectionVTVC+Constraints.swift
//  MilliArt
//
//  Created by Alekhin Sergey on 04.11.2021.
//

import UIKit

extension HCollectionViewTableViewCell {
    internal func addConstraintsCollectionView() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        collectionView.heightAnchor.constraint(equalToConstant: 220).isActive = true
    }
}
