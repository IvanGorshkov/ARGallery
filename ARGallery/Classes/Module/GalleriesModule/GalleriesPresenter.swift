//
//  GalleriesPresenter.swift
//  MilliArt
//
//  Created by Ivan Gorshkov on 01.12.2021.
//  
//

import Foundation

final class GalleriesPresenter {
	weak var view: GalleriesViewInput?
    weak var moduleOutput: GalleriesModuleOutput?
    var galleriesId: Int?
	private let router: GalleriesRouterInput
	private let interactor: GalleriesInteractorInput
    var title: String?
    
    private var viewModel: HCollectionViewModel?

    init(router: GalleriesRouterInput, interactor: GalleriesInteractorInput) {
        self.router = router
        self.interactor = interactor
    }
}

extension GalleriesPresenter: GalleriesModuleInput {
}

extension GalleriesPresenter: GalleriesViewOutput {
    func enterText(text: String) {
        interactor.enterText(text: text)
    }
    
    func openDescription() {
        self.router.openDescription(with: self.view, with: interactor.getExhibition())
    }
    
    func itemSelected(id: Int) {
        self.router.itemSelected(with: self.view, and: interactor.receiveId(with: id), title: interactor.receiveTitle(with: id))
    }

    func getCellIdentifier(at index: Int) -> String {
        return "AllCollectionViewCell"
    }
    
    func viewDidLoad() {
        interactor.loadData(with: galleriesId ?? 0)
    }

    func getCell(at index: Int) -> CellIdentifiable? {
        guard let viewModel = viewModel else { return nil }
        return viewModel.array[index]
    }

    func getCountCells() -> Int {
        guard let viewModel = viewModel else { return 0 }
        return viewModel.array.count
    }
    
    func getTitle() -> String {
        return self.title ?? ""
    }
}

extension GalleriesPresenter: GalleriesInteractorOutput {
    func receiveId() -> Int {
        return galleriesId ?? 0
    }
    
    func receiveData(data: [Exhibition]) {
        
        viewModel = HCollectionViewModel(array: data.map({ item in
            return HorizontalViewModel(card: item)
        }))
        view?.reloadData()
    }
}
