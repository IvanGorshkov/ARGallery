//
//  MainPresenter.swift
//  MilliArt
//
//  Created by Alekhin Sergey on 28.10.2021.
//  
//

import Foundation

final class MainPresenter {
	weak var view: MainViewInput?
    weak var moduleOutput: MainModuleOutput?

	private let router: MainRouterInput
	private let interactor: MainInteractorInput
    private var mainSectionViewModel: MainSectionViewModel?

    init(router: MainRouterInput, interactor: MainInteractorInput) {
        self.router = router
        self.interactor = interactor
    }
}

extension MainPresenter: MainModuleInput {
}

extension MainPresenter: MainViewOutput {
    func clickOnMuseum(with id: Int) {
        guard let compilation = mainSectionViewModel?.rows[1] as?  HCollectionViewModel else { return }
        router.museumSelected(with: view, title: interactor.receiveMuseumTitle(with: id), and: compilation.array[id].id)
    }
    
    func clickOnExebition(with id: Int) {
        guard let compilation = mainSectionViewModel?.rows[3] as?  HCollectionViewModel else { return }
        router.exebitionSelected(with: view, title: interactor.receiveExebitionTitle(with: id), and: compilation.array[id].id)
    }
    
    func clickOnArt(with id: Int) {
        router.itemSelected(with: view, and: interactor.receiveId(with: id))
    }
    
    func goToAllAuthor() {
        router.goToAllExhibition(with: view)
    }

    func goToAllCompilation() {
        router.goToAllGallery(with: view)
    }

    func viewDidLoad() {
        interactor.loadData()
        mainSectionViewModel = MainSectionViewModel()
    }

    func getCellHeight(at index: Int) -> Float {
        guard let mainSectionViewModel = mainSectionViewModel else { return -1 }
        return mainSectionViewModel.rows[index].cellHeight
    }

    func getCell(at index: Int) -> CellIdentifiable? {
        guard let mainSectionViewModel = mainSectionViewModel else { return nil }
        return mainSectionViewModel.rows[index]
    }

    func getCellIdentifier(at index: Int) -> String {
        guard let mainSectionViewModel = mainSectionViewModel else { return "" }
        return mainSectionViewModel.rows[index].cellIdentifier
    }

    func getCountCells() -> Int {
        guard let mainSectionViewModel = mainSectionViewModel else { return 0 }
        return mainSectionViewModel.rows.count
    }

    var sectionDelegate: TableViewCellOutput? {
        get {
            guard let mainSectionViewModel = mainSectionViewModel else { return nil }
            return mainSectionViewModel.actions
        }
        set {
            mainSectionViewModel?.actions = newValue
        }
    }
}

extension MainPresenter: MainInteractorOutput {
    func receiveData(mainResponse: MainResponse) {
        mainSectionViewModel?.fillData(mainResponse: mainResponse)
        view?.reloadData()
    }
}
