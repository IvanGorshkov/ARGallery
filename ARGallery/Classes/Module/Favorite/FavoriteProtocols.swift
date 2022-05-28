//
//  FavoriteProtocols.swift
//  ARGallery
//
//  Created by Ivan Gorshkov on 05.04.2022.
//  
//

import Foundation

protocol FavoriteModuleInput {
	var moduleOutput: FavoriteModuleOutput? { get }
}

protocol FavoriteModuleOutput: AnyObject {
}

protocol FavoriteViewInput: AnyObject {
    func reloadData()
}

protocol FavoriteViewOutput: AnyObject {
    func viewDidLoad()
    func getCell(at index: Int) -> CellIdentifiable?
    func getCountCells() -> Int
    func getTitle() -> String
    func getCellIdentifier(at index: Int) -> String
    func itemSelected(id: Int)
}

protocol FavoriteInteractorInput: AnyObject {
    func loadData()
    func receiveId(with index: Int) -> Int
}

protocol FavoriteInteractorOutput: AnyObject {
    func receiveData(data: [Card])
}

protocol FavoriteRouterInput: AnyObject {
    func itemSelected(with view: FavoriteViewInput?, and id: Int)
}
