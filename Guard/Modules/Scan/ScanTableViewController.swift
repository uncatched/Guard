//
//  ScanTableViewController.swift
//  Guard
//
//  Created by Denys on 6/24/19.
//  Copyright © 2019 Litvinskii Denis. All rights reserved.
//

import UIKit
import Contacts
import Photos

struct ScanResult {
    var contacts = 0
    var copies = 0
    var photo = 0
    var video = 0
    var audio = 0
}

final class ScanTableViewController: UITableViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var totalCountLabel: UILabel!
    @IBOutlet weak var duplicatesCountLabel: UILabel!
    @IBOutlet weak var photoCountLabel: UILabel!
    @IBOutlet weak var videoCountLabel: UILabel!
    @IBOutlet weak var audioCountLabel: UILabel!
    @IBOutlet weak var totalActivityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var duplicatesActivityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var photoActivityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var videoActivityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var audioActivityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var removeButton: UIButton!
    
    // MARK: - Properties
    private let store = CNContactStore()
    private var result = ScanResult()
    private var duplicates: [String] = []
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        refresh()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        removeButton.isHidden = DefaultsManager.shared.removeDuplicates
    }
}

// MARK: - Private methods
extension ScanTableViewController {
    
    private func refresh() {
        resetLabels()
        
        scanAllContacts { [weak self] in
            guard let self = self else {
                return
            }
            
            self.configureContactLabels(self.result)
            self.totalActivityIndicator.stopAnimating()
            self.duplicatesActivityIndicator.stopAnimating()
            self.totalCountLabel.isHidden = false
            self.duplicatesCountLabel.isHidden = false
            
            self.scanLibrary { [weak self] in
                guard let self = self else {
                    return
                }
                
                DispatchQueue.main.async {
                    self.photoActivityIndicator.stopAnimating()
                    self.videoActivityIndicator.stopAnimating()
                    self.audioActivityIndicator.stopAnimating()
                    self.photoCountLabel.isHidden = false
                    self.videoCountLabel.isHidden = false
                    self.audioCountLabel.isHidden = false
                    self.configureLibraryLabels(self.result)
                    
                    if DefaultsManager.shared.removeDuplicates {
                        self.cleanDuplicates()
                    }
                }
            }
        }
    }
    
    private func resetLabels() {
        totalCountLabel.isHidden = true
        duplicatesCountLabel.isHidden = true
        photoCountLabel.isHidden = true
        videoCountLabel.isHidden = true
        audioCountLabel.isHidden = true
        
        totalActivityIndicator.startAnimating()
        duplicatesActivityIndicator.startAnimating()
        photoActivityIndicator.startAnimating()
        videoActivityIndicator.startAnimating()
        audioActivityIndicator.startAnimating()
    }
    
    private func scanAllContacts(completion: @escaping () -> Void) {
        requestContactsPermissions(completion)
    }
    
    private func scanLibrary(completion: @escaping () -> Void) {
        requestLibraryPermissions(completion)
    }
    
    private func requestContactsPermissions(_ completion: @escaping () -> Void) {
        let status = CNContactStore.authorizationStatus(for: .contacts)
        switch status {
        case .notDetermined:
            store.requestAccess(for: .contacts) { [weak self] success, error in
                self?.getAllContacts(completion)
            }
        case .authorized:
            getAllContacts(completion)
        default:
            break
        }
    }
    
    private func getAllContacts(_ completion: @escaping () -> Void) {
        let contactStore = CNContactStore()
        let keysToFetch = [
            CNContactEmailAddressesKey,
            CNContactPhoneNumbersKey,
            CNContactImageDataAvailableKey,
            CNContactThumbnailImageDataKey]
        
        // Get all the containers
        var allContainers: [CNContainer] = []
        do {
            allContainers = try contactStore.containers(matching: nil)
        } catch {
            print("Error fetching containers")
        }
        
        var results: [CNContact] = []
        
        // Iterate all containers and append their contacts to our results array
        for container in allContainers {
            let fetchPredicate = CNContact.predicateForContactsInContainer(withIdentifier: container.identifier)
            
            do {
                let containerResults = try contactStore.unifiedContacts(matching: fetchPredicate, keysToFetch: keysToFetch as [CNKeyDescriptor])
                results.append(contentsOf: containerResults)
            } catch {
                print("Error fetching results for container")
            }
        }
        
        scan(contacts: results, completion: completion)
    }
    
