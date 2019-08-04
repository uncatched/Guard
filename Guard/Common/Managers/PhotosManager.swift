//
//  PhotosManager.swift
//  Guard
//
//  Created by Denys on 7/30/19.
//  Copyright © 2019 Litvinskii Denis. All rights reserved.
//

import Foundation
import Photos

final class PhotosManager {
    
    // MARK: - Properties
    private let imageManager = PHImageManager.default()
    private var assets: [PHAssetMediaType: [Int: [PHAsset]]] = [:]
    private var sections: [Int] = []
}

// MARK: - Public methods
extension PhotosManager {
    
    typealias ImageData = (data: Data, format: RegistrationDocumentFormat)
    
    func requestAuthorization(completion: @escaping (PHAuthorizationStatus) -> Void) {
        PHPhotoLibrary.requestAuthorization { status in
            DispatchQueue.main.async {
                completion(status)
            }
        }
    }
    
    func requestAssets(with type: PHAssetMediaType, ascending: Bool = true, completion: @escaping () -> Void) {
        let options = PHFetchOptions()
        options.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: ascending)]
        let fetchedAssets = PHAsset.fetchAssets(with: type, options: options)
        createSections(from: fetchedAssets, with: type)
    }
    
    func title(for section: Int, with type: PHAssetMediaType) -> String? {
        return String(sections[section])
    }
    
    func sectionsCount(with type: PHAssetMediaType) -> Int {
        return assets[type]?.count ?? 0
    }
    
    func assetsCount(with type: PHAssetMediaType, in section: Int) -> Int {
        return assets[type]?[sections[section]]?.count ?? 0
    }
    
    func requestImage(at indexPath: IndexPath, with type: PHAssetMediaType, targetSize: CGSize, completion: @escaping (UIImage?) -> Void) {
        guard let assets = assets[type],
            let asset = assets[sections[indexPath.section]]?[indexPath.row] else {
            return
        }
        
        imageManager.requestImage(for: asset, targetSize: targetSize, contentMode: .aspectFill, options: nil) { image, _ in
            completion(image)
        }
    }
    
    func requestImageData(at indexPath: IndexPath, with type: PHAssetMediaType,
                          completion: @escaping (ImageData?) -> Void) {
        guard let assets = assets[type],
            let asset = assets[sections[indexPath.section]]?[indexPath.row] else {
                return
        }
        
        imageManager.requestImageData(for: asset, options: nil) { data, name, _, _ in
            guard let data = data, let name = name else {
                completion(nil)
                return
            }
            
            completion(ImageData(data: data, format: RegistrationDocumentFormat.format(from: name)))
        }
    }
}

// MARK: - Private methods
extension PhotosManager {
    
    private func createSections(from assets: PHFetchResult<PHAsset>, with type: PHAssetMediaType) {
        let calendar = Calendar.current
        self.assets[type] = [:]
        
        assets.enumerateObjects { asset, _, _ in
            guard let date = asset.creationDate  else {
                return
            }
            
            let year = calendar.component(.year, from: date)
            
            
            if var section = self.assets[type]?[year] {
                section.append(asset)
                self.assets[type]?[year] = section
            } else {
                self.assets[type]?[year] = [asset]
            }
        }
        
        sections = self.assets[type]?.keys.sorted() ?? []
    }
}

extension PhotosManager {
    
    enum RegistrationDocumentFormat: String {
        case png = "png"
        case jpg = "jpg"
        case jpeg = "jpeg"
        case gif = "gif"
        case pdf = "pdf"
        
        static func format(from string: String) -> RegistrationDocumentFormat {
            if string.hasSuffix("png") {
                return .png
            } else if string.hasSuffix("jpg") {
                return .jpg
            } else if string.hasSuffix("jpeg") {
                return .jpeg
            } else if string.hasSuffix("gif") {
                return .gif
            } else if string.hasSuffix("pdf") {
                return .pdf
            } else {
                preconditionFailure("Unsupported format for image: \(string)")
            }
        }
        
        var contentType: String {
            switch self {
            case .png:
                return "image/png"
            case .jpg:
                return "image/jpg"
            case .jpeg:
                return "image/jpeg"
            case .gif:
                return "image/gif"
            case .pdf:
                return "application/pdf"
            }
        }
    }
}
