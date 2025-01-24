//
//  UICollectionViewCell+Extension.swift
//  Beybi
//
//  Created by Banu on 14.09.2024.
//

import UIKit

extension UICollectionViewCell {
    public static var identifier: String {
        return String(describing: self)
    }
   
    public static var nib: UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
}
