//
//  ZipFile.swift
//  Guard
//
//  Created by Denys on 8/4/19.
//  Copyright © 2019 Litvinskii Denis. All rights reserved.
//

import Foundation

struct ZipFile: Codable {
    let filename: String
    let path: String
    let timestamp: Double
    let filesCount: Int
    let size: Int
}
