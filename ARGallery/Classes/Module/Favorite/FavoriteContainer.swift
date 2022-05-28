//
//  FavoriteContainer.swift
//  ARGallery
//
//  Created by Ivan Gorshkov on 05.04.2022.
//  
//

import UIKit

final class FavoriteContainer {
    let input: FavoriteModuleInput
	let viewController: UIViewController
	private(set) weak var router: FavoriteRouterInput!

	class func assemble(with context: FavoriteContext) -> FavoriteContainer {
        let router = FavoriteRouter()
        let interactor = FavoriteInteractor()
        let presenter = FavoritePresenter(router: router, interactor: interactor)
		let viewController = FavoriteViewController(output: presenter)

		presenter.view = viewController
		presenter.moduleOutput = context.moduleOutput

		interactor.output = presenter

        return FavoriteContainer(view: viewController, input: presenter, router: router)
	}

    private init(view: UIViewController, input: FavoriteModuleInput, router: FavoriteRouterInput) {
		self.viewController = view
        self.input = input
		self.router = router
	}
}

struct FavoriteContext {
	weak var moduleOutput: FavoriteModuleOutput?
}
