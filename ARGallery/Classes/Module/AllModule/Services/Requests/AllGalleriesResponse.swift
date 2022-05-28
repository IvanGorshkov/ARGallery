//
//  AllGalleriesResponse.swift
//  ARGallery
//
//  Created by Ivan Gorshkov on 21.03.2022.
//

import Foundation

struct AllGalleriesResponse: Decodable {
    var items: [Museum]?
}
