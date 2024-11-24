//
//  RecipeViewModel.swift
//  Beybi
//
//  Created by Banu on 14.10.2024.
//

import Foundation

protocol RecipeViewModelProtocol {
    var delegate: RecipeViewModelDelegate? { get set }
    
    func load()
}

protocol RecipeViewModelDelegate: AnyObject {
    func configure(recipeStep: String?, index: Int)
}

final class RecipeViewModel {
    weak var delegate: RecipeViewModelDelegate?
    var recipeStep: String?
    var recipeIndex: Int?
}

extension RecipeViewModel: RecipeViewModelProtocol {
    func load() {
        delegate?.configure(recipeStep: recipeStep, index: recipeIndex ?? 0)
    }
}
