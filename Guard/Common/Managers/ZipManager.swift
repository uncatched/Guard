//
//  ZipManager.swift
//  Guard
//
//  Created by Denys on 8/2/19.
//  Copyright © 2019 Litvinskii Denis. All rights reserved.
//

import Foundation
import Zip
import minizip

final class ZipManager {
    
    let storage: Storage
    
    init(storage: Storage) {
        self.storage = storage
    }
}

// MARK: - Public methods
extension ZipManager {
    
    func zip(data: [PhotosManager.ImageData], filename: String) throws -> (path: String, size: Int) {
        var urls: [URL] = []
        var size: Int = 0
        for fileData in data {
            guard let url = save(data: fileData) else {
                continue
            }
            
            size += fileData.data.count
            urls.append(url)
        }
        
        let zipURL = NSURL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent("\(filename).zip")!
        try Zip.zipFiles(paths: urls, zipFilePath: zipURL, password: nil, compression: .BestCompression, progress: nil)
        
        for url in urls {
            removeFiles(at: url)
        }
        
        let data = try Data(contentsOf: zipURL)
        let fileURL = storage.save(data: data, filename: "\(filename).zip")
        
        return (fileURL.absoluteString, size)
    }
}

// MARK: - Private methods
extension ZipManager {
    
    private func save(data: PhotosManager.ImageData) -> URL? {
        let fileName = UUID().uuidString + ".\(data.format.rawValue)"
        guard let tempDirURL = NSURL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent(fileName) else {
            return nil
        }
        
        do {
            try data.data.write(to: tempDirURL)
            return tempDirURL
        } catch {
            return nil
        }
    }
    
    private func removeFiles(at path: URL) {
        try? FileManager.default.removeItem(at: path)
    }
}

extension ZipCompression {

    internal var minizipCompression: Int32 {
        switch self {
        case .NoCompression:
            return Z_NO_COMPRESSION
        case .BestSpeed:
            return Z_BEST_SPEED
        case .BestCompression, .DefaultCompression:
            return Z_BEST_COMPRESSION
        }
    }
}
