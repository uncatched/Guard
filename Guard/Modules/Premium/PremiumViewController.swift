//
//  PremiumViewController.swift
//  Proxy
//
//  Created by Denys on 6/3/19.
//  Copyright © 2019 Denys. All rights reserved.
//

import UIKit

final class PremiumViewController: UIViewController {

    @IBOutlet private weak var tableView: UITableView!
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
        setupTableView()
        setupRestoreButton()
        setupCancelButton()
        addObservers()
    }
}

// MARK: - Private methods
extension PremiumViewController {
    
    private func setupNavigationBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .always
        title = NSLocalizedString("premium_label_premium", comment: "")
    }
    
    private func setupTableView() {
        tableView.register(UINib(nibName: "SubscriptionDetailsCell", bundle: nil), forCellReuseIdentifier: "SubscriptionDetailsCell")
        tableView.register(UINib(nibName: "PremiumBuyCell", bundle: nil), forCellReuseIdentifier: "PremiumBuyCell")
        tableView.register(UINib(nibName: "PremiumTermsCell", bundle: nil), forCellReuseIdentifier: "PremiumTermsCell")
    }
    
    private func setupRestoreButton() {
        let restoreButton = UIBarButtonItem(title: NSLocalizedString("general_button_restore", comment: ""), style: .plain, target: self, action: #selector(onRestoreButton))
        restoreButton.tintColor = .mainBlue
        navigationItem.rightBarButtonItem = restoreButton
    }
    
    private func setupCancelButton() {
        let cancelButton = UIBarButtonItem(title: NSLocalizedString("general_button_cancel", comment: ""), style: .plain, target: self, action: #selector(onCancelButton))
        cancelButton.tintColor = .mainBlue
        navigationItem.leftBarButtonItem = cancelButton
    }
    
    private func addObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(didPurchasePremium), name: .PremiumManagerDidPurchasedPremium, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(didFailedPurchase), name: .PremiumManagerDidFailedPurchase, object: nil)
    }
}

// MARK: - Actions
extension PremiumViewController {
    
    @IBAction private func onBuyButton() {
        PremiumManager.shared.buy()
    }
    
    @IBAction private func onRestoreButton() {
        PremiumManager.shared.restore()
    }
    
    @IBAction private func onCancelButton() {
        dismiss(animated: true, completion: nil)
    }
}

// MARK: - UITableViewDelegate / DataSource
extension PremiumViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "SubscriptionDetailsCell")!
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "PremiumBuyCell") as! PremiumBuyCell
            cell.buyButton.addTarget(self, action: #selector(onBuyButton), for: .touchUpInside)
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "PremiumTermsCell")!
            return cell
        default:
            return UITableViewCell()
        }
    }
}

// MARK: - Observers
extension PremiumViewController {
    
    @objc func didPurchasePremium() {
        let alertController = UIAlertController(title: NSLocalizedString("premium_label_congratulations", comment: ""),
                                                message: NSLocalizedString("premium_label_premiumPurchased", comment: ""),
                                                preferredStyle: .alert)
        let okAction = UIAlertAction(title: NSLocalizedString("general_button_ok", comment: ""), style: .default) { [unowned self] _ in
            self.dismiss(animated: true, completion: nil)
        }
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
    
    @objc func didFailedPurchase() {
        let alertController = UIAlertController(title: NSLocalizedString("general_label_error", comment: ""),
                                                message: NSLocalizedString("general_label_tryAgainLater", comment: ""),
                                                preferredStyle: .alert)
        let okAction = UIAlertAction(title: NSLocalizedString("general_button_ok", comment: ""), style: .default, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
}
