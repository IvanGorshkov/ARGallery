//
//  FavoritePresenter.swift
//  ARGallery
//
//  Created by Ivan Gorshkov on 05.04.2022.
//  
//

import Foundation

final class FavoritePresenter {
	weak var view: FavoriteViewInput?
    weak var moduleOutput: FavoriteModuleOutput?

	private let router: FavoriteRouterInput
	private let interactor: FavoriteInteractorInput
    private var viewModel: VCollectionViewModel?

    init(router: FavoriteRouterInput, interactor: FavoriteInteractorInput) {
        self.router = router
        self.interactor = interactor
    }
}

extension FavoritePresenter: FavoriteModuleInput {
}

extension FavoritePresenter: FavoriteViewOutput {

    func itemSelected(id: Int) {
        self.router.itemSelected(with: self.view, and: interactor.receiveId(with: id))
    }

    func getCellIdentifier(at index: Int) -> String {
        return viewModel?.array[index].cellIdentifier ?? ""
    }

    func viewDidLoad() {
        interactor.loadData()
    }

    func getCell(at index: Int) -> CellIdentifiable? {
        return viewModel?.array[index]
    }

    func getCountCells() -> Int {
        return viewModel?.array.count ?? 0
    }

    func getTitle() -> String {
        return TitlesConstants.FavBarTitle
    }
}

extension FavoritePresenter: FavoriteInteractorOutput {
    func receiveData(data: [Card]) {
        viewModel = VCollectionViewModel(cards: data)
        view?.reloadData()
    }
    
}
