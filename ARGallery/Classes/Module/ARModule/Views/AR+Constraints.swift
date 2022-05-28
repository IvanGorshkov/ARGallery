//
//  AR+Constraints.swift
//  ARGallery
//
//  Created by Ivan Gorshkov on 12.03.2022.
//

import UIKit

extension ARViewController {
    internal func addConstraintsAR() {
        self.sceneView.translatesAutoresizingMaskIntoConstraints = false
        self.sceneView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        self.sceneView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        self.sceneView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        self.sceneView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true

        self.foundLabel.translatesAutoresizingMaskIntoConstraints = false
        self.foundLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        self.foundLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        self.foundLabel.widthAnchor.constraint(equalToConstant: 200).isActive = true
        self.foundLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true

        if self.scanningLabel.isDescendant(of: view) {
            self.scanningLabel.translatesAutoresizingMaskIntoConstraints = false
            self.scanningLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
            self.scanningLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
            self.scanningLabel.widthAnchor.constraint(equalToConstant: 200).isActive = true
            self.scanningLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        }

        self.magicButton.translatesAutoresizingMaskIntoConstraints = false
        self.magicButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20).isActive = true
        self.magicButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -20).isActive = true
        self.magicButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
        self.magicButton.heightAnchor.constraint(equalToConstant: 100).isActive = true
    }
}
