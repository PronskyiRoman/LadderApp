//
//  UserDefaultsStorage.swift
//  LadderApp
//
//  Created by -_- on 02.02.2023.
//

import Foundation

struct UserDefaultsStorage {
    private let storage = UserDefaults.standard
    
    func set<T>(key: UserDefaultsStorageKey, value: T) where T: Codable {
        storage.set(try? JSONEncoder().encode(value), forKey: key.rawValue)
        storage.synchronize()
    }
    
    func get<T>(key: UserDefaultsStorageKey, defaultValue: T) -> T where T: Decodable {
        guard let data = storage.object(forKey: key.rawValue) as? Data else { return defaultValue }
        return (try? JSONDecoder().decode(T.self, from: data)) ?? defaultValue
    }
    
    func removeValue(forKey: UserDefaultsStorageKey) {
        storage.setValue(nil, forKey: forKey.rawValue)
    }
    
    func clearStorage() {
        UserDefaultsStorageKey.allCases.forEach({ storage.setValue(nil, forKey: $0.rawValue) })
    }
}
