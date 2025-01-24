//
//  FoodDetailPageViewModel.swift
//  Beybi
//
//  Created by Banu on 11.10.2024.
//

import Foundation
import Food

public protocol FoodDetailPageViewModelProtocol {
    func viewDidLoad()
    func ingredientsAtIndex(index: Int) -> String?
    func recipeStepAtIndex(index: Int) -> String?
    func numberOfItemsForIngredients() -> Int
    func numberOfItemsForRecipeStep() -> Int
}

public protocol FoodDetailPageViewModelDelegate: AnyObject {
    func configure(selectedFood: Food?)
    func prepareBannerImage(with urlString: String?)
    func prepareUI()
    func prepareCollectionView()
}

public class FoodDetailPageViewModel {
    private weak var delegate: FoodDetailPageViewModelDelegate?
    public var selectedFood: Food?
    
    public init(delegate: FoodDetailPageViewModelDelegate) {
        self.delegate = delegate
    }
}

extension FoodDetailPageViewModel: FoodDetailPageViewModelProtocol {
    public func numberOfItemsForRecipeStep() -> Int {
        selectedFood?.recipeStep.count ?? 0
    }
    
    public func recipeStepAtIndex(index: Int) -> String? {
        if let recipeStep = selectedFood?.recipeStep[index] {
            return recipeStep
        }
        return nil
    }
    
    public func numberOfItemsForIngredients() -> Int{
        selectedFood?.ingredients.count ?? 0
        
    }
    
    public func ingredientsAtIndex(index: Int) -> String? {
        if let ingredient = selectedFood?.ingredients[index] {
            return ingredient
        }
        return nil
 }
   
    public func viewDidLoad() {
        delegate?.prepareUI()
        delegate?.prepareCollectionView()
        delegate?.configure(selectedFood: selectedFood)
    }
}
