//
//  ARGalleryProtocols.swift
//  ARGallery
//
//  Created by Ivan Gorshkov on 02.04.2022.
//  
//

import ARKit

protocol ARGalleryModuleInput {
	var moduleOutput: ARGalleryModuleOutput? { get }
    var id: Int? { get }
}

protocol ARGalleryModuleOutput: AnyObject {
}

protocol ARGalleryViewInput: AnyObject {
    func getImages(newReferenceImages: Set<ARReferenceImage>)
}

protocol ARGalleryViewOutput: AnyObject {
    func linkIfExist(name: String) -> URL?
    func openPainting(name: String)
    func videoSize(name: String) -> (Int, Int)
}

protocol ARGalleryInteractorInput: AnyObject {
    func loadData(with id: Int)
    func linkIfExist(name: String) -> URL?
    func receiveId(name: String) -> Int
    func videoSize(name: String) -> (Int, Int)
}

protocol ARGalleryInteractorOutput: AnyObject {
    func getImages(newReferenceImages: Set<ARReferenceImage>)
}

protocol ARGalleryRouterInput: AnyObject {
    func itemSelected(with view: ARGalleryViewInput?, id: Int)
}
