//
//  ARPresenter.swift
//  ARGallery
//
//  Created by Ivan Gorshkov on 12.03.2022.
//

import Foundation

final class ARPresenter {
	weak var view: ARViewInput?
    weak var moduleOutput: ARModuleOutput?

    var arViewModel: ARViewModelDescription?
	private let router: ARRouterInput
	private let interactor: ARInteractorInput

    init(router: ARRouterInput, interactor: ARInteractorInput) {
        self.router = router
        self.interactor = interactor
    }
}

extension ARPresenter: ARModuleInput {
}

extension ARPresenter: ARViewOutput {
    func getARViewModel() -> ARViewModelDescription? {
        guard let arViewModel = arViewModel else { return nil }
        return arViewModel
    }

    func openEditFrame() {
    }

    func viewDidLoad() {
        view?.loadModel(arModel: arViewModel)
    }
}

extension ARPresenter: ARInteractorOutput {
}
