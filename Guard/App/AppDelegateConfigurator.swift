//
//  AppDelegateConfigurator.swift
//  Guard
//
//  Created by Denys on 7/20/19.
//  Copyright © 2019 Litvinskii Denis. All rights reserved.
//

import UIKit

struct AppDelegateConfigurator: Configurator {
    
    // MARK: - Properties
    var commands: [Command] = []
    
    // MARK: - Public methods
    mutating func add(command: Command) {
        commands.append(command)
    }
    
    func configure() {
        commands.forEach { $0.execute() }
    }
}
