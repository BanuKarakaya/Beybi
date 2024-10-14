//
//  IngredientsCell.swift
//  Beybi
//
//  Created by Banu on 11.10.2024.
//

import UIKit

class IngredientsCell: UICollectionViewCell {

    @IBOutlet weak var ingredientsLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = 5
    }

}
