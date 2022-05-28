//
//  SearchPresenter.swift
//  MilliArt
//
//  Created by Alekhin Sergey on 28.10.2021.
//  
//

import Foundation

final class SearchPresenter {
	weak var view: SearchViewInput?
    weak var moduleOutput: SearchModuleOutput?
    private var viewModel: VCollectionViewModel?

	private let router: SearchRouterInput
	private let interactor: SearchInteractorInput

    init(router: SearchRouterInput, interactor: SearchInteractorInput) {
        self.router = router
        self.interactor = interactor
    }
}

extension SearchPresenter: SearchModuleInput {
}

extension SearchPresenter: SearchViewOutput {
    func viewDidLoad() {
        interactor.loadData()
    }
    
    func getCell(at index: Int) -> CellIdentifiable? {
        return viewModel?.array[index]
    }
    
    func getCountCells() -> Int {
        return viewModel?.array.count ?? 0
    }
    
    func getCellIdentifier(at index: Int) -> String {
        return viewModel?.array[index].cellIdentifier ?? ""
    }
    
    func itemSelected(id: Int) {
        self.router.itemSelected(with: self.view, and: interactor.receiveId(with: id))
    }
    
    func enterText(text: String) {
        self.interactor.enterText(text: text)
    }
    
    func goToFilter() {
      //  self.router.goToFilterVC(from: view)
    }
}

extension SearchPresenter: SearchInteractorOutput {
    func receiveData(data: [Card]) {
        viewModel = VCollectionViewModel(cards: data)
        view?.reloadData()
    }
}
