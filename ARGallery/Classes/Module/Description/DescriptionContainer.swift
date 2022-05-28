//
//  DescriptionContainer.swift
//  ARGallery
//
//  Created by Ivan Gorshkov on 24.03.2022.
//  
//

import UIKit

final class DescriptionContainer {
    let input: DescriptionModuleInput
	let viewController: UIViewController
	private(set) weak var router: DescriptionRouterInput!

	class func assemble(with context: DescriptionContext) -> DescriptionContainer {
        let router = DescriptionRouter()
        let interactor = DescriptionInteractor()
        let presenter = DescriptionPresenter(router: router, interactor: interactor)
		let viewController = DescriptionViewController(output: presenter)
        presenter.descriptionEntity = context.entity
		presenter.view = viewController
		presenter.moduleOutput = context.moduleOutput

		interactor.output = presenter

        return DescriptionContainer(view: viewController, input: presenter, router: router)
	}

    private init(view: UIViewController, input: DescriptionModuleInput, router: DescriptionRouterInput) {
		self.viewController = view
        self.input = input
		self.router = router
	}
}

struct DescriptionContext {
	weak var moduleOutput: DescriptionModuleOutput?
    var entity: DescriptionEntity
}
