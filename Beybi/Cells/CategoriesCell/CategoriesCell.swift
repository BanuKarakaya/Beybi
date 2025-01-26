//
//  CategoriesCell.swift
//  Beybi
//
//  Created by Banu on 26.01.2025.
//

import UIKit

class CategoriesCell: UICollectionViewCell {

    var beybiColor = UIColor(red: 237/255, green: 136/255, blue: 74/255, alpha: 1.0)
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = 8
        self.layer.borderWidth = 0.7
        self.layer.borderColor = beybiColor.cgColor
    }

}
