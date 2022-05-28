//
//  GalleriesContainer.swift
//  MilliArt
//
//  Created by Ivan Gorshkov on 01.12.2021.
//  
//

import UIKit

final class GalleriesContainer {
    let input: GalleriesModuleInput
	let viewController: UIViewController
	private(set) weak var router: GalleriesRouterInput!

	class func assemble(with context: GalleriesContext) -> GalleriesContainer {
        let router = GalleriesRouter()
        let interactor = GalleriesInteractor()
        let presenter = GalleriesPresenter(router: router, interactor: interactor)
		let viewController = GalleriesViewController(output: presenter)

		presenter.view = viewController
		presenter.moduleOutput = context.moduleOutput
        presenter.galleriesId = context.id
        presenter.title = context.title
		interactor.output = presenter

        return GalleriesContainer(view: viewController, input: presenter, router: router)
	}

    private init(view: UIViewController, input: GalleriesModuleInput, router: GalleriesRouterInput) {
		self.viewController = view
        self.input = input
		self.router = router
	}
}

struct GalleriesContext {
	weak var moduleOutput: GalleriesModuleOutput?
    var id: Int?
    var title: String?
}
