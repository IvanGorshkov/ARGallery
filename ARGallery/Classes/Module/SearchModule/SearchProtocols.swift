//
//  SearchProtocols.swift
//  MilliArt
//
//  Created by Alekhin Sergey on 28.10.2021.
//  
//

import Foundation

protocol SearchModuleInput {
	var moduleOutput: SearchModuleOutput? { get }
}

protocol SearchModuleOutput: AnyObject {
}

protocol SearchViewInput: AnyObject {
    func reloadData()
}

protocol SearchViewOutput: AnyObject {
    func goToFilter()
    func enterText(text: String)
    func viewDidLoad()
    func getCell(at index: Int) -> CellIdentifiable?
    func getCountCells() -> Int
    func getCellIdentifier(at index: Int) -> String
    func itemSelected(id: Int)
}

protocol SearchInteractorInput: AnyObject {
    func enterText(text: String)
    func receiveId(with index: Int) -> Int
    func loadData()
}

protocol SearchInteractorOutput: AnyObject {
    func receiveData(data: [PaintCard])
}

protocol SearchRouterInput: AnyObject {
    func itemSelected(with view: SearchViewInput?, and id: Int)
}
