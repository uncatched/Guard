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
}
