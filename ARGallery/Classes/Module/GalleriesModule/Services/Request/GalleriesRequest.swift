//
//  ExhibitionsRequest.swift
//  ARGallery
//
//  Created by Ivan Gorshkov on 21.03.2022.
//

import Foundation
import Alamofire

struct GalleriesRequest: AfPerformable {
    var method: HTTPMethod {
        .get
    }
    
    var parameters: Parameters {
        Parameters()
    }
    
    typealias Content = GalleriesResponse
    
    var apiName: String {
        Backend.domain + Backend.api + "museums/\(id)"
    }
    
    private let id: Int
    
    init(id: Int) {
        self.id = id
    }
}
