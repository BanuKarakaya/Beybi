//
//  IngredientsCellViewModel.swift
//  Beybi
//
//  Created by Banu on 14.10.2024.
//

import Foundation

protocol IngredientsCellViewModelProtocol {
    var delegate: IngredientsCellViewModelDelegate? { get set }
    
    func awakeFromNib()
    func load()
}

protocol IngredientsCellViewModelDelegate: AnyObject {
    func configure(ingredients: String?)
    func setUI()
}

class IngredientsCellViewModel {
    weak var delegate: IngredientsCellViewModelDelegate?
    var ingredients: String?
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
