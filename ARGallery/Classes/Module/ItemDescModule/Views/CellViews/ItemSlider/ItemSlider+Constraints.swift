//
//  ItemSlider+Constraints.swift
//  MilliArt
//
//  Created by Ivan Gorshkov on 29.10.2021.
//

import UIKit

extension ItemSliderCell {
    internal func addConstraintsSlider() {
        slider.translatesAutoresizingMaskIntoConstraints = false
        slider.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        slider.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20).isActive = true
        slider.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        slider.widthAnchor.constraint(equalTo: contentView.widthAnchor, constant: -40).isActive = true
        slider.heightAnchor.constraint(equalToConstant: 350).isActive = true
    }
}
