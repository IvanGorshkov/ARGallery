//
//  ARGalleryPresenter.swift
//  ARGallery
//
//  Created by Ivan Gorshkov on 02.04.2022.
//  
//

import ARKit

final class ARGalleryPresenter {
	weak var view: ARGalleryViewInput?
    weak var moduleOutput: ARGalleryModuleOutput?

	private let router: ARGalleryRouterInput
	private let interactor: ARGalleryInteractorInput
    var id: Int? {
        didSet {
            interactor.loadData(with: id ?? 0)
        }
    }
    init(router: ARGalleryRouterInput, interactor: ARGalleryInteractorInput) {
        self.router = router
        self.interactor = interactor
    }
}

extension ARGalleryPresenter: ARGalleryModuleInput {
}
extension ARGalleryPresenter: ARGalleryViewOutput {
    func videoSize(name: String) -> (Int, Int) {
        return interactor.videoSize(name: name)
    }
    
    func openPainting(name: String) {
        router.itemSelected(with: view, id: interactor.receiveId(name: name))
    }
    
    func linkIfExist(name: String) -> URL? {
       return interactor.linkIfExist(name: name)
    }
}

extension ARGalleryPresenter: ARGalleryInteractorOutput {
    func getImages(newReferenceImages: Set<ARReferenceImage>) {
        view?.getImages(newReferenceImages: newReferenceImages)
    }
}
