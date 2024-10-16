//
//  RecipeViewModel.swift
//  Beybi
//
//  Created by Banu on 14.10.2024.
//

import Foundation

protocol RecipeViewModelProtocol {
    var delegate: RecipeViewModelDelegate? { get set }
}

protocol RecipeViewModelDelegate: AnyObject {
    
}

class RecipeViewModel {
    weak var delegate: RecipeViewModelDelegate?
}

extension RecipeViewModel: RecipeViewModelProtocol {
    
}
