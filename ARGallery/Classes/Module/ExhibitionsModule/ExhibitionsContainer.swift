//
//  CompilationContainer.swift
//  MilliArt
//
//  Created by Ivan Gorshkov on 01.12.2021.
//  
//

import UIKit

final class ExhibitionsContainer {
    let input: ExhibitionsModuleInput
	let viewController: UIViewController
	private(set) weak var router: ExhibitionsRouterInput!

	class func assemble(with context: ExhibitionsContext) -> ExhibitionsContainer {
        let router = ExhibitionsRouter()
        let interactor = ExhibitionsInteractor()
        let presenter = ExhibitionsPresenter(router: router, interactor: interactor)
		let viewController = ExhibitionsViewController(output: presenter)

		presenter.view = viewController
		presenter.moduleOutput = context.moduleOutput
        presenter.exhibitionsId = context.id
        presenter.title = context.title
		interactor.output = presenter

        return ExhibitionsContainer(view: viewController, input: presenter, router: router)
	}

    private init(view: UIViewController, input: ExhibitionsModuleInput, router: ExhibitionsRouterInput) {
		self.viewController = view
        self.input = input
		self.router = router
	}
}

struct ExhibitionsContext {
	weak var moduleOutput: ExhibitionsModuleOutput?
    var id: Int?
    var title: String?
}
