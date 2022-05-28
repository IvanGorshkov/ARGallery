//
//  ExhibitionsPresenter.swift
//  MilliArt
//
//  Created by Ivan Gorshkov on 01.12.2021.
//  
//

import Foundation

final class ExhibitionsPresenter {
	weak var view: ExhibitionsViewInput?
    weak var moduleOutput: ExhibitionsModuleOutput?
    var exhibitionsId: Int?
	private let router: ExhibitionsRouterInput
	private let interactor: ExhibitionsInteractorInput
    var title: String?
    
    private var viewModel: VCollectionViewModel?

    init(router: ExhibitionsRouterInput, interactor: ExhibitionsInteractorInput) {
        self.router = router
        self.interactor = interactor
    }
}

extension ExhibitionsPresenter: ExhibitionsModuleInput {
}

extension ExhibitionsPresenter: ExhibitionsViewOutput {
    func enterText(text: String) {
        interactor.enterText(text: text)
    }
    
    func openDescription() {
        self.router.openDescription(with: view, with: self.interactor.getExhibition())
    }
    
    func itemSelected(id: Int) {
        self.router.itemSelected(with: self.view, and: interactor.receiveId(with: id))
    }
    
    func getCellIdentifier(at index: Int) -> String {
        return viewModel?.array[index].cellIdentifier ?? ""
    }
    
    func viewDidLoad() {
        interactor.loadData(with: exhibitionsId ?? 0)
    }
    
    func getCell(at index: Int) -> CellIdentifiable? {
        return viewModel?.array[index]
    }
    
    func getCountCells() -> Int {
        return viewModel?.array.count ?? 0
    }
    
    func getTitle() -> String {
        return self.title ?? ""
    }
}

extension ExhibitionsPresenter: ExhibitionsInteractorOutput {
    func receiveId() -> Int {
        return exhibitionsId ?? 0
    }
    
    func receiveData(data: [Exhibition]) {
        viewModel = VCollectionViewModel(cards: data)
        view?.reloadData()
    }
}
