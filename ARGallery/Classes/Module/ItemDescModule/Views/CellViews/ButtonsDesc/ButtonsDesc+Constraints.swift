//
//  ButtonsDesc+Constraints.swift
//  MilliArt
//
//  Created by Ivan Gorshkov on 29.10.2021.
//

import UIKit

extension ButtonsDescCell {
    internal func addConstraints() {
        arButton.translatesAutoresizingMaskIntoConstraints = false
        arButton.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        arButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10).isActive = true
        arButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        arButton.widthAnchor.constraint(equalToConstant: 80).isActive = true
        
        favButton.translatesAutoresizingMaskIntoConstraints = false
        favButton.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        favButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10).isActive = true
        favButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        favButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
    }
}
