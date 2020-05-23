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
            return NSLocalizedString("media_label_deleteAll", comment: "")
        case .sixMonths:
            return NSLocalizedString("media_label_removeSIxMonths", comment: "")
        case .oneYear:
            return NSLocalizedString("media_label_removeOneYear", comment: "")
        case .twoYears:
            return NSLocalizedString("media_label_removeTwoYears", comment: "")
        }
    }
    
    var shortTitle: String {
        switch self {
        case .all:
            return NSLocalizedString("media_label_deleteAllShort", comment: "")
        case .sixMonths:
            return NSLocalizedString("media_label_removeSIxMonthsShort", comment: "")
        case .oneYear:
            return NSLocalizedString("media_label_removeOneYearShort", comment: "")
        case .twoYears:
            return NSLocalizedString("media_label_removeTwoYearsShort", comment: "")
        }
    }
}
