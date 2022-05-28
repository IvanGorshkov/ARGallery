//
//  ItemDescResponse.swift
//  ARGallery
//
//  Created by Ivan Gorshkov on 21.03.2022.
//

import Foundation

struct ItemDescResponse: Decodable {
    let id: Int
    let name: String
    let picture: String
    let descr: String?
    let pictureSize: PictureSize?
    let info: [Info]?
    var isSelected: Bool?
}
struct Info: Decodable {
    let type: String
    let value: String
}


struct Specifications: Decodable {
    let author: String
    let technique: String
    let year: String
}
