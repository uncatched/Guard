//
//  ImagePickerController.swift
//  Guard
//
//  Created by Denys on 7/30/19.
//  Copyright © 2019 Litvinskii Denis. All rights reserved.
//

import UIKit

final class ImagePickerController: UICollectionViewController {
    
    // MARK: - Outlets
    @IBOutlet private weak var doneItem: UIBarButtonItem!
    
    // MARK: - Properties
    private var imagesData: [Data] = []
    private var selectedIndexes: [IndexPath] = [] {
        didSet {
            doneItem.isEnabled = !selectedIndexes.isEmpty
        }
    }
    
    private var state: ImagePickerState = .normal {
        didSet {
            collectionView.reloadData()
        }
    }
    
    private lazy var photosManager: PhotosManager = {
        let manager = PhotosManager()
        return manager
    }()
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCollectionView()
        requestPhotosAuthorization()
    }
}

// MARK: - Private methods
extension ImagePickerController {
    
    private func setupCollectionView() {
        collectionView.register(ImagePickerCell.nib, forCellWithReuseIdentifier: ImagePickerCell.reuseIdentifier)
        collectionView.register(ImagePickerEmptyCell.nib, forCellWithReuseIdentifier: ImagePickerEmptyCell.reuseIdentifier)
        collectionView.register(ImagePickerHeaderView.nib,
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                withReuseIdentifier: ImagePickerHeaderView.reuseIdentifier)
    }
    
    private func requestPhotosAuthorization() {
        photosManager.requestAuthorization { [unowned self] status in
            guard status == .authorized else {
                self.state = .accessDeclined
                return
            }
            
            self.state = .normal
            self.requestPhotos()
        }
    }
    
    private func requestPhotos() {
        photosManager.requestAssets(with: .image) { [unowned self] in
            self.collectionView.reloadData()
        }
    }
    
    private func cell(for state: ImagePickerState, at indexPath: IndexPath) -> UICollectionViewCell {
        switch state {
        case .normal:
            return imagePickerCell(at: indexPath)
        case .accessDeclined:
            return imagePickerEmptyCell(at: indexPath)
        }
    }
    
    private func imagePickerCell(at indexPath: IndexPath) -> ImagePickerCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImagePickerCell.reuseIdentifier, for: indexPath) as? ImagePickerCell else {
            fatalError()
        }
        
        let targetSize = CGSize(width: collectionView.bounds.width/3, height: collectionView.bounds.width/3)
        photosManager.requestImage(at: indexPath, with: .image, targetSize: targetSize) { [weak cell, weak self] image in
            let isSelected = self?.selectedIndexes.contains(indexPath) ?? false
            cell?.configure(with: image, isSelected: isSelected)
        }
        
        return cell
    }
    
    private func imagePickerEmptyCell(at indexPath: IndexPath) -> ImagePickerEmptyCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImagePickerEmptyCell.reuseIdentifier, for: indexPath) as? ImagePickerEmptyCell else {
            fatalError()
        }
        
        return cell
    }
    
    private func numberOfItems(for state: ImagePickerState, in section: Int) -> Int {
        switch state {
        case .normal:
            return photosManager.assetsCount(with: .image, in: section)
        case .accessDeclined:
            return 1
        }
    }
    
    private func numberOfSection(for state: ImagePickerState) -> Int {
        switch state {
        case .normal:
            return photosManager.sectionsCount(with: .image)
        case .accessDeclined:
            return 1
        }
    }
    
    private func retreiveData() {
        guard !selectedIndexes.isEmpty else {
            proceedData()
            return
        }
        
        let indexPath = selectedIndexes.removeFirst()
        photosManager.requestImageData(at: indexPath, with: .image) { [weak self] data in
            guard let data = data else {
                self?.retreiveData()
                return
            }
            
            self?.imagesData.append(data)
            self?.retreiveData()
        }
    }
    
    private func proceedData() {
        print()
    }
}

// MARK: - Actions
extension ImagePickerController {
    
    @IBAction private func onCancelButton() {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction private func onDoneButton() {
        imagesData.removeAll()
        retreiveData()
    }
}

// MARK: - UICollectionViewDataSource
extension ImagePickerController {
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return numberOfSection(for: state)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return numberOfItems(for: state, in: section)
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return cell(for: state, at: indexPath)
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard kind == UICollectionView.elementKindSectionHeader else {
            return UICollectionReusableView()
        }
        
        guard let view = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                         withReuseIdentifier: ImagePickerHeaderView.reuseIdentifier,
                                                                         for: indexPath) as? ImagePickerHeaderView else {
                                                                            return UICollectionReusableView()
        }
        
        let title = photosManager.title(for: indexPath.section, with: .image) ?? ""
        view.configure(with: title)
        return view
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: ImagePickerHeaderView.height)
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension ImagePickerController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return state.size(for: collectionView)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
}

// MARK: - UICollectionViewDelegate
extension ImagePickerController {
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if selectedIndexes.contains(indexPath) {
            selectedIndexes.removeAll { $0 == indexPath }
        } else {
            selectedIndexes.append(indexPath)
        }
        
        collectionView.reloadItems(at: [indexPath])
    }
}
