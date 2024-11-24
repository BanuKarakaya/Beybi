//
//  RecipeCell.swift
//  Beybi
//
//  Created by Banu on 13.10.2024.
//

import UIKit

final class RecipeCell: UICollectionViewCell {

    @IBOutlet private weak var view: UIView!
    @IBOutlet private weak var stepLabel: UILabel!
    @IBOutlet private weak var stepNumber: UILabel!
    
    var viewModel: RecipeViewModelProtocol! {
        didSet {
            viewModel.delegate = self
            viewModel.load()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        view.layer.cornerRadius = 10
        stepLabel.numberOfLines = 0
    }
}

extension RecipeCell: RecipeViewModelDelegate {
    func configure(recipeStep: String?, index: Int) {
        stepLabel.text = recipeStep
        stepNumber.text = "Step \(index + 1)"
    }
}
