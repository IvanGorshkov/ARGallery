//
//  SearchResponse.swift
//  ARGallery
//
//  Created by Ivan Gorshkov on 29.03.2022.
//

import Foundation

struct SearchResponse: Decodable {
    var museums: [Museum]?
    var exhibitions: [Exhibition]?
    var pictures: [PaintCard]?
}
