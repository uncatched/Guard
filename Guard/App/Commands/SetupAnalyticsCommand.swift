//
//  SetupAnalyticsCommand.swift
//  Guard
//
//  Created by Denys on 7/20/19.
//  Copyright © 2019 Litvinskii Denis. All rights reserved.
//

import Firebase

struct SetupAnalyticsCommand: Command {
    
    func execute() {
        FirebaseApp.configure()
    }
}
