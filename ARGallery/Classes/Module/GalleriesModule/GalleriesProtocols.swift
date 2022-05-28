//
//  GalleriesProtocols.swift
//  MilliArt
//
//  Created by Ivan Gorshkov on 01.12.2021.
//  
//

import Foundation

protocol GalleriesModuleInput {
	var moduleOutput: GalleriesModuleOutput? { get }
    var galleriesId: Int? { get set }
    var title: String? { get set }
}

protocol GalleriesModuleOutput: AnyObject {
}

protocol GalleriesViewInput: AnyObject {
    func reloadData()
}

protocol GalleriesViewOutput: SearchPresenterProtocol {
    func viewDidLoad()
    func getCell(at index: Int) -> CellIdentifiable?
    func getCountCells() -> Int
    func getTitle() -> String
    func openDescription()
    func getCellIdentifier(at index: Int) -> String
    func itemSelected(id: Int)
}

protocol GalleriesInteractorInput: SearchPresenterProtocol {
    func loadData(with id: Int)
    func receiveId(with index: Int) -> Int
    func receiveTitle(with index: Int) -> String
    func getExhibition() -> GalleriesResponse?
}

protocol GalleriesInteractorOutput: AnyObject {
    func receiveData(data: [Exhibition])
    func receiveId() -> Int
}

protocol GalleriesRouterInput: AnyObject {
    func itemSelected(with view: GalleriesViewInput?, and id: Int, title: String)
    func openDescription(with view: GalleriesViewInput?, with exhibition: GalleriesResponse?)
}
