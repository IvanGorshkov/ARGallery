//
//  EmptyCart+Constraints.swift
//  MilliArt
//
//  Created by Ivan Gorshkov on 08.11.2021.
//

import UIKit

extension EmptyCartView {
    func addViewConstraints() {
        self.title.translatesAutoresizingMaskIntoConstraints = false
        self.subTitle.translatesAutoresizingMaskIntoConstraints = false
        self.imageView.translatesAutoresizingMaskIntoConstraints = false
        
        self.title.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        self.title.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        self.title.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        
        self.subTitle.topAnchor.constraint(equalTo: self.title.bottomAnchor, constant: 10).isActive = true
        self.subTitle.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        self.subTitle.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        
        self.imageView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        self.imageView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        self.imageView.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
    }
}
