//
//  SystemInfoTableViewController.swift
//  Guard
//
//  Created by Denys on 6/24/19.
//  Copyright © 2019 Litvinskii Denis. All rights reserved.
//

import UIKit
import DeviceKit

final class SystemInfoTableViewController: UITableViewController {

    // MARK: - Outlets
    
    @IBOutlet private weak var generalInfoLabel: UILabel!
    @IBOutlet private weak var uuidLabel: UILabel!
    @IBOutlet private weak var identifierLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var identifierTitleLabel: UILabel!
    @IBOutlet private weak var descriptionTitleLabel: UILabel!
    
    @IBOutlet private weak var screenLabel: UILabel!
    @IBOutlet private weak var diagonalLabel: UILabel!
    @IBOutlet private weak var ppiLabel: UILabel!
    @IBOutlet private weak var ratioLabel: UILabel!
    @IBOutlet private weak var diagonalTitleLabel: UILabel!
    @IBOutlet private weak var ratioTitleLabel: UILabel!
    
    @IBOutlet private weak var systemInfoLabel: UILabel!
    @IBOutlet private weak var sensorLabel: UILabel!
    @IBOutlet private weak var versionLabel: UILabel!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var sensorTitleLabel: UILabel!
    @IBOutlet private weak var versionTitleLabel: UILabel!
    @IBOutlet private weak var nameTitleLabel: UILabel!
    
    @IBOutlet private weak var capacityLabel: UILabel!
    @IBOutlet private weak var totalLabel: UILabel!
    @IBOutlet private weak var availableLabel: UILabel!
    @IBOutlet private weak var totalTitleLabel: UILabel!
    @IBOutlet private weak var availableTitleLabel: UILabel!
    
    @IBOutlet private weak var networkInfoLabel: UILabel!
    @IBOutlet private weak var wifiLabel: UILabel!
    @IBOutlet private weak var cellularLabel: UILabel!
    @IBOutlet private weak var cellularTitleLabel: UILabel!
    
    @IBOutlet private weak var copyLabel: UILabel!
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureLabels()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        guard DefaultsManager.isSecondLaunch,
            !DefaultsManager.isPremium,
            !DefaultsManager.isPremiumShown else {
            DefaultsManager.isSecondLaunch = true
            return
        }
        
        DefaultsManager.isPremiumShown = true
        showPremiumAlert()
    }
}

// MARK: - UITableViewDelegate
extension SystemInfoTableViewController {
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard indexPath.row > 0 else {
            return
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        let section = SystemInfoSection(rawValue: indexPath.section)!
        switch section {
        case .general:
            let row = SystemInfoGeneralRow(rawValue: indexPath.row)!
            copyGeneralRow(row)
        case .screen:
            let row = SystemInfoScreenRow(rawValue: indexPath.row)!
            copyScreenRow(row)
        case .system:
            let row = SystemInfoSystemRow(rawValue: indexPath.row)!
            copySystemRow(row)
        case .capacity:
            let row = SystemInfoCapacityRow(rawValue: indexPath.row)!
            copyCapacityRow(row)
        case .network:
            let row = SystemInfoNetworkRow(rawValue: indexPath.row)!
            copyNetworkRow(row)
        }
    }
}

// MARK: - Private methods
extension SystemInfoTableViewController {
    
