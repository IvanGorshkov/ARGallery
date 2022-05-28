//
//  HeaderCell+Constraints.swift
//  MilliArt
//
//  Created by Alekhin Sergey on 04.11.2021.
//

import UIKit

extension HeaderCellView {
    internal func addConstraintsHeader() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20).isActive = true

        allButton.translatesAutoresizingMaskIntoConstraints = false
        allButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        allButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0).isActive = true
        allButton.widthAnchor.constraint(equalToConstant: 60).isActive = true
        allButton.heightAnchor.constraint(equalToConstant: 100).isActive = true
    }
}
