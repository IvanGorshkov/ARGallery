//
//  ExhibitionsRequest.swift
//  ARGallery
//
//  Created by Ivan Gorshkov on 21.03.2022.
//

import Foundation
import Alamofire

struct ExhibitionsRequest: AfPerformable {
    var method: HTTPMethod {
        .get
    }
    
    var parameters: Parameters {
        Parameters()
    }
    
    typealias Content = ExhibitionsResponse
    
    var apiName: String {
        Backend.domain + Backend.api + "exhibitions/\(id)"
    }
    
    private let id: Int
    
    init(id: Int) {
        self.id = id
    }
}
