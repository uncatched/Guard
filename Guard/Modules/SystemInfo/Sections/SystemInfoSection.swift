//
//  SystemInfoSection.swift
//  Guard
//
//  Created by Denys on 7/20/19.
//  Copyright © 2019 Litvinskii Denis. All rights reserved.
//

import Foundation

enum SystemInfoSection: Int {
    case general
    case screen
    case system
    case capacity
    case network
}

enum SystemInfoGeneralRow: Int {
    case uuid
    case identifier
    case description
}

enum SystemInfoScreenRow: Int {
    case diagonal
    case ppi
    case ratio
}

enum SystemInfoSystemRow: Int {
    case sensor
    case version
    case name
}

enum SystemInfoCapacityRow: Int {
    case total
    case available
}

enum SystemInfoNetworkRow: Int {
    case wiFi
    case cellular
}
