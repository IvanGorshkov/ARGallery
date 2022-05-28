//
//  Request.swift
//  ARGallery
//
//  Created by Ivan Gorshkov on 21.03.2022.
//

import Foundation
import Alamofire

enum HTTPProtocol: String {
    case http
    case https
}

protocol Request {
    associatedtype Content: Decodable
    var `protocol`: HTTPProtocol { get }
    var method: HTTPMethod { get }
    var headers: [String: String]? { get }
    var apiName: String { get }
    var timeout: Int { get }
    var parameters: Parameters { get }
}

extension Request {
    var `protocol`: HTTPProtocol {
        return .http
    }
    
    var timeout: Int {
        return 60
    }
    
    var headers: [String: String]? {
        nil
    }
}
