//
//  ArchiveEmptyCell.swift
//  Guard
//
//  Created by Denys on 8/5/19.
//  Copyright © 2019 Litvinskii Denis. All rights reserved.
//

import UIKit

final class ArchiveEmptyCell: UICollectionViewCell, CellReusable, NibLoadable {
    
    // MARK: - Outlets
    @IBOutlet private weak var titleLabel: UILabel!
    
    // MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        
        titleLabel.text = NSLocalizedString("zip_label_placeholder", comment: "")
    }
}
