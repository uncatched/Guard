//
//  NibLoadable.swift
//  Guard
//
//  Created by Denys on 7/29/19.
//  Copyright © 2019 Litvinskii Denis. All rights reserved.
//

import UIKit

protocol NibLoadable: class {
    static var nib: UINib { get }
    static var nibView: UIView { get }
}

extension NibLoadable {
    
    static var nib: UINib {
        return UINib(nibName: String(describing: self), bundle: Bundle(for: self))
    }
    
    static var nibView: UIView {
        
        guard let view = nib.instantiate(withOwner: self, options: nil)[0] as? UIView else {
            fatalError("Can't instantiate a \(self)")
        }
        
        return view
    }
}
