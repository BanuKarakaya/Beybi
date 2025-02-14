//
//  IngredientsCell.swift
//  Beybi
//
//  Created by Banu on 11.10.2024.
//

import UIKit

final class IngredientsCell: UICollectionViewCell {
    
   
    @IBOutlet weak var ingredientsLabel: UILabel!
    var darkBeybiColor = UIColor(red: 113/255.0, green: 27/255.0, blue: 41/255.0, alpha: 1)
    
    var viewModel: IngredientsCellViewModelProtocol! {
        didSet {
            viewModel.awakeFromNib()
            viewModel.load()
        }
    }
}

extension IngredientsCell: IngredientsCellViewModelDelegate {
    func setUI() {
        self.layer.cornerRadius = 5
        self.layer.borderWidth = 0.5
        self.layer.borderColor = darkBeybiColor.cgColor
    }
    
    func configure(ingredients: String?) {
        ingredientsLabel.text = ingredients
    }
}
