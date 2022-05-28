//
//  AllProtocols.swift
//  MilliArt
//
//  Created by Ivan Gorshkov on 05.11.2021.
//  
//

import Foundation

protocol SegmentedControlDelegate: AnyObject {
    func segmentedControlDidChange(index: Int)
}

protocol SearchPresenterProtocol: AnyObject {
     func enterText(text: String)
}

protocol SearchInteractorProtocol: AnyObject {
    func enterText(text: String)
}

protocol AllModuleInput {
	var moduleOutput: AllModuleOutput? { get }
}

protocol AllModuleOutput: AnyObject {
}

protocol AllViewInput: AnyObject {
    func reloadData()
    var segmentedControlDelegate: SegmentedControlDelegate? { get set }
}

protocol AllViewOutput: SearchPresenterProtocol {
    func viewDidLoad()
    func getCell(at index: Int) -> CellIdentifiable?
    func getCountCells() -> Int
    func getTitle() -> String
    func itemSelected(id: Int)
}

protocol AllInteractorInput: SearchInteractorProtocol {
    func loadData()
    func getTitle() -> String
    func receiveId(with index: Int) -> Int
    func receiveTitle(with index: Int) -> String
    var output: AllInteractorOutput? { get set }
}

protocol AllInteractorOutput: AnyObject {
    func receiveData(data: [HorizontalViewModel])
}

protocol AllRouterInput: AnyObject {
    func itemSelected(with view: AllViewInput?, title: String, and id: Int)
}
