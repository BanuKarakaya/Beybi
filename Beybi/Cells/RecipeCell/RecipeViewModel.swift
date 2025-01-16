//
//  RecipeViewModel.swift
//  Beybi
//
//  Created by Banu on 14.10.2024.
//

import Foundation

protocol RecipeViewModelProtocol {
    func load()
}

protocol RecipeViewModelDelegate: AnyObject {
    func configure(recipeStep: String?, index: Int)
}

final class RecipeViewModel {
    private weak var delegate: RecipeViewModelDelegate?
    private var recipeStep: String?
    private var recipeIndex: Int?
    
    init(delegate: RecipeViewModelDelegate?, recipeStep: String?, recipeIndex: Int?) {
        self.delegate = delegate
        self.recipeStep = recipeStep
        self.recipeIndex = recipeIndex
    }
}

extension RecipeViewModel: RecipeViewModelProtocol {
    func load() {
        delegate?.configure(recipeStep: recipeStep, index: recipeIndex ?? 0)
    }
}
