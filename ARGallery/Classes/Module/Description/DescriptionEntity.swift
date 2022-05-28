//
//  DescriptionEntity.swift
//  ARGallery
//
//  Created by Ivan Gorshkov on 25.03.2022.
//

import Foundation

struct DescriptionEntity {
    let name: String
    let description: String
    let picture: String
    let info: [Info]
    let isAction: Bool
    let id: Int
    
    init(with gallery: GalleriesResponse) {
        self.name = gallery.name
        self.description = gallery.descr ?? ""
        self.picture = gallery.picture
        self.info = gallery.info ?? []
        isAction = false
        self.id = -1
    }
    
    init(with gallery: ExhibitionsResponse) {
        self.name = gallery.name
        self.description = gallery.description ?? ""
        self.picture = gallery.picture
        self.info = gallery.info ?? []
        self.id = gallery.id
        isAction =     true
    }
}
