//
//  UICollectionView+Extension.swift
//  Beybi
//
//  Created by Banu on 14.09.2024.
//

import UIKit

extension UICollectionView {
    
    func register(cellType:UICollectionViewCell.Type){
        register(cellType.nib, forCellWithReuseIdentifier: cellType.identifier)
    }
    
    func dequeCell<T: UICollectionViewCell>(cellType: T.Type, indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withReuseIdentifier: cellType.identifier, for: indexPath) as? T else {fatalError()}
        return cell
    }
    
}

