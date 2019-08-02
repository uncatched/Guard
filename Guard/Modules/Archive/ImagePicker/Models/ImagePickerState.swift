//
//  ImagePickerState.swift
//  Guard
//
//  Created by Denys on 7/30/19.
//  Copyright © 2019 Litvinskii Denis. All rights reserved.
//

import UIKit

enum ImagePickerState {
    case normal
    case accessDeclined
    
    func size(for collectionView: UICollectionView) -> CGSize {
        switch self {
        case .normal:
            return CGSize(width: collectionView.bounds.width/3 - 1,
                          height: collectionView.bounds.width/3 - 1)
        case .accessDeclined:
            return collectionView.bounds.size
        }
    }
}
