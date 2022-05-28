//
//  ItemDescProtocols.swift
//  MilliArt
//
//  Created by Ivan Gorshkov on 28.10.2021.
//  
//

import Foundation
import UIKit

protocol ItemDescModuleInput {
	var moduleOutput: ItemDescModuleOutput? { get }
    var id: Int? { get set }
}

protocol ItemDescModuleOutput: AnyObject {
}

protocol ItemDescCellViewOutput: AnyObject {
    func openFullScreen(silder: UIView)
    func clickFav(isSelected: Bool)
    func clickAR()
}

protocol ItemDescViewInput: AnyObject {
    func updateForSections()
}

protocol ItemDescViewOutput: AnyObject {
    func viewDidLoad()
    func goToAR()
    func clickShare()
    func getCellHeight(at index: Int) -> Float
    func getCell(at index: Int) -> CellIdentifiable?
    func getCellIdentifier(at index: Int) -> String
    func getCountCells() -> Int
    var  sectionDelegate: ItemDescCellViewOutput? { get set }
    func openFullScreen(slider: UIView?)
    func clickFav(isSelected: Bool)
}

protocol ItemDescInteractorInput: AnyObject {
    func loadItemById(with id: Int)
    func loadFirstPhoto()
    func prepareShareData()
    func changeFav(isSelected: Bool)
}

protocol ItemDescInteractorOutput: AnyObject {
    func itemDidLoad(itemDesc: ItemDescResponse)
    func firstPhotoDidLoad(arModel: PaintingARModel)
    func shareDataDidRecive(items: [Any])
}

protocol ItemDescRouterInput: AnyObject {
    func goToAR(from vc: ItemDescViewInput?, arModel: PaintingARModel?)
    func openFullScreen(from vc: ItemDescViewInput?, silder: UIView?)
    func sharePaint(from vc: ItemDescViewInput?, items: [Any])
}
