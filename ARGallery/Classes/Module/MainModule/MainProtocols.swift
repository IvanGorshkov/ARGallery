//
//  MainProtocols.swift
//  MilliArt
//
//  Created by Alekhin Sergey on 28.10.2021.
//  
//

protocol MainModuleInput {
	var moduleOutput: MainModuleOutput? { get }
}

protocol MainModuleOutput: AnyObject {
}

protocol MainViewInput: AnyObject {
    func reloadData()
}

protocol TableViewCellOutput: AnyObject {
    func clickAllCompilation()
    func clickAllAuthor()
    func clickOnAuthor(with id: Int)
    func clickOnCompilation(with id: Int)
    func clickOnArt(with id: Int)
}

protocol MainTableViewCellDescription: AnyObject {
    var delegate: TableViewCellOutput? { get set }
}

protocol MainViewOutput: AnyObject {
    func clickOnArt(with id: Int)
    func clickOnMuseum(with id: Int)
    func clickOnExebition(with id: Int)
    func viewDidLoad()
    func getCellHeight(at index: Int) -> Float
    func getCell(at index: Int) -> CellIdentifiable?
    func getCellIdentifier(at index: Int) -> String
    func getCountCells() -> Int
    var  sectionDelegate: TableViewCellOutput? { get set }
    func goToAllCompilation()
    func goToAllAuthor()
}

protocol MainInteractorInput: AnyObject {
    func loadData()
    func receiveId(with index: Int) -> Int
    func receiveExebitionTitle(with index: Int) -> String
    func receiveMuseumTitle(with index: Int) -> String
}

protocol MainInteractorOutput: AnyObject {
    func receiveData(mainResponse: MainResponse)
}

protocol MainRouterInput: AnyObject {
    func itemSelected(with view: MainViewInput?, and id: Int)
    func exebitionSelected(with view: MainViewInput?, title: String, and id: Int)
    func museumSelected(with view: MainViewInput?, title: String, and id: Int)
    func goToAllGallery(with view: MainViewInput?)
    func goToAllExhibition(with view: MainViewInput?)
}

protocol CellIdentifiable {
    var cellIdentifier: String { get }
    var cellHeight: Float { get }
}

protocol SectionRowsRepresentable {
    var rows: [CellIdentifiable] { get set }
}

protocol ModelRepresentable {
    var model: CellIdentifiable? { get set }
}

