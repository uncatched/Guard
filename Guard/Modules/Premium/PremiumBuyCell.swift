//
//  PremiumBuyCell.swift
//  Proxy
//
//  Created by Denys on 6/3/19.
//  Copyright © 2019 Denys. All rights reserved.
//

import UIKit

final class PremiumBuyCell: UITableViewCell {

    @IBOutlet weak var buyButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        buyButton.layer.cornerRadius = 4.0
    }
}
