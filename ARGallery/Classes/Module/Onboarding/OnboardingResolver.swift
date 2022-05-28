//
//  OnboardingResolver.swift
//  ARGallery
//
//  Created by Ivan Gorshkov on 08.05.2022.
//

import Foundation

protocol OnboardingResolver: AnyObject {
    var storageName: String { get set }
    func needToShow(complition: ((_ isNeeded: Bool) -> Void))
}

class OnboardingResolverImpl: OnboardingResolver {
    var storageName: String = ""
    
    func needToShow(complition: ((_ isNeeded: Bool) -> Void)) {
        let storage = OnboardingStorage()
        storage.key = storageName
        if storage.isExist() {
            complition(false)
        } else {
            storage.shown()
            complition(true)
        }
    }
}
