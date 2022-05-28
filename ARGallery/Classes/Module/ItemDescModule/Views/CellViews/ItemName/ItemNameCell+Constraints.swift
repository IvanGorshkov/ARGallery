//
//  ItemNameCell+Constraints.swift
//  MilliArt
//
//  Created by Ivan Gorshkov on 29.10.2021.
//

import UIKit

extension ItemNameCell {
    internal func addConstraintsName() {
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
        nameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10).isActive = true
        nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
        
        arButton.translatesAutoresizingMaskIntoConstraints = false
        arButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0).isActive = true
        arButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10).isActive = true
        arButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        arButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
        
        nameLabel.trailingAnchor.constraint(equalTo: arButton.leadingAnchor, constant: -20).isActive = true
    }
}
