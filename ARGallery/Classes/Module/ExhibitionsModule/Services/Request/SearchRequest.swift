//
//  SearchRequest.swift
//  ARGallery
//
//  Created by Ivan Gorshkov on 29.03.2022.
//

import Foundation
import Alamofire

struct SearchRequest: AfPerformable {
    var method: HTTPMethod {
        .get
    }
    
    var parameters: Parameters
    typealias Content = SearchResponse
    
    var apiName: String {
        Backend.domain + Backend.api + "search"
    }
}