    private func scan(contacts: [CNContact], completion: @escaping () -> Void) {
        result.contacts = contacts.count
        
        var phones: [String] = []
        contacts.forEach {
            let numbers = $0.phoneNumbers
            numbers.forEach {
                phones.append($0.value.stringValue.replacingOccurrences(of: " ", with: "").replacingOccurrences(of: ")", with: "").replacingOccurrences(of: "(", with: ""))
            }
        }
        
        let grouped = Dictionary(grouping: phones, by: { $0 })
        let copies = grouped.filter { $1.count > 1 }.flatMap { $0.value }
        
        duplicates = copies
        result.copies = copies.count
        
        DispatchQueue.main.async {
            completion()
        }
    }
    
    private func requestLibraryPermissions(_ completion: @escaping () -> Void) {
        PHPhotoLibrary.requestAuthorization { [weak self] status in
            switch status {
            case .authorized:
                DispatchQueue.main.async {
                    self?.fetchAlbums(completion)
                }
            default:
                break
            }
        }
    }
    
    private func fetchAlbums(_ completion: @escaping () -> Void) {
        let photo = PHAsset.fetchAssets(with: .image, options: PHFetchOptions())
        let video = PHAsset.fetchAssets(with: .video, options: PHFetchOptions())
        let audio = PHAsset.fetchAssets(with: .audio, options: PHFetchOptions())
        result.photo = photo.count
        result.video = video.count
        result.audio = audio.count
        
        let data: DeleteMediaType = (photo: photo, video: video, audio: audio, completion: completion)
        switch DefaultsManager.shared.deleteMediaRule {
        case .sixMonths:
            deleteMediaAfterSixMonths(data: data)
        case .oneYear:
            deleteMediaAfterOneYear(data: data)
        case .twoYears:
            deleteMediaAfterTwoYears(data: data)
        default:
            completion()
        }
    }
    
    private func configureContactLabels(_ result: ScanResult) {
        totalCountLabel.text = String(result.contacts)
        duplicatesCountLabel.text = String(result.copies)
    }
    
    private func configureLibraryLabels(_ result: ScanResult) {
        photoCountLabel.text = String(result.photo)
        videoCountLabel.text = String(result.video)
        audioCountLabel.text = String(result.audio)
    }
    
    private func cleanDuplicates() {
        guard duplicates.count > 0 else {
            return
        }
        
        let crossReference = Dictionary(grouping: duplicates, by: { $0 })
        crossReference.forEach { item in
            deleteContact(item.key)
        }
        
        refresh()
    }
    
    private func deleteContact(_ phone: String) {
        let store = CNContactStore()
        let predicate = CNContact.predicateForContacts(matching: CNPhoneNumber(stringValue: phone))
        do {
            let contacts = try store.unifiedContacts(matching: predicate, keysToFetch: [])
            guard contacts.count > 1 else {
                return
            }
            
            let deletion = contacts.dropLast()
            deletion.forEach { contact in
                let request = CNSaveRequest()
                let mutableContact = contact.mutableCopy() as! CNMutableContact
                request.delete(mutableContact)
                
                do {
                    try store.execute(request)
                    print("Deleted \(phone)")
                } catch {
                    print(error)
                }
            }
        } catch {
            print(error)
        }
    }
    
    typealias DeleteMediaType = (photo: PHFetchResult<PHAsset>, video: PHFetchResult<PHAsset>, audio: PHFetchResult<PHAsset>, completion: () -> Void)
    
