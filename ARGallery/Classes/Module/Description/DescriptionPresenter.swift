//
//  DescriptionPresenter.swift
//  ARGallery
//
//  Created by Ivan Gorshkov on 24.03.2022.
//  
//

import UIKit

final class DescriptionPresenter {
	weak var view: DescriptionViewInput?
    weak var moduleOutput: DescriptionModuleOutput?
    var descriptionEntity: DescriptionEntity?
	private let router: DescriptionRouterInput
	private let interactor: DescriptionInteractorInput
    private var itemDescSectionModel: ItemDescSectionModel?

    init(router: DescriptionRouterInput, interactor: DescriptionInteractorInput) {
        self.router = router
        self.interactor = interactor
    }
}

extension DescriptionPresenter: DescriptionModuleInput {

}

extension DescriptionPresenter: DescriptionViewOutput {
    func openFullScreen(slider: UIView?) {
        router.openFullScreen(from: view, silder: slider)
    }

    var sectionDelegate: ItemDescCellViewOutput? {
        get {
            guard let itemDescSectionModel = itemDescSectionModel else { return nil }
            return itemDescSectionModel.delegate
        }
        set {
            itemDescSectionModel?.delegate = newValue
        }
    }

    func getCountCells() -> Int {
        guard let itemDescSectionModel = itemDescSectionModel else { return 0 }
        return itemDescSectionModel.rows.count
    }

    func getCellIdentifier(at index: Int) -> String {
        guard let itemDescSectionModel = itemDescSectionModel else { return "" }
        return itemDescSectionModel.rows[index].cellIdentifier
    }

    func getCell(at index: Int) -> CellIdentifiable? {
        guard let itemDescSectionModel = itemDescSectionModel else { return nil }
        return itemDescSectionModel.rows[index]
    }

    func getCellHeight(at index: Int) -> Float {
        guard let itemDescSectionModel = itemDescSectionModel else { return 0 }
        return itemDescSectionModel.rows[index].cellHeight
    }

    func goToAR() {
        router.openAR(from: view, id: descriptionEntity?.id ?? 0)
    }

    func viewDidLoad() {
        guard let descriptionEntity = descriptionEntity else { return }
        self.itemDescSectionModel = ItemDescSectionModel(descriptionEntity)
        view?.updateForSections()
    }
}

extension DescriptionPresenter: DescriptionInteractorOutput {
}
