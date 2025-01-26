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
    func load()
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
    
    init(delegate: FoodSliderCellViewModelDelegate?, type: String?) {
        self.delegate = delegate
        self.type = type
    }
    
    func readBreakfast() {
        firestore.collection("breakfastMenu").getDocuments { (querySnapshot, error) in
            
            
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
                    self.breakfasts?.append(food)
                }
                self.delegate?.reloadData()
            }
        }
    }
    
    func readSoups() {
        firestore.collection("soups").getDocuments { (querySnapshot, error) in
            
            
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
                    self.soups?.append(food)
                }
                self.delegate?.reloadData()
            }
        }
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
    
    func readPurees() {
       
        firestore.collection("purees").getDocuments { (querySnapshot, error) in
            
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
                    self.purees?.append(food)
                }
                self.delegate?.reloadData()
            }
        }
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
        NotificationCenter.default.post(name: .foodSliderCellTapped, object: nil, userInfo: selectedCell)
    }
    
    func didSelectItemAt(index: Int) -> Food? {
        
        if type == "Breakfast" {
            selectedCell = breakfasts?[index]
            return selectedCell
        } else if type == "Soups" {
            selectedCell = soups?[index]
            return selectedCell
        } else if type == "Main Dishes" {
            selectedCell = mainDishes?[index]
            return selectedCell
        } else if type == "Snacks" {
            selectedCell = snacks?[index]
            return selectedCell
        } else if type == "Purees" {
            selectedCell = purees?[index]
            return selectedCell
        }
        
        return selectedCell
    }
    
    func load() {
        if let type = type {
            delegate?.configureCell(type: type)
        }
    }
    
    func foodAtIndex(index: Int) -> Food? {
        
        if type == "Breakfast" {
            if let food = breakfasts?[index] {
                return food
            }
        } else if type == "Soups" {
            if let food = soups?[index] {
                return food
            }
        } else if type == "Main Dishes" {
            if let food = mainDishes?[index] {
                return food
            }
        } else if type == "Purees" {
            if let food = purees?[index] {
                return food
            }
        } else if type == "Snacks" {
            if let food = snacks?[index] {
                return food
            }
        } else if type == "Recommended Recipes" {
            if let food = snacks?[index] {
                return food
            }
        }
        return nil
    }
    
    func minimumInteritemSpacingForSectionAt() -> CGFloat {
        16
    }
    
    func numberOfItemsInSection() -> Int {
       
        if type == "Breakfast" {
            return breakfasts?.count ?? 0
        } else if type == "Soups" {
            return soups?.count ?? 0
        } else if type == "Main Dishes" {
            return mainDishes?.count ?? 0
        } else if type == "Purees" {
            return purees?.count ?? 0
        } else if type == "Snacks" {
            return snacks?.count ?? 0
        } else {
            return snacks?.count ?? 2
        }
    }
    
    func viewDidLoad() {
        delegate?.prepareCollectionView()
        
        if type == "Breakfast" {
            readBreakfast()
        } else if type == "Soups" {
            readSoups()
        } else if type == "Main Dishes" {
            readMainDishes()
        } else if type == "Purees" {
            readPurees()
        } else {
            readSnacks()
        }
    }
}
