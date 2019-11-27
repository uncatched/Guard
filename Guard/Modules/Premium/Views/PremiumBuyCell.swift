//
//  PremiumBuyCell.swift
//  Proxy
//
//  Created by Denys on 6/3/19.
//  Copyright © 2019 Denys. All rights reserved.
//

import UIKit

final class PremiumBuyCell: UITableViewCell {

    // MARK: - Outlets
    @IBOutlet private(set) weak var buyButton: UIButton!
    @IBOutlet private weak var protectLabel: UILabel!
    @IBOutlet private weak var trialLabel: UILabel!
    @IBOutlet private weak var monthLabel: UILabel!
    
    // MARK: - Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupSubviews()
    }
}

// MARK: - Private methods
extension PremiumBuyCell {
    
    private func setupSubviews() {
        protectLabel.text = "Protect your iPhone"
        trialLabel.text = "Start your 7-day free trial"
        monthLabel.text = "Then $9.99 per month"
        buyButton.setTitle("Try free for 7 days", for: .normal)
        buyButton.layer.cornerRadius = 4.0
    }
}
