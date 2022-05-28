//
//  ExhibitionsResponse.swift
//  ARGallery
//
//  Created by Ivan Gorshkov on 21.03.2022.
//

import Foundation

struct ExhibitionsResponse: Decodable {
    let name: String
    let description: String?
    let picture: String
    let id: Int
    let info: [Info]?
    var content: [Exhibition]?
}
