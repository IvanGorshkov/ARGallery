//
//  VCollectionVTVC+Constraints.swift
//  MilliArt
//
//  Created by Ivan Gorshkov on 04.11.2021.
//

import UIKit

extension AllViewController {
    internal func addConstraintsCollectionView() {
        self.searchBar.translatesAutoresizingMaskIntoConstraints = false
        self.searchBar.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        self.searchBar.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        self.searchBar.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        
        self.collectionView.translatesAutoresizingMaskIntoConstraints = false
        if let segmentControl = self.interfaceSegmented {
            segmentControl.translatesAutoresizingMaskIntoConstraints = false
            
            segmentControl.trailingAnchor.constraint(equalTo: self.searchBar.trailingAnchor, constant: -50).isActive = true
            segmentControl.leadingAnchor.constraint(equalTo: self.searchBar.leadingAnchor, constant: 50).isActive = true
            segmentControl.heightAnchor.constraint(equalToConstant: 30).isActive = true
            segmentControl.topAnchor.constraint(equalTo: self.searchBar.bottomAnchor).isActive = true
            self.collectionView.topAnchor.constraint(equalTo: segmentControl.bottomAnchor).isActive = true
        } else {
        self.collectionView.topAnchor.constraint(equalTo: searchBar.bottomAnchor).isActive = true
        }
        self.collectionView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        self.collectionView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        self.collectionView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        
        self.emptySearchView.translatesAutoresizingMaskIntoConstraints = false
        self.emptySearchView.topAnchor.constraint(equalTo: searchBar.bottomAnchor).isActive = true
        self.emptySearchView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        self.emptySearchView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        self.emptySearchView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
}
