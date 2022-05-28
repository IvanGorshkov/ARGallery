//
//  FavStorage.swift
//  ARGallery
//
//  Created by Ivan Gorshkov on 05.04.2022.
//

import Foundation

final class FavStorage {
    let storage = UserDefaults.standard
    let key = "favorite_key"
    
    func isExist(id: Int) -> Bool {
        let array = getArray()
        return array.contains(id)
    }
    
    func add(id: Int) {
        var array = getArray()
        array.append(id)
        storage.set(array, forKey: key)
    }
    
    func remove(id: Int) {
        var array = getArray()
        array = array.filter { item in
            item != id
        }
        storage.set(array, forKey: key)
    }
    
    func getAllIds() -> [Int] {
        return getArray()
    }
    
    private func getArray() -> [Int] {
        let array = storage.array(forKey: key)
        guard let array = array as? [Int] else {
            return []
        }
        return array
    }
}
