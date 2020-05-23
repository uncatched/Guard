//
//  MainTabBarController.swift
//  Guard
//
//  Created by Denys Litvinskyi on 14.05.2020.
//  Copyright © 2020 Litvinskii Denis. All rights reserved.
//

import UIKit

final class MainTabBarController: UITabBarController {

    private let titles: [String] = [
        NSLocalizedString("systemInfo_label_title", comment: ""),
        NSLocalizedString("scan_label_title", comment: ""),
        NSLocalizedString("storage_title_passwords", comment: ""),
        NSLocalizedString("zip_title_zip", comment: "")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let viewControllers = viewControllers else {
            return
        }
        
        for i in 0..<viewControllers.count {
            viewControllers[i].tabBarItem.title = titles[i]
        }
    }
}
