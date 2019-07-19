//
//  StorageManager.swift
//  Guard
//
//  Created by Denys on 6/30/19.
//  Copyright © 2019 Litvinskii Denis. All rights reserved.
//

import Foundation

final class StorageManager {
    
    static var data: [StorageData] {
        guard let objectsData = UserDefaults.standard.object(forKey: "StorageData") as? Data else {
            return []
        }
        
        let decoder = JSONDecoder()
        guard let objects = try? decoder.decode([StorageData].self, from: objectsData) else {
            return []
        }
        
        return objects
    }
    
    static func save(_ data: StorageData) {
        var objects = StorageManager.data
        objects.append(data)
        StorageManager.save(objects)
    }
    
    static func deleteObject(with objectId: String) {
        var objects = StorageManager.data
        objects.removeAll { $0.id == objectId }
        StorageManager.save(objects)
    }
    
    private static func save(_ objects: [StorageData]) {
        let encoder = JSONEncoder()
        guard let encodedData = try? encoder.encode(objects) else {
            return
        }
        
        UserDefaults.standard.set(encodedData, forKey: "StorageData")
    }
}