    private func deleteMediaAfterSixMonths(data: DeleteMediaType) {
        var photos: [PHAsset] = []
        var video: [PHAsset] = []
        var audio: [PHAsset] = []
        
        data.photo.enumerateObjects { asset, index, stop in
            guard self.isAsset(asset, olderThanMonths: 6) else {
                return
            }
            
            photos.append(asset)
        }
        
        data.video.enumerateObjects { asset, index, stop in
            guard self.isAsset(asset, olderThanMonths: 6) else {
                return
            }
            
            video.append(asset)
        }
        
        data.audio.enumerateObjects { asset, index, stop in
            guard self.isAsset(asset, olderThanMonths: 6) else {
                return
            }
            
            audio.append(asset)
        }
        
        PHPhotoLibrary.shared().performChanges({
            PHAssetChangeRequest.deleteAssets(photos as NSArray)
            PHAssetChangeRequest.deleteAssets(video as NSArray)
            PHAssetChangeRequest.deleteAssets(audio as NSArray)
        }) { completed, _ in
            self.result.photo -= photos.count
            self.result.video -= video.count
            self.result.audio -= audio.count
            data.completion()
        }
    }
    
    private func deleteMediaAfterOneYear(data: DeleteMediaType) {
        var photos: [PHAsset] = []
        var video: [PHAsset] = []
        var audio: [PHAsset] = []
        
        data.photo.enumerateObjects { asset, index, stop in
            guard self.isAsset(asset, olderThanYears: 2) else {
                return
            }
            
            photos.append(asset)
        }
        
        data.video.enumerateObjects { asset, index, stop in
            guard self.isAsset(asset, olderThanYears: 2) else {
                return
            }
            
            video.append(asset)
        }
        
        data.audio.enumerateObjects { asset, index, stop in
            guard self.isAsset(asset, olderThanYears: 2) else {
                return
            }
            
            audio.append(asset)
        }
        
        PHPhotoLibrary.shared().performChanges({
            PHAssetChangeRequest.deleteAssets(photos as NSArray)
            PHAssetChangeRequest.deleteAssets(video as NSArray)
            PHAssetChangeRequest.deleteAssets(audio as NSArray)
        }) { completed, _ in
            self.result.photo -= photos.count
            self.result.video -= video.count
            self.result.audio -= audio.count
            data.completion()
        }
    }
    
    private func deleteMediaAfterTwoYears(data: DeleteMediaType) {
        var photos: [PHAsset] = []
        var video: [PHAsset] = []
        var audio: [PHAsset] = []
        
        data.photo.enumerateObjects { asset, index, stop in
            guard self.isAsset(asset, olderThanYears: 2) else {
                return
            }
            
            photos.append(asset)
        }
        
        data.video.enumerateObjects { asset, index, stop in
            guard self.isAsset(asset, olderThanYears: 2) else {
                return
            }
            
            video.append(asset)
        }
        
        data.audio.enumerateObjects { asset, index, stop in
            guard self.isAsset(asset, olderThanYears: 2) else {
                return
            }
            
            audio.append(asset)
        }
        
        PHPhotoLibrary.shared().performChanges({
            PHAssetChangeRequest.deleteAssets(photos as NSArray)
            PHAssetChangeRequest.deleteAssets(video as NSArray)
            PHAssetChangeRequest.deleteAssets(audio as NSArray)
        }) { completed, _ in
            self.result.photo -= photos.count
            self.result.video -= video.count
            self.result.audio -= audio.count
            data.completion()
        }
    }
    
    func isAsset(_ asset: PHAsset, olderThanYears years: Int) -> Bool {
        guard let date = asset.creationDate else {
            return false
        }
        
        let currentDate = Date()
        let assetDateComponents = Calendar.current.component(.year, from: date)
        let currentDateComponents = Calendar.current.component(.year, from: currentDate)
        let diff = currentDateComponents - assetDateComponents
        return diff >= years
    }
    
    func isAsset(_ asset: PHAsset, olderThanMonths months: Int) -> Bool {
        guard let date = asset.creationDate else {
            return false
        }
        
        let currentDate = Date()
        let assetDateComponents = Calendar.current.dateComponents([.month, .year], from: date)
        let currentDateComponents = Calendar.current.dateComponents([.month, .year], from: currentDate)
        var diff = (currentDateComponents.year! - assetDateComponents.year!) * 12
        if diff == 0 {
            diff = currentDateComponents.month! - assetDateComponents.month!
        }
        
        return diff > months
    }
}

// MARK: - Actions
extension ScanTableViewController {
    
    @IBAction private func onRefreshButton() {
        refresh()
    }
    
    @IBAction private func onRemoveContactsButton() {
        cleanDuplicates()
    }
}
