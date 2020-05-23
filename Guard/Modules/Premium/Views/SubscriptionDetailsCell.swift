//
//  SubscriptionDetailsCell.swift
//  Proxy
//
//  Created by Denys on 6/3/19.
//  Copyright © 2019 Denys. All rights reserved.
//

import UIKit

final class SubscriptionDetailsCell: UITableViewCell {
    
    // MARK: - Outlets
    
    @IBOutlet private weak var freeTrialLabel: UILabel!
    @IBOutlet private weak var freeTrialDescriptionLabel: UILabel!
    @IBOutlet private weak var subscriptionLabel: UILabel!
    @IBOutlet private weak var subscriptionDescriptionLabel: UILabel!

    // MARK: - Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupSubviews()
    }
}

// MARK: - Private methods
extension SubscriptionDetailsCell {
    
    private func setupSubviews() {
        freeTrialLabel.text = NSLocalizedString("premium_label_freeTrial", comment: "")
        freeTrialDescriptionLabel.text = NSLocalizedString("premium_label_freeTrialDescription", comment: "")
        subscriptionLabel.text = NSLocalizedString("premium_label_subscriptionAutoRenew", comment: "")
        subscriptionDescriptionLabel.text = NSLocalizedString("premium_label_subscriptionDetails", comment: "")
    }
}
