//
//  AllPresenter.swift
//  MilliArt
//
//  Created by Ivan Gorshkov on 05.11.2021.
//  
//

import Foundation

final class AllPresenter {
	weak var view: AllViewInput?
    weak var moduleOutput: AllModuleOutput?

	private let router: AllRouterInput
	private let interactor: AllInteractorInput
    private var viewModel: HCollectionViewModel?

    init(router: AllRouterInput, interactor: AllInteractorInput) {
        self.router = router
        self.interactor = interactor
    }
}

extension AllPresenter: AllModuleInput {
}

extension AllPresenter: AllViewOutput {
    func enterText(text: String) {
        interactor.enterText(text: text)
    }
    
    func itemSelected(id: Int) {
        router.itemSelected(with: view, title: interactor.receiveTitle(with: id), and: interactor.receiveId(with: id))
    }
    
    func getTitle() -> String {
        return interactor.getTitle()
    }

    func viewDidLoad() {
        interactor.loadData()
    }

    func getCell(at index: Int) -> CellIdentifiable? {
        guard let viewModel = viewModel else { return nil }
        return viewModel.array[index]
    }

    func getCellIdentifier(at index: Int) -> String {
        guard let viewModel = viewModel else { return "" }
        return viewModel.array[index].cellIdentifier
    }

    func getCountCells() -> Int {
        guard let viewModel = viewModel else { return 0 }
        return viewModel.array.count
    }
}

extension AllPresenter: AllInteractorOutput {
    func receiveData(data: [HorizontalViewModel]) {
        viewModel = HCollectionViewModel(array: data)
        view?.reloadData()
    }
}

extension AllPresenter: SegmentedControlDelegate{
    func segmentedControlDidChange(index: Int) {
        guard let interactor = interactor as? SegmentedControlDelegate else {
            return
        }
        interactor.segmentedControlDidChange(index: index)
    }
}
