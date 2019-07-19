//
//  AddPasswordTableViewController.swift
//  Guard
//
//  Created by Denys on 6/30/19.
//  Copyright © 2019 Litvinskii Denis. All rights reserved.
//

import UIKit

final class AddPasswordTableViewController: UITableViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var websiteTextField: UITextField!
    
    // MARK: - Properties
    private lazy var saveButton: UIBarButtonItem = {
        let item = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(onSaveButton))
        return item
    }()
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
         navigationItem.rightBarButtonItem = saveButton
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        titleTextField.becomeFirstResponder()
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44.0
    }
}

// MARK: - Private methods
extension AddPasswordTableViewController {
    
    private func save() {
        let data = StorageData(id: UUID().uuidString,
                               title: titleTextField.text,
                               username: usernameTextField.text,
                               password: passwordTextField.text,
                               website: websiteTextField.text)

        StorageManager.save(data)
    }
}

// MARK: - Actions
extension AddPasswordTableViewController {
    
    @objc private func onSaveButton() {
        save()
        navigationController?.popViewController(animated: true)
    }
}

// MARK: - UITextFieldDelegate
extension AddPasswordTableViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case titleTextField:
            usernameTextField.becomeFirstResponder()
        case usernameTextField:
            passwordTextField.becomeFirstResponder()
        case passwordTextField:
            websiteTextField.becomeFirstResponder()
        case websiteTextField:
            websiteTextField.resignFirstResponder()
            save()
            navigationController?.popViewController(animated: true)
        default:
            break
        }
        
        return true
    }
}
