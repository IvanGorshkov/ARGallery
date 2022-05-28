//
//  TabBarInteractor.swift
//  MilliArt
//
//  Created by Ivan Gorshkov on 28.10.2021.
//  
//

import Foundation

final class TabBarInteractor {
	weak var output: TabBarInteractorOutput?
}

extension TabBarInteractor: TabBarInteractorInput {
    func getTabBarItemsInfo() {
        output?.receiveTabBarItemsInfo(with: [
            TabBarItemModel(image: "MainTabBar", title: TitlesConstants.MainBarTitle, selectedImage: "MainTabBar"),
            TabBarItemModel(image: "paintpalette", title: TitlesConstants.SearchBarTitle, selectedImage: "paintpalette"),
            TabBarItemModel(image: "fav_tab", title: TitlesConstants.FavBarTitle, selectedImage: "fav_fill_tab"),
            ]
        )
    }
}
