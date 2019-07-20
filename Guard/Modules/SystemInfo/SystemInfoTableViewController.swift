//
//  SystemInfoTableViewController.swift
//  Guard
//
//  Created by Denys on 6/24/19.
//  Copyright © 2019 Litvinskii Denis. All rights reserved.
//

import UIKit

final class SystemInfoTableViewController: UITableViewController {

    // MARK: - Outlets
    @IBOutlet private weak var uuidLabel: UILabel!
    @IBOutlet private weak var identifierLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var diagonalLabel: UILabel!
    @IBOutlet private weak var ppiLabel: UILabel!
    @IBOutlet private weak var ratioLabel: UILabel!
    @IBOutlet private weak var sensorLabel: UILabel!
    @IBOutlet private weak var versionLabel: UILabel!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var totalLabel: UILabel!
    @IBOutlet private weak var availableLabel: UILabel!
    @IBOutlet private weak var wifiLabel: UILabel!
    @IBOutlet private weak var cellularLabel: UILabel!
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureLabels()
    }
}

// MARK: - UITableViewDelegate
extension SystemInfoTableViewController {
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
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
        // General Info
        uuidLabel.text = UIDevice.current.identifierForVendor?.uuidString ?? ""
        identifierLabel.text = Device.identifier
        descriptionLabel.text = Device.description
        
        // Screen
        diagonalLabel.text = String(Device.diagonal.removeZerosFromEnd())
        ppiLabel.text = String(Device.ppi)
        ratioLabel.text = "\(Device.ratio.height.removeZerosFromEnd())x\(Device.ratio.width.removeZerosFromEnd())"
        
        // System info
        sensorLabel.text = Device.hasBiometricSensor ? "YES" : "NO"
        versionLabel.text = UIDevice.current.systemVersion
        nameLabel.text = UIDevice.current.systemName
        
        // Capacity
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
        
        // Network
        wifiLabel.text = UIDevice.current.getWiFiAddress(for: .wifi) ?? "No connection"
        cellularLabel.text = UIDevice.current.getWiFiAddress(for: .cellular) ?? "No connection"
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
        showToast(message: "Copied")
    }
}
