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
    
    // MARK: - Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
