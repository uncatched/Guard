//
//  ImagePickerCell.swift
//  Guard
//
//  Created by Denys on 7/30/19.
//  Copyright © 2019 Litvinskii Denis. All rights reserved.
//

import UIKit

final class ImagePickerCell: UICollectionViewCell, CellReusable, NibLoadable {
    
    // MARK: - Outlets
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var selectionView: UIView!
    
    // MARK: - Life Cycle
    override func prepareForReuse() {
        super.prepareForReuse()
        
        imageView.image = nil
    }
    
    // MARK: - Public methods
    func configure(with image: UIImage?, isSelected: Bool) {
        imageView.image = image
        selectionView.isHidden = !isSelected
    }
}
