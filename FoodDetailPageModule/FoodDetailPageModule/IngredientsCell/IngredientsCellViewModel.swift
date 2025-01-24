//
//  IngredientsCellViewModel.swift
//  Beybi
//
//  Created by Banu on 14.10.2024.
//

import Foundation

protocol IngredientsCellViewModelProtocol {
    
    func awakeFromNib()
    func load()
}

protocol IngredientsCellViewModelDelegate: AnyObject {
    func configure(ingredients: String?)
    func setUI()
}

final class IngredientsCellViewModel {
    private weak var delegate: IngredientsCellViewModelDelegate?
    private var ingredients: String?
    
    init(delegate: IngredientsCellViewModelDelegate?, ingredients: String?) {
        self.delegate = delegate
        self.ingredients = ingredients
    }
}

extension IngredientsCellViewModel: IngredientsCellViewModelProtocol {
    func load() {
        if let ingredients = ingredients {
            delegate?.configure(ingredients: ingredients)
        }
    }
    
    func awakeFromNib() {
        delegate?.setUI()
    }
}
