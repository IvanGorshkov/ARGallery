//
//  Factory.swift
//  MilliArt
//
//  Created by Alekhin Sergey on 05.11.2021.
//

import Foundation

protocol CreatorForAll {
    func factoryRouter() -> AllRouterInput
    func factoryInteractor() -> AllInteractorInput
}

class GalleriesCreatorForAll: CreatorForAll {
    func factoryRouter() -> AllRouterInput {
        return AllGalleriesRouter()
    }

    func factoryInteractor() -> AllInteractorInput {
        return AllGalleriesInteractor()
    }
}

class ExhibitionsCreatorForAll: CreatorForAll {
    func factoryRouter() -> AllRouterInput {
        return AllExhibitionsRouter()
    }

    func factoryInteractor() -> AllInteractorInput {
        return AllExhibitionsInteractor()
    }
}