    private func configureLabels() {
        
        title = NSLocalizedString("systemInfo_label_title", comment: "")
        copyLabel.text = NSLocalizedString("systemInfo_label_copy", comment: "")
        
        // General Info
        generalInfoLabel.text = NSLocalizedString("systemInfo_label_generalInfo", comment: "")
        uuidLabel.text = UIDevice.current.identifierForVendor?.uuidString ?? ""
        identifierLabel.text = Device.identifier
        descriptionLabel.text = Device.current.description
        identifierTitleLabel.text = NSLocalizedString("systemInfo_label_identifier", comment: "")
        descriptionTitleLabel.text = NSLocalizedString("systemInfo_label_description", comment: "")
        
        // Screen
        screenLabel.text = NSLocalizedString("systemInfo_label_screen", comment: "")
        diagonalLabel.text = String(Device.current.diagonal.removeZerosFromEnd())
        ppiLabel.text = String(Device.current.ppi ?? 0)
        ratioLabel.text = "\(Device.current.screenRatio.height.removeZerosFromEnd())x\(Device.current.screenRatio.width.removeZerosFromEnd())"
        diagonalTitleLabel.text = NSLocalizedString("systemInfo_label_diagonal", comment: "")
        ratioTitleLabel.text = NSLocalizedString("systemInfo_label_ratio", comment: "")
        
        // System info
        systemInfoLabel.text = NSLocalizedString("systemInfo_label_systemInfo", comment: "")
        
        let key = Device.current.hasBiometricSensor ? "general_label_yes" : "general_label_no"
        sensorLabel.text = NSLocalizedString(key, comment: "")
        versionLabel.text = UIDevice.current.systemVersion
        nameLabel.text = UIDevice.current.systemName
        sensorTitleLabel.text = NSLocalizedString("systemInfo_label_sensor", comment: "")
        versionTitleLabel.text = NSLocalizedString("systemInfo_label_version", comment: "")
        nameTitleLabel.text = NSLocalizedString("systemInfo_label_name", comment: "")
        
        // Capacity
        capacityLabel.text = NSLocalizedString("systemInfo_label_storage", comment: "")
        if let total = Device.volumeTotalCapacity {
            totalLabel.text = "\((total) / 1024 / 1024 / 1024) GB"
        } else {
            totalLabel.text = ""
        }
        
        if let available = Device.volumeAvailableCapacity {
            availableLabel.text = "\((available) / 1024 / 1024 / 1024) GB"
        } else {
            availableLabel.text = ""
        }
        totalTitleLabel.text = NSLocalizedString("systemInfo_label_total", comment: "")
        availableTitleLabel.text = NSLocalizedString("systemInfo_label_available", comment: "")
        
        // Network
        networkInfoLabel.text = NSLocalizedString("systemInfo_label_networkInfo", comment: "")
        wifiLabel.text = UIDevice.current.getWiFiAddress(for: .wifi) ?? NSLocalizedString("systemInfo_label_noConnection", comment: "")
        cellularLabel.text = UIDevice.current.getWiFiAddress(for: .cellular) ?? NSLocalizedString("systemInfo_label_noConnection", comment: "")
        cellularTitleLabel.text = NSLocalizedString("systemInfo_label_cellular", comment: "")
    }
    
    private func copyGeneralRow(_ row: SystemInfoGeneralRow) {
        switch row {
        case .uuid:
            copy(text: uuidLabel.text!)
        case .identifier:
            copy(text: identifierLabel.text!)
        case .description:
            copy(text: descriptionLabel.text!)
        }
    }
    
    private func copyScreenRow(_ row: SystemInfoScreenRow) {
        switch row {
        case .diagonal:
            copy(text: diagonalLabel.text!)
        case .ppi:
            copy(text: ppiLabel.text!)
        case .ratio:
            copy(text: ratioLabel.text!)
        }
    }
    
    private func copySystemRow(_ row: SystemInfoSystemRow) {
        switch row {
        case .sensor:
            copy(text: sensorLabel.text!)
        case .version:
            copy(text: versionLabel.text!)
        case .name:
            copy(text: nameLabel.text!)
        }
    }
    
    private func copyCapacityRow(_ row: SystemInfoCapacityRow) {
        switch row {
        case .total:
            copy(text: totalLabel.text!)
        case .available:
            copy(text: availableLabel.text!)
        }
    }
    
    private func copyNetworkRow(_ row: SystemInfoNetworkRow) {
        switch row {
        case .wiFi:
            copy(text: wifiLabel.text!)
        case .cellular:
            copy(text: cellularLabel.text!)
        }
    }
    
    private func copy(text: String) {
        UIPasteboard.general.string = text
        showToast(message: NSLocalizedString("systemInfo_label_copied", comment: ""))
    }
    
    private func showPremiumAlert() {
        let premiumStoryboard = UIStoryboard(name: "Premium", bundle: nil)
        guard let premiumNavigationController = premiumStoryboard.instantiateInitialViewController() else {
            return
        }
        
        present(premiumNavigationController, animated: true, completion: nil)
    }
}
