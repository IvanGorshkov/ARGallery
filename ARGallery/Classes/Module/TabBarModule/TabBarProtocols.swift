//
//  TabBarProtocols.swift
//  MilliArt
//
//  Created by Ivan Gorshkov on 28.10.2021.
//  
//

import Foundation
import UIKit

protocol TabBarModuleInput {
	var moduleOutput: TabBarModuleOutput? { get }
}

protocol TabBarModuleOutput: AnyObject {
}

protocol TabBarViewInput: AnyObject {
    func receiveViews(with views: [UIViewController])
}

protocol TabBarViewOutput: AnyObject {
    func getViews()
    func getModel(at index: Int) -> TabBarItemModel
}

protocol TabBarInteractorInput: AnyObject {
    func getTabBarItemsInfo()
}

protocol TabBarInteractorOutput: AnyObject {
    func receiveTabBarItemsInfo(with tabBar: [TabBarItemModel])
}

protocol TabBarRouterInput: AnyObject {
    func getViews() -> [UIViewController]
}
