//
//  PasswordDetailsViewController.swift
//  Guard
//
//  Created by Denys on 7/4/19.
//  Copyright © 2019 Litvinskii Denis. All rights reserved.
//

import UIKit

final class PasswordDetailsViewController: UITableViewController {
    
    // MARK: - Outlets
    @IBOutlet private weak var usernameLabel: UILabel!
    @IBOutlet private weak var passwordLabel: UILabel!
    @IBOutlet private weak var websiteLabel: UILabel!
    
    // MARK: - Properties
    var data: StorageData!

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureLabels()
    }
}

// MARK: - UITableViewDelegate
extension PasswordDetailsViewController {
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let pasteboard = UIPasteboard.general
        
        switch indexPath.row {
        case 0:
            pasteboard.string = data.username
        case 1:
            pasteboard.string = data.password
        case 2:
            pasteboard.string = data.website
        default:
            return
        }
        
        showToast()
    }
}

// MARK: - Private methods
extension PasswordDetailsViewController {
    
    private func configureLabels() {
        usernameLabel.text = data.username
        passwordLabel.text = data.password
        websiteLabel.text = data.website
        title = data.title
    }
    
    private func showToast() {
        let toast = UIView(frame: CGRect(x: view.bounds.width/2 - 90, y: view.bounds.height - 190, width: 180, height: 44))
        toast.layer.cornerRadius = 22
        toast.backgroundColor = .lightGray
        toast.alpha = 1.0
        view.addSubview(toast)
        
        let label = UILabel(frame: toast.bounds)
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .white
        label.text = "Copied"
        toast.addSubview(label)
        
        UIView.animate(withDuration: 1.5, animations: {
            toast.alpha = 0.0
        }) { _ in
            toast.removeFromSuperview()
        }
    }
}
