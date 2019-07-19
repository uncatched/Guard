//
//  DeleteMediaRule.swift
//  Guard
//
//  Created by Denys on 7/4/19.
//  Copyright © 2019 Litvinskii Denis. All rights reserved.
//

import Foundation

enum DeleteMediaRule: Int, CaseIterable {
    
    case all = 0
    case sixMonths
    case oneYear
    case twoYears
    
    var title: String {
        switch self {
        case .all:
            return "All"
        case .sixMonths:
            return "Remove older than 6 months"
        case .oneYear:
            return "Remove older than 1 year"
        case .twoYears:
            return "Remove older than 2 years"
        }
    }
    
    var shortTitle: String {
        switch self {
        case .all:
            return "All"
        case .sixMonths:
            return "6 months"
        case .oneYear:
            return "1 year"
        case .twoYears:
            return "2 years"
        }
    }
}
