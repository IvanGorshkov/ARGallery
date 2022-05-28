//
//  AlamofireNetwork.swift
//  ARGallery
//
//  Created by Ivan Gorshkov on 19.03.2022.
//

import Foundation
import Alamofire


protocol AfPerformable: Request {}

extension AfPerformable {
    func perform(completion: @escaping  (Content?, NSError?) -> Void) {
        let afPerformer = AfPerformer()
        afPerformer.perform(self, completion: { data, err in
            if let err = err {
                completion(nil, err)
                return
            }
            guard let data = data else {
                completion(nil, err)
                return
            }
            do {
                let res = try JSONDecoder().decode(Content.self, from: data)
                completion(res, res == nil ? NSError(domain: "nil", code: 1) : nil)
            } catch {
                completion(nil, err)
            }
        })
    }
}

class AfPerformer {
    func perform<R>(_ request: R, completion: @escaping  ((Data?, NSError?) -> Void)) where R: Request {
        AF.request("\(request.protocol)://\(request.apiName)",
                   method: request.method,
                   parameters: request.parameters
        ).validate(statusCode: 200..<300).response { response in
            switch response.result {
                case .failure(let error):
                    completion(nil, error as NSError)
                case.success(let data):
                    completion(data, nil)
            }
        }
    }
}
