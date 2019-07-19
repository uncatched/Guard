//
//  SettingsTableViewController.swift
//  Guard
//
//  Created by Denys on 6/24/19.
//  Copyright © 2019 Litvinskii Denis. All rights reserved.
//

import UIKit

final class SettingsTableViewController: UITableViewController {
    
    // MARK: - Outlets
    @IBOutlet private weak var mediaTextField: UITextField!
    @IBOutlet private var mediaPickerView: UIPickerView!
    @IBOutlet private weak var duplicatesSwitch: UISwitch!
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
        
        mediaTextField.inputView = mediaPickerView
        mediaPickerView.selectRow(DefaultsManager.shared.deleteMediaRule.rawValue, inComponent: 0, animated: false)
        tableView.keyboardDismissMode = .onDrag
    }
}

// MARK: - UITableViewDelegate/DataSource
extension SettingsTableViewController {
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        switch indexPath.row {
        case 0:
            duplicatesSwitch.setOn(!duplicatesSwitch.isOn, animated: true)
        case 1:
            if mediaTextField.isFirstResponder {
                mediaTextField.resignFirstResponder()
            } else {
                mediaTextField.becomeFirstResponder()
            }
        default:
            break
        }
    }
}

// MARK: - Private methods
extension SettingsTableViewController {
    
    private func configure() {
        mediaTextField.text = DefaultsManager.shared.deleteMediaRule.shortTitle
        duplicatesSwitch.isOn = DefaultsManager.shared.removeDuplicates
    }
}

// MARK: - Actions
extension SettingsTableViewController {
    
    @IBAction private func onDuplicatesSwitch(_ sender: Any) {
        DefaultsManager.shared.removeDuplicates = duplicatesSwitch.isOn
    }
}

// MARK: - UIPickerViewDelegate/DataSource
extension SettingsTableViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return DeleteMediaRule.allCases.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        guard let rule = DeleteMediaRule(rawValue: row) else {
            return nil
        }
        
        return rule.title
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 44
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        guard let rule = DeleteMediaRule(rawValue: row) else {
            return
        }
        
        DefaultsManager.shared.deleteMediaRule = rule
        mediaTextField.text = rule.shortTitle
    }
}
