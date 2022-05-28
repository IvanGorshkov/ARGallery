//
//  ExhibitionsProtocols.swift
//  MilliArt
//
//  Created by Ivan Gorshkov on 01.12.2021.
//  
//

import Foundation

protocol ExhibitionsModuleInput {
	var moduleOutput: ExhibitionsModuleOutput? { get }
    var exhibitionsId: Int? { get set }
    var title: String? { get set }
}

protocol ExhibitionsModuleOutput: AnyObject {
}

protocol ExhibitionsViewInput: AnyObject {
    func reloadData()
}

protocol ExhibitionsViewOutput: SearchPresenterProtocol {
    func openDescription()
    func viewDidLoad()
    func getCell(at index: Int) -> CellIdentifiable?
    func getCountCells() -> Int
    func getTitle() -> String
    func getCellIdentifier(at index: Int) -> String
    func itemSelected(id: Int)
}

protocol ExhibitionsInteractorInput: SearchPresenterProtocol {
    func loadData(with id: Int)
    func receiveId(with index: Int) -> Int
    func getExhibition() -> ExhibitionsResponse?
}

protocol ExhibitionsInteractorOutput: AnyObject {
    func receiveData(data: [Exhibition])
    func receiveId() -> Int
}

protocol ExhibitionsRouterInput: AnyObject {
    func itemSelected(with view: ExhibitionsViewInput?, and id: Int)
    func openDescription(with view: ExhibitionsViewInput?, with exhibition: ExhibitionsResponse?)
}
