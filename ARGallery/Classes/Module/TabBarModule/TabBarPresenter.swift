//
//  TabBarPresenter.swift
//  MilliArt
//
//  Created by Ivan Gorshkov on 28.10.2021.
//  
//

import Foundation
import UIKit

final class TabBarPresenter {
	weak var view: TabBarViewInput?
    weak var moduleOutput: TabBarModuleOutput?

	private let router: TabBarRouterInput
	private let interactor: TabBarInteractorInput
    private var tabBars: [TabBarItemModel] = []

    init(router: TabBarRouterInput, interactor: TabBarInteractorInput) {
        self.router = router
        self.interactor = interactor
    }
}

extension TabBarPresenter: TabBarModuleInput {
}

extension TabBarPresenter: TabBarViewOutput {
    func getModel(at index: Int) -> TabBarItemModel {
        return self.tabBars[index]
    }

    func getViews() {
        interactor.getTabBarItemsInfo()
    }
}

extension TabBarPresenter: TabBarInteractorOutput {
    func receiveTabBarItemsInfo(with tabBar: [TabBarItemModel]) {
        self.tabBars = tabBar
        let views = self.router.getViews()
        self.view?.receiveViews(with: views)
    }
}
