//
//  FoodSliderCellViewModel.swift
//  Beybi
//
//  Created by Banu on 14.09.2024.
//

import Foundation
import FirebaseFirestore
import FirebaseStorage
import Food

protocol FoodSliderCellViewModelProtocol {
    func viewDidLoad()
    func numberOfItemsInSection() -> Int
    func minimumInteritemSpacingForSectionAt() -> CGFloat
    func foodAtIndex(index: Int) -> Food?
    //func load()
    func didSelectItemAt(index: Int) -> Food?
    func sendSelectedCell()
}

protocol FoodSliderCellViewModelDelegate: AnyObject {
    func prepareCollectionView()
    func reloadData()
    func configureCell(type: String)
}

final class FoodSliderCellViewModel {
    private weak var delegate: FoodSliderCellViewModelDelegate?
    private var breakfasts: [Food]? = []
    private var soups: [Food]? = []
    private var mainDishes: [Food]? = []
    private var purees: [Food]? = []
    private var snacks: [Food]? = []
    private var type: String?
    let firestore = Firestore.firestore()
    var selectedCell: Food?
    
    init(delegate: FoodSliderCellViewModelDelegate?) {
        self.delegate = delegate
    }

    func readSnacks() {
        
        firestore.collection("snacks").getDocuments { (querySnapshot, error) in
            
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
                    self.snacks?.append(food)
                }
                self.delegate?.reloadData()
            }
        }
    }
}

extension FoodSliderCellViewModel: FoodSliderCellViewModelProtocol {
    func sendSelectedCell() {
        let selectedCell: [String: Food?] = ["selectedCell": selectedCell]
        NotificationCenter.default.post(name: .foodSliderCellTapped, object: nil, userInfo: selectedCell as [AnyHashable : Any])
    }

    func didSelectItemAt(index: Int) -> Food? {
        selectedCell = snacks?[index]
        return selectedCell
    }
//
//    //func load() {
//    //    if let type = type {
//     //       delegate?.configureCell(type: type)
//    //    }
//    //}
//    
    func foodAtIndex(index: Int) -> Food? {
        if let food = snacks?[index] {
                return food
        }
        return nil
    }
    
    func minimumInteritemSpacingForSectionAt() -> CGFloat {
        16
    }
    
    func numberOfItemsInSection() -> Int {
        return snacks?.count ?? 0
    }
    
    func viewDidLoad() {
        readSnacks()
        delegate?.prepareCollectionView()
    }
}
