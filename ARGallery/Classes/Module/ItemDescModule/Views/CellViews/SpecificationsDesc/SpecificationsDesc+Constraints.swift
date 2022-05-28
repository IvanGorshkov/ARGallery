//
//  SpecificationsDesc+Constraints.swift
//  MilliArt
//
//  Created by Ivan Gorshkov on 29.10.2021.
//

import UIKit

extension SpecificationsDescCell {
    internal func addConstraintsSpecifications() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: super.leadingAnchor, constant: 20).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 55).isActive = true
        titleLabel.widthAnchor.constraint(equalToConstant: 90).isActive = true

        specification.translatesAutoresizingMaskIntoConstraints = false
        specification.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        specification.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: 20).isActive = true
        specification.heightAnchor.constraint(equalToConstant: 55).isActive = true
        specification.trailingAnchor.constraint(equalTo: super.trailingAnchor, constant: -10).isActive = true
    }
}
