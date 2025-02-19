//
//  RecipeCell.swift
//  Beybi
//
//  Created by Banu on 13.10.2024.
//

import UIKit

final class RecipeCell: UICollectionViewCell {

    @IBOutlet weak var stepView: UIView!
    @IBOutlet weak var stepLabel: UILabel!
    @IBOutlet weak var stepNumber: UILabel!
    
    var viewModel: RecipeViewModelProtocol! {
        didSet {
            viewModel.load()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        stepLabel.numberOfLines = 0
        stepView.layer.cornerRadius = 10
    }
}

extension RecipeCell: RecipeViewModelDelegate {
    func configure(recipeStep: String?, index: Int) {
        stepLabel.text = recipeStep
        stepNumber.text = "\(index + 1)"
    }
}
