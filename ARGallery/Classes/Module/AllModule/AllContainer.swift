//
//  AllContainer.swift
//  MilliArt
//
//  Created by Ivan Gorshkov on 05.11.2021.
//  
//

import UIKit

final class AllContainer {
    let input: AllModuleInput
	let viewController: UIViewController
	private(set) weak var router: AllRouterInput!

	class func assemble(with context: AllContext) -> AllContainer {
        let router = context.creator.factoryRouter()
        let interactor = context.creator.factoryInteractor()
        let presenter = AllPresenter(router: router, interactor: interactor)
        let viewController: AllViewInput
        if let interactor = interactor as? AllExhibitionsInteractor {
            print(interactor)
             viewController = AllViewController(output: presenter, segmentedControlDelegate: presenter)
        } else {
            viewController = AllViewController(output: presenter, segmentedControlDelegate: nil)
        }
		presenter.view = viewController
		presenter.moduleOutput = context.moduleOutput

		interactor.output = presenter

        return AllContainer(view: viewController as! UIViewController, input: presenter, router: router)
	}

    private init(view: UIViewController, input: AllModuleInput, router: AllRouterInput) {
		self.viewController = view
        self.input = input
		self.router = router
	}
}

struct AllContext {
	weak var moduleOutput: AllModuleOutput?
    var creator: CreatorForAll
}
