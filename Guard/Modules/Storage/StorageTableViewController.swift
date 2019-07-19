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
    
    // MARK: - Life Cycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    
        data = StorageManager.data
        
        tableView.reloadData()
    }
}

// MARK: - UITableViewDelegate/DataSource
extension StorageTableViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "StorageCell") else {
            return UITableViewCell()
        }
        
        let item = data[indexPath.row]
        cell.textLabel?.text = item.title ?? "Item"
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let item = data[indexPath.row]
        StorageManager.deleteObject(with: item.id)
        data = StorageManager.data
        tableView.deleteRows(at: [indexPath], with: .automatic)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = data[indexPath.row]
        guard let detailsViewController = storyboard?.instantiateViewController(withIdentifier: "PasswordDetailsViewController") as? PasswordDetailsViewController else {
            return
        }
        
        detailsViewController.data = item
        navigationController?.show(detailsViewController, sender: nil)
    }
}
