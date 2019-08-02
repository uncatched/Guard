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
    private var archives: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCollectionView()
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
        return archives.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ArchiveCell.reuseIdentifier, for: indexPath)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width/3, height: collectionView.bounds.width/3)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

// MARK: - Private methods
extension ArchiveViewController {
    
    private func setupCollectionView() {
        collectionView!.register(ArchiveCell.nib, forCellWithReuseIdentifier: ArchiveCell.reuseIdentifier)
    }
}

// MARK: - View state
extension ArchiveViewController {
    
    enum ArchiveViewState {
        case empty
        case withData
    }
}
