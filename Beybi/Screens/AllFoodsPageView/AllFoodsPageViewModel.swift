//
//  AllFoodsPageViewModel.swift
//  Beybi
//
//  Created by Banu on 14.09.2024.
//

import Foundation
import Food
import FirebaseFirestore
import FirebaseStorage

protocol AllFoodsPageViewModelProtocol {
    func viewDidLoad()
    func numberOfItemsInSection() -> Int
    func typeAtIndex(index: Int) -> String
    func foodAtIndex(index: Int) -> Food?
    func didSelectItemAt(index: Int)
}

protocol AllFoodsPageViewModelDelegate: AnyObject {
    func setUI()
    func prepareCollectionView()
    func prepareSearchController()
    func reloadData()
    func navigateToDetail(selectedCell: Food)
}

final class AllFoodsPageViewModel {
    private weak var delegate: AllFoodsPageViewModelDelegate?
    private var types = ["Breakfast","Soups","Main Dishes","Purees","Snacks","Recommended Recipes"]
    private let firestore = Firestore.firestore()
    private var mainDishes: [Food]? = []
    
    init(delegate: AllFoodsPageViewModelDelegate) {
        self.delegate = delegate
    }
    
    func readMainDishes() {
        firestore.collection("main dishes").getDocuments { (querySnapshot, error) in
    
            if let error = error {
                print("Hata: \(error.localizedDescription)")
            } else if let querySnapshot = querySnapshot {
                for document in querySnapshot.documents {
                    let data = document.data()
                    let name = data["name"] as? String ?? "No name"
                    let cookingTime = data["cooking time"] as? String ?? "20-25 min"
                    let recipe = data["recipe"] as? String ?? "No recipe"
                    let imageUrl = data["imageUrl"] as? String ?? "No image"
                    let type = data["type"] as? String ?? "No type"
                    let introText = data["introText"] as? String ?? "No intro text"
                    let ingredients = data["ingredients"] as? [String] ?? ["No ingredients"]
                    let recipeStep = data["recipeStep"] as? [String] ?? ["No recipe"]
                    
                    let food = Food(name: name, cookingTime: cookingTime, recipe: recipe, imageUrl: imageUrl, type: type, introText: introText, ingredients: ingredients, recipeStep: recipeStep)
                    self.mainDishes?.append(food)
                }
                self.delegate?.reloadData()
            }
        }
    }
}

extension AllFoodsPageViewModel: AllFoodsPageViewModelProtocol {
    func didSelectItemAt(index: Int) {
        var selectedCell: Food?
        
        selectedCell = mainDishes?[index]
        delegate?.navigateToDetail(selectedCell: selectedCell!)
    }
    
    func typeAtIndex(index: Int) -> String {
        let type = types[index]
        return type
    }
    
    func foodAtIndex(index: Int) -> Food? {
        if let food = mainDishes?[index] {
            return food
        }
        return nil
    }
    
    func numberOfItemsInSection() -> Int {
        mainDishes?.count ?? 0
    }
    
    func viewDidLoad() {
        delegate?.setUI()
        delegate?.prepareCollectionView()
        delegate?.prepareSearchController()
        readMainDishes()
    }
}
