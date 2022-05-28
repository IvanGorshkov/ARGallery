//
//  AllGalleriesRequest.swift
//  ARGallery
//
//  Created by Ivan Gorshkov on 21.03.2022.
//

import Foundation
import Alamofire

struct AllGalleriesRequest: AfPerformable {
    var method: HTTPMethod {
        .get
    }
    
    var parameters: Parameters {
        Parameters()
    }
    
    typealias Content = AllGalleriesResponse
    
    var apiName: String {
        Backend.domain + Backend.api + "museums"
    }
}
