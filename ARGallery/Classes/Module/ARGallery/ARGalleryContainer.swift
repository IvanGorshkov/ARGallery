//
//  ARGalleryContainer.swift
//  ARGallery
//
//  Created by Ivan Gorshkov on 02.04.2022.
//  
//

import UIKit

final class ARGalleryContainer {
    let input: ARGalleryModuleInput
	let viewController: UIViewController
	private(set) weak var router: ARGalleryRouterInput!

	class func assemble(with context: ARGalleryContext) -> ARGalleryContainer {
        let router = ARGalleryRouter()
        let interactor = ARGalleryInteractor()
        let presenter = ARGalleryPresenter(router: router, interactor: interactor)
		let viewController = ARGalleryViewController(output: presenter)

		presenter.view = viewController
        presenter.id = context.id
		presenter.moduleOutput = context.moduleOutput

		interactor.output = presenter

        return ARGalleryContainer(view: viewController, input: presenter, router: router)
	}

    private init(view: UIViewController, input: ARGalleryModuleInput, router: ARGalleryRouterInput) {
		self.viewController = view
        self.input = input
		self.router = router
	}
}

struct ARGalleryContext {
	weak var moduleOutput: ARGalleryModuleOutput?
    var id: Int
}
