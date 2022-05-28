//
//  ARProtocols.swift
//  ARGallery
//
//  Created by Ivan Gorshkov on 12.03.2022.
//

import UIKit

protocol ARModuleInput {
	var moduleOutput: ARModuleOutput? { get }
    var arViewModel: ARViewModelDescription? { get set }
}

protocol ARModuleOutput: AnyObject {
}

protocol ARViewInput: AnyObject {
    func runSession()
    func loadModel(arModel: ARViewModelDescription?)
}

protocol ARViewOutput: AnyObject {
    func viewDidLoad()
    func openEditFrame()
    func getARViewModel() -> ARViewModelDescription?
}

protocol ARInteractorInput: AnyObject {
}

protocol ARInteractorOutput: AnyObject {
}

protocol ARRouterInput: AnyObject {
}

protocol ARViewModelDescription: AnyObject {
    var ARpic: UIImage { get }
    var ARwidth: CGFloat { get }
    var ARheight: CGFloat { get }
    var ARborderThickness: (h: CGFloat, w: CGFloat) { get set }
    var ARborderRounded: CGFloat { get set }
    var ARmaterial: String { get set }
    var ARmaterialColor: String { get }
    func copy() -> ARViewModelDescription
}
