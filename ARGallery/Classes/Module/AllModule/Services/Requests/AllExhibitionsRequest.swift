//
//  AllExhibitionsRequest.swift
//  ARGallery
//
//  Created by Ivan Gorshkov on 21.03.2022.
//

import Foundation
import Alamofire

struct AllExhibitionsRequest: AfPerformable {
    var method: HTTPMethod {
        .get
    }
    
    var parameters: Parameters {
        Parameters()
    }
    
    typealias Content = AllExhibitionsResponse
    
    var apiName: String {
        Backend.domain + Backend.api + "exhibitions"
    }
}
