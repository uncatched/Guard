//
//  ImagePickerHeaderView.swift
//  Guard
//
//  Created by Denys on 8/1/19.
//  Copyright © 2019 Litvinskii Denis. All rights reserved.
//

import UIKit

final class ImagePickerHeaderView: UICollectionReusableView, NibLoadable, CellReusable, HeightConfigurable {
    
    // MARK: - Properties
    static var height: CGFloat = 50

    // MARK: - Outlets
    @IBOutlet weak var titleLabel: UILabel!
    
    // MARK: - Public methods
    func configure(with title: String) {
        titleLabel.text = title
    }
}
