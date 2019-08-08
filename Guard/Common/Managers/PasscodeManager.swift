//
//  PasscodeManager.swift
//  Guard
//
//  Created by Denys on 8/8/19.
//  Copyright © 2019 Litvinskii Denis. All rights reserved.
//

import Foundation
import LocalAuthentication

final class PasscodeManager {
    
    // MARK: - Properties
    private let context = LAContext()
    private let reason: String
    
    var onSuccess: (() -> Void)?
    var onError: ((Error?) -> Void)?
    
    // MARK: - Init / Deinit methods
    init(with reason: String) {
        self.reason = reason
    }
}

// MARK: - Public methods
extension PasscodeManager {
    
    func evaluate() {
        context.evaluatePolicy(.deviceOwnerAuthentication,
                               localizedReason: reason,
                               reply: replyHandler)
    }
}

// MARK: - Private methods
extension PasscodeManager {
    
    private func replyHandler(_ success: Bool, _ error: Error?) {
        DispatchQueue.main.async { [unowned self] in
            guard success else {
                self.onError?(error)
                return
            }
            
            self.onSuccess?()
        }
    }
}
