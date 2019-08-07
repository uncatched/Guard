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

// MARK: - Zip
extension StorageManager {
    
    static var zipData: [ZipFile] {
        guard let objectsData = UserDefaults.standard.object(forKey: "Zip") as? Data else {
            return []
        }
        
        let decoder = JSONDecoder()
        guard let objects = try? decoder.decode([ZipFile].self, from: objectsData) else {
            return []
        }
        
        return objects
    }
    
    static func saveZip(_ data: ZipFile) {
        var objects = StorageManager.zipData
        objects.append(data)
        StorageManager.saveZip(objects)
    }
    
    static func deleteZipObject(_ object: ZipFile) {
        var objects = StorageManager.zipData
        deleteFile(with: object.filename + ".zip")
        objects.removeAll { $0.path == object.path }
        StorageManager.saveZip(objects)
    }
    
    private static func deleteFile(with name: String) {
        let url = Storage().fileURL(with: name)
        try? FileManager.default.removeItem(at: url)
    }
    
    private static func saveZip(_ objects: [ZipFile]) {
        let encoder = JSONEncoder()
        guard let encodedData = try? encoder.encode(objects) else {
            return
        }
        
        UserDefaults.standard.set(encodedData, forKey: "Zip")
    }
}
