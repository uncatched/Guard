//
//  PremiumManager.swift
//  Guard
//
//  Created by Denys on 8/12/19.
//  Copyright © 2019 Litvinskii Denis. All rights reserved.
//

import Foundation

extension Notification.Name {
    static let PremiumManagerDidPurchasedPremium = Notification.Name("PremiumManagerDidPurchasedPremium")
    static let PremiumManagerDidFailedPurchase = Notification.Name("PremiumManagerDidFailedPurchase")
}

final class PremiumManager {
    
    static let shared = PremiumManager()
    private let helper = IAPHelper(productIds: ["com.proxy.premium.month"])
    
    init() {
        NotificationCenter.default.addObserver(self, selector: #selector(onPurchaseNotification), name: .IAPHelperPurchaseNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(onFailedPurchaseNotification), name: .IAPHelperPurchaseFailedNotification, object: nil)
    }
    
    func buy() {
        helper.requestProducts { [weak self] _, products in
            guard let products = products,
                let product = products.first else {
                    return
            }
            
            self?.helper.buyProduct(product)
        }
    }
    
    func restore() {
        helper.restorePurchases()
    }
    
    @objc private func onPurchaseNotification(_ sender: Notification) {
        DefaultsManager.isPremium = true
        NotificationCenter.default.post(name: .PremiumManagerDidPurchasedPremium, object: nil)
    }
    
    @objc private func onFailedPurchaseNotification(_ sender: Notification) {
        NotificationCenter.default.post(name: .PremiumManagerDidFailedPurchase, object: nil)
    }
}
