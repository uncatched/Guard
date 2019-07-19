//
//  Double+Formats.swift
//  Guard
//
//  Created by Denys on 6/29/19.
//  Copyright © 2019 Litvinskii Denis. All rights reserved.
//

import Foundation

extension Double {
    func removeZerosFromEnd() -> String {
        let formatter = NumberFormatter()
        let number = NSNumber(value: self)
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 16
        return String(formatter.string(from: number) ?? "")
    }
}
