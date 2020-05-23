//
//  ArchiveCell.swift
//  Guard
//
//  Created by Denys on 7/29/19.
//  Copyright © 2019 Litvinskii Denis. All rights reserved.
//

import UIKit

final class ArchiveCell: UICollectionViewCell, CellReusable, NibLoadable {
    
    // MARK: - Outlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    // MARK: - Public methods
    func configure(with title: String) {
        changeIconIfNeeded()
        
        titleLabel.text = title
    }
    
    // MARK: - Private
    private func changeIconIfNeeded() {
        guard #available(iOS 12.0, *) else {
            return
        }
        
        if traitCollection.userInterfaceStyle == .dark {
            imageView.image = UIImage(named: "folder_white")
        } else {
            imageView.image = UIImage(named: "folder")
        }
    }
}

