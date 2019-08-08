//
//  HeightConfigurable.swift
//  Guard
//
//  Created by Denys on 7/29/19.
//  Copyright © 2019 Litvinskii Denis. All rights reserved.
//

import CoreGraphics

protocol HeightConfigurable {
    static var height: CGFloat { get }
}

protocol WidthConfigurable {
    static var width: CGFloat { get }
}

typealias SizeConfigurable = HeightConfigurable & WidthConfigurable
