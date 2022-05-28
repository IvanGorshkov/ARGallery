//
//  OnboardingStorage.swift
//  ARGallery
//
//  Created by Ivan Gorshkov on 08.05.2022.
//

import Foundation

final class OnboardingStorage {
    let storage = UserDefaults.standard
    var key = ""
    
    func isExist() -> Bool {
        let isShown = storage.bool(forKey: key)
        return isShown
    }
    
    func shown() {
        storage.set(true, forKey: key)
    }
}
