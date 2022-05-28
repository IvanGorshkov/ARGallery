//
//  ItemDescContainer.swift
//  MilliArt
//
//  Created by Ivan Gorshkov on 28.10.2021.
//  
//

import UIKit

final class ItemDescContainer {
    let input: ItemDescModuleInput
	let viewController: UIViewController
	private(set) weak var router: ItemDescRouterInput!

	class func assemble(with context: ItemDescContext) -> ItemDescContainer {
        let router = ItemDescRouter()
        let interactor = ItemDescInteractor()
        let presenter = ItemDescPresenter(router: router, interactor: interactor)
		let viewController = ItemDescViewController(output: presenter)

		presenter.view = viewController
		presenter.moduleOutput = context.moduleOutput
        presenter.id = context.id

		interactor.output = presenter

        return ItemDescContainer(view: viewController, input: presenter, router: router)
	}

    private init(view: UIViewController, input: ItemDescModuleInput, router: ItemDescRouterInput) {
		self.viewController = view
        self.input = input
		self.router = router
	}
}

struct ItemDescContext {
	weak var moduleOutput: ItemDescModuleOutput?
    var id: Int
}
