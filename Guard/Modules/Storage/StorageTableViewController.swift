//
//  StorageTableViewController.swift
//  Guard
//
//  Created by Denys on 6/24/19.
//  Copyright © 2019 Litvinskii Denis. All rights reserved.
//

import UIKit

final class StorageTableViewController: UITableViewController {
    
    // MARK: - Properties
    private var data: [StorageData]!
    private var emptyLabel: UILabel!
    
    // MARK: - Life Cycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    
        data = StorageManager.data
        tableView.isScrollEnabled = !data.isEmpty
        tableView.separatorStyle = !data.isEmpty ? .singleLine : .none
        tableView.reloadData()
    }
}

// MARK: - Actions
extension StorageTableViewController {
    
    @IBAction private func onAddButton() {
        guard DefaultsManager.isPremium || data.count < 3 else {
            showPremiumAlert()
            return
        }
        
        guard let viewController = storyboard?.instantiateViewController(withIdentifier: "AddPasswordTableViewController") else {
            return
        }
        
        navigationController?.pushViewController(viewController, animated: true)
    }
}

// MARK: - Private methods
extension StorageTableViewController {
    
    private func showPremiumAlert() {
        let premiumStoryboard = UIStoryboard(name: "Premium", bundle: nil)
        guard let premiumNavigationController = premiumStoryboard.instantiateInitialViewController() else {
            return
        }
        
        present(premiumNavigationController, animated: true, completion: nil)
    }
}

// MARK: - UITableViewDelegate/DataSource
extension StorageTableViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count == 0 ? 1 : data.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if data.count == 0 {
            let navigationBarHeight: CGFloat = navigationController?.navigationBar.bounds.height ?? 0.0
            let tabBarHeight: CGFloat = tabBarController?.tabBar.bounds.height ?? 0.0
            return tableView.bounds.size.height - (navigationBarHeight + tabBarHeight + 35)
        } else {
            return 50
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if data.count == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "EmptyStorageCell") else {
                return UITableViewCell()
            }
            cell.selectionStyle = .none
            
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "StorageCell") else {
                return UITableViewCell()
            }
            
            let item = data[indexPath.row]
            cell.textLabel?.text = item.title ?? "Item"
            
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        guard data.count > 0 else {
            return .none
        }
        
        return .delete
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let item = data[indexPath.row]
        StorageManager.deleteObject(with: item.id)
        data = StorageManager.data
        tableView.deleteRows(at: [indexPath], with: .automatic)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard data.count > 0 else {
            return
        }
        
        let item = data[indexPath.row]
        guard let detailsViewController = storyboard?.instantiateViewController(withIdentifier: "PasswordDetailsViewController") as? PasswordDetailsViewController else {
            return
        }
        
        detailsViewController.data = item
        navigationController?.show(detailsViewController, sender: nil)
    }
}
