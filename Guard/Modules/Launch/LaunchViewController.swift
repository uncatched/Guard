//
//  LaunchViewController.swift
//  Guard
//
//  Created by Denys on 8/8/19.
//  Copyright © 2019 Litvinskii Denis. All rights reserved.
//

import UIKit

final class LaunchViewController: UIViewController {
    
    // MARK: - Properties
    private let passcode = PasscodeManager(with: NSLocalizedString("launch_label_authToProceed", comment: ""))

    // MARK: - Life Cycle
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        passcode.onSuccess = passcodeSuccessHandler
        passcode.onError = passcodeErrorHandler
        passcode.evaluate()
    }
}

// MARK: - Private methods
extension LaunchViewController {
    
    private func passcodeSuccessHandler() {
        let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MainTabBarController")
        UIApplication.shared.keyWindow?.rootViewController = viewController
    }
    
    private func passcodeErrorHandler(_ error: Error?) {
        print(error?.localizedDescription ?? "")
    }
}
