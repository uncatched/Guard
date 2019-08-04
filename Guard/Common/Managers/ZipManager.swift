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
}

// MARK: - Public methods
extension ZipManager {
    
    func zip(data: [PhotosManager.ImageData], filename: String) throws -> String {
        var urls: [URL] = []
        for fileData in data {
            guard let url = save(data: fileData) else {
                continue
            }
            
            urls.append(url)
        }
        
        let fileManager = FileManager.default
        let documentsUrl = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0] as URL
        let zipURL = documentsUrl.appendingPathComponent("\(filename).zip")
        
        try Zip.zipFiles(paths: urls, zipFilePath: zipURL, password: nil, compression: .BestCompression, progress: nil)
        
        for url in urls {
            removeFiles(at: url)
        }
        
        return zipURL.absoluteString
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
