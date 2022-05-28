//
//  DescriptionProtocols.swift
//  ARGallery
//
//  Created by Ivan Gorshkov on 24.03.2022.
//  
//

import UIKit

protocol DescriptionModuleInput {
	var moduleOutput: DescriptionModuleOutput? { get }
    var descriptionEntity: DescriptionEntity? { get }
}

protocol DescriptionModuleOutput: AnyObject {
}

protocol DescriptionViewInput: AnyObject {
    func updateForSections()
}

protocol DescriptionViewOutput: AnyObject {
    func viewDidLoad()
    func goToAR()
    func getCellHeight(at index: Int) -> Float
    func getCell(at index: Int) -> CellIdentifiable?
    func getCellIdentifier(at index: Int) -> String
    func getCountCells() -> Int
    var  sectionDelegate: ItemDescCellViewOutput? { get set }
    func openFullScreen(slider: UIView?)
}

protocol DescriptionInteractorInput: AnyObject {
}

protocol DescriptionInteractorOutput: AnyObject {
}

protocol DescriptionRouterInput: AnyObject {
    func openFullScreen(from vc: DescriptionViewInput?, silder: UIView?)
    func openAR(from vc: DescriptionViewInput?, id: Int)
}
