//
//  StorageData.swift
//  Guard
//
//  Created by Denys on 6/30/19.
//  Copyright © 2019 Litvinskii Denis. All rights reserved.
//

import Foundation

struct StorageData: Codable {
    let id: String
    let title: String?
    let username: String?
    let password: String?
    let website: String?
}
