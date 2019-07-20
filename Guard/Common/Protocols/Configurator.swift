//
//  Configurator.swift
//  Guard
//
//  Created by Denys on 7/20/19.
//  Copyright © 2019 Litvinskii Denis. All rights reserved.
//

import Foundation

protocol Configurator {
    var commands: [Command] { get }
    mutating func add(command: Command)
    func configure()
}
