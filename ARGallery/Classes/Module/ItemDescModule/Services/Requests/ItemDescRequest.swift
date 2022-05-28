//
//  ItemDescRequest.swift
//  ARGallery
//
//  Created by Ivan Gorshkov on 21.03.2022.
//

import Foundation
import Alamofire

struct ItemDescRequest: AfPerformable {
    var method: HTTPMethod {
        .get
    }
    
    var parameters: Parameters {
        Parameters()
    }
    
    typealias Content = ItemDescResponse
    
    var apiName: String {
        Backend.domain + Backend.api + "pictures/\(id)"
    }
    
    private let id: Int
    
    init(id: Int) {
        self.id = id
    }
}
