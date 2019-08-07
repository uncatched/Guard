//
//  Storage.swift
//  FileStorage
//
//  Created by Denys on 8/7/19.
//  Copyright © 2019 Litvinskii Denis. All rights reserved.
//

import Foundation

final class Storage {
    
}

// MARK: - Public methods
extension Storage {
    
    func storageDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        guard let storageDirectoryUrl = paths.first?.appendingPathComponent("Guard") else {
            fatalError("Unable to create directory at paths \(paths)")
        }
        
        createStorageDirectory(at: storageDirectoryUrl)
        return storageDirectoryUrl
    }
    
    func save(data: Data, filename: String) -> URL {
        let directoryURL = storageDirectory()
        let fileURL = directoryURL.appendingPathComponent(filename)
        try! data.write(to: fileURL)
        
        return fileURL
    }
    
    func file(with name: String) -> Data? {
        let url = storageDirectory().appendingPathComponent(name)
        return try? Data(contentsOf: url)
    }
    
    func fileURL(with name: String) -> URL {
        return storageDirectory().appendingPathComponent(name)
    }
    
    func removeFile(at path: String) throws {
        try FileManager.default.removeItem(atPath: path)
    }
}

// MARK: - Private methods
extension Storage {
    
    private func createStorageDirectory(at path: URL) {
        do {
            try FileManager.default.createDirectory(at: path,
                                                    withIntermediateDirectories: true,
                                                    attributes: nil)
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    private func storageContents() -> [URL]? {
        return try? FileManager.default.contentsOfDirectory(at: storageDirectory(),
                                                            includingPropertiesForKeys: nil,
                                                            options: .skipsHiddenFiles)
    }
}
