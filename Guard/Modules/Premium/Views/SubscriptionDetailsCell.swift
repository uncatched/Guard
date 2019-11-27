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
    }
}

// MARK: - Private methods
extension SubscriptionDetailsCell {
    
    private func setupSubviews() {
        freeTrialLabel.text = "Free 7-day trial"
        freeTrialDescriptionLabel.text = "For free 7-day trial, you won't be charged until your trial has ended. Your iTunes Account will only be charged once your purchase is confirmed."
        subscriptionLabel.text = "Subscription will auto-renew"
        subscriptionDescriptionLabel.text = "This subscription automatically renews for $9.99 a month after 7-day free trial. You can turn off auto-renew at least 24 hours before your billing period ends. Your account will be charged for renewal within 24 hours prior to the end of the current period. You can manage and cancel subscription any time by going to iTunes Account"
    }
}
