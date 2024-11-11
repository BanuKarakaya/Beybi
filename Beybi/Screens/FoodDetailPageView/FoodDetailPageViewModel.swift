//
//  FoodDetailPageViewModel.swift
//  Beybi
//
//  Created by Banu on 11.10.2024.
//

import Foundation

protocol FoodDetailPageViewModelProtocol {
    var delegate: FoodDetailPageViewModelDelegate? { get set }
    
    func viewDidLoad()
    func ingredientsAtIndex(index: Int) -> String?
    func recipeStepAtIndex(index: Int) -> String?
    func numberOfItemsForIngredients() -> Int
    func numberOfItemsForRecipeStep() -> Int
}

protocol FoodDetailPageViewModelDelegate: AnyObject {
    func configure(selectedFood: Food?)
    func prepareBannerImage(with urlString: String?)
    func prepareUI()
    func prepareCollectionView()
}

class FoodDetailPageViewModel {
    weak var delegate: FoodDetailPageViewModelDelegate?
    var selectedFood: Food?
    
    
    
    init(delegate: FoodDetailPageViewModelDelegate) {
        self.delegate = delegate
    }
}

extension FoodDetailPageViewModel: FoodDetailPageViewModelProtocol {
    func numberOfItemsForRecipeStep() -> Int {
        selectedFood?.recipeStep.count ?? 0
    }
    
    func recipeStepAtIndex(index: Int) -> String? {
        if let recipeStep = selectedFood?.recipeStep[index] {
            return recipeStep
        }
        return nil
    }
    
    func numberOfItemsForIngredients() -> Int{
        selectedFood?.ingredients.count ?? 0
        
    }
    
    func ingredientsAtIndex(index: Int) -> String? {
        if let ingredient = selectedFood?.ingredients[index] {
            return ingredient
        }
        return nil
 }
   
    func viewDidLoad() {
        delegate?.prepareUI()
        delegate?.prepareCollectionView()
        delegate?.configure(selectedFood: selectedFood)
    }
}
