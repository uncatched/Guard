//
//  ArchiveViewController.swift
//  Guard
//
//  Created by Denys on 7/29/19.
//  Copyright © 2019 Litvinskii Denis. All rights reserved.
//

import UIKit

final class ArchiveViewController: UICollectionViewController {
    
    // MARK: - Properties
    private var state: ArchiveViewState = .empty
    private var archives: [ZipFile] = [] {
        didSet {
            state = archives.count == 0 ? .empty : .withData
            collectionView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCollectionView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        archives = StorageManager.zipData
    }
}

// MARK: - Actions
extension ArchiveViewController {
    
    @IBAction private func onAddButton() {
        guard let imagePickerController = storyboard?.instantiateViewController(withIdentifier: "ImagePickerController") as? ImagePickerController else {
            return
        }
        
        let navigationController = UINavigationController(rootViewController: imagePickerController)
        present(navigationController, animated: true, completion: nil)
    }
}

// MARK: - UICollectionViewDataSource/Delegate/FlowLayout
extension ArchiveViewController: UICollectionViewDelegateFlowLayout {
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch state {
        case .empty:
            return 1
        case .withData:
            return archives.count
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch state {
        case .empty:
            return collectionView.dequeueReusableCell(withReuseIdentifier: ArchiveEmptyCell.reuseIdentifier, for: indexPath)
        case .withData:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ArchiveCell.reuseIdentifier, for: indexPath) as! ArchiveCell
            let zip = archives[indexPath.row]
            cell.configure(with: zip.filename)
            
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch state {
        case .empty:
            return collectionView.bounds.size
        case .withData:
            return CGSize(width: collectionView.bounds.width/3, height: collectionView.bounds.width/3)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let zip = archives[indexPath.row]
        let detailsViewController = storyboard?.instantiateViewController(withIdentifier: "ZipDetailsViewController") as! ZipDetailsViewController
        detailsViewController.zip = zip
        navigationController?.pushViewController(detailsViewController, animated: true)
    }
}

// MARK: - Private methods
extension ArchiveViewController {
    
    private func setupCollectionView() {
        collectionView!.register(ArchiveCell.nib, forCellWithReuseIdentifier: ArchiveCell.reuseIdentifier)
        collectionView!.register(ArchiveEmptyCell.nib, forCellWithReuseIdentifier: ArchiveEmptyCell.reuseIdentifier)
    }
}

// MARK: - View state
extension ArchiveViewController {
    
    enum ArchiveViewState {
        case empty
        case withData
    }
}
