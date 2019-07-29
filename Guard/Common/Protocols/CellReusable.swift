//
//  CellReusable.swift
//  Guard
//
//  Created by Denys on 7/29/19.
//  Copyright © 2019 Litvinskii Denis. All rights reserved.
//

import Foundation

protocol CellReusable: AnyObject {
    static var reuseIdentifier: String { get }
}

extension CellReusable {
    
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}
