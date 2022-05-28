//
//  ARGalleryInteractor.swift
//  ARGallery
//
//  Created by Ivan Gorshkov on 02.04.2022.
//  
//

import Foundation
import UIKit
import ARKit

final class ARGalleryInteractor {
	weak var output: ARGalleryInteractorOutput?
    var newReferenceImages: Set<ARReferenceImage> = Set<ARReferenceImage>();
    var result = [ARGalleryResponse]()
}

extension ARGalleryInteractor: ARGalleryInteractorInput {
    func videoSize(name: String) -> (Int, Int) {
        let item = result.filter { item in
            return item.name == name
         }.first
        let res = item?.videoSize?.components(separatedBy: "x").map({ substring in
            return substring.replacingOccurrences(of: " ",
                                                   with: "")
        }).map({ str in
            return Int(str)
        })
        guard let res = res else {
            return (0, 0)
        }
        return (res[0] ?? 0, res[1] ?? 0)
    }
    
    func receiveId(name: String) -> Int {
        let item = result.filter { item in
            return item.name == name
         }.first
         
        return item?.id ?? -1
    }
    
    func linkIfExist(name: String) -> URL? {
       let item = result.filter { item in
           return item.name == name
        }.first
        
        guard let url = item?.video else {
            return nil
        }
        return URL(string: url)
    }
    
    func loadData(with id: Int) {
        ARGalleryRequest(parameters: [
            "exhibitionID": id
        ]).perform { response, err in
            if err != nil {
                return
            }
            guard let response = response else {
                return
            }
            self.result = response
            let count = self.result.count
            var i = 0
            response.forEach { item in
                guard let url =  URL(string: item.picture) else {
                    return
                }
                
                self.loadImageFrom(url: url) { image in
                    i += 1
                    let arImage = ARReferenceImage(
                        image.cgImage!,
                        orientation: CGImagePropertyOrientation.up,
                        physicalWidth: CGFloat(item.pictureSize.width) / CGFloat(100))
                    arImage.name = item.name + "\(item.id)";
                    self.newReferenceImages.insert(arImage);
                    if count == i {
                        self.output?.getImages(newReferenceImages: self.newReferenceImages)
                    }
                }
            }
        }
    }
    
    private func loadImageFrom(url: URL, completionHandler:@escaping(UIImage)->()) {
        DispatchQueue.global().async {
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        completionHandler(image);
                    }
                }
            }
        }
    }
}
