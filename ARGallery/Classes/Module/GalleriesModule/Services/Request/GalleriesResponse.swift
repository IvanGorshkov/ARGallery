//
//  ExhibitionsResponse.swift
//  ARGallery
//
//  Created by Ivan Gorshkov on 21.03.2022.
//

import Foundation

struct GalleriesResponse: Decodable {
    let name: String
    let descr: String?
    let picture: String
    let info: [Info]?
    var exhibitions: [Museum]?
}
