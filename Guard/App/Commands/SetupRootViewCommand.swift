//
//  SetupRootViewCommand.swift
//  Guard
//
//  Created by Denys on 8/8/19.
//  Copyright © 2019 Litvinskii Denis. All rights reserved.
//

import UIKit

struct SetupRootViewCommand: Command {
    
    func execute() {
        let viewController = UIStoryboard(name: "Launch", bundle: nil).instantiateViewController(withIdentifier: "LaunchViewController")
        UIApplication.shared.keyWindow?.rootViewController = viewController
    }
}
