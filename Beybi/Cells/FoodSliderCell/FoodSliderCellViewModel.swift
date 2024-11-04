//
//  FoodSliderCellViewModel.swift
//  Beybi
//
//  Created by Banu on 14.09.2024.
//

import Foundation
import FirebaseFirestore
import FirebaseStorage

protocol FoodSliderCellViewModelProtocol {
    var delegate: FoodSliderCellViewModelDelegate? { get set }
    
    func viewDidLoad()
    func numberOfItemsInSection() -> Int
    func minimumInteritemSpacingForSectionAt() -> CGFloat
    func minimumLineSpacingForSectionAt() -> CGFloat
    func foodAtIndex(index: Int) -> Food?
    func load()
    func didSelectItemAt(index: Int) -> Food?
}

protocol FoodSliderCellViewModelDelegate: AnyObject {
    func prepareCollectionView()
    func reloadData()
    func configureCell(type: String)
}

class FoodSliderCellViewModel {
    weak var delegate: FoodSliderCellViewModelDelegate?
    var soups: [Food]? = []
    var mainDishes: [Food]? = []
    var purees: [Food]? = []
    var snacks: [Food]? = []
    var type: String?
    let firestore = Firestore.firestore()
    var selectedCell: Food?
    
    func readSoups() {
        firestore.collection("soups").getDocuments { (querySnapshot, error) in
            if let error = error {
                print("Hata: \(error.localizedDescription)")
            } else {
                for document in querySnapshot!.documents {
                    let data = document.data()
                    let name = data["name"] as? String ?? "İsim yok"
                    let cookingTime = data["cooking time"] as? String ?? "20-25 min"
                    let recipe = data["recipe"] as? String ?? "Tarif yok"
                    let imageUrl = data["imageUrl"] as? String ?? "Foto yok"
                    let type = data["type"] as? String ?? "Type yok"
                    let introText = data["introText"] as? String ?? "intro text yok"
                    let ingredients = data["ingredients"] as? [String] ?? ["Malzeme yok"]
                    let recipeStep = data["recipeStep"] as? [String] ?? ["Tarif yok"]
                    
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
            } else {
                for document in querySnapshot!.documents {
                    let data = document.data()
                    let name = data["name"] as? String ?? "İsim yok"
                    let cookingTime = data["cooking time"] as? String ?? "35-40 min"
                    let recipe = data["recipe"] as? String ?? "Tarif yok"
                    let imageUrl = data["imageUrl"] as? String ?? "Foto yok"
                    let type = data["type"] as? String ?? "Type yok"
                    let introText = data["introText"] as? String ?? "intro text yok"
                    let ingredients = data["ingredients"] as? [String] ?? ["Malzeme yok"]
                    let recipeStep = data["recipeStep"] as? [String] ?? ["Tarif yok"]
                    
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
            } else {
                for document in querySnapshot!.documents {
                    let data = document.data()
                    let name = data["name"] as? String ?? "İsim yok"
                    let cookingTime = data["cooking time"] as? String ?? "Süre yok"
                    let recipe = data["recipe"] as? String ?? "Tarif yok"
                    let imageUrl = data["imageUrl"] as? String ?? "Foto yok"
                    let type = data["type"] as? String ?? "Type yok"
                    let introText = data["introText"] as? String ?? "intro text yok"
                    let ingredients = data["ingredients"] as? [String] ?? ["Malzeme yok"]
                    let recipeStep = data["recipeStep"] as? [String] ?? ["Tarif yok"]
                    
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
            } else {
                for document in querySnapshot!.documents {
                    let data = document.data()
                    let name = data["name"] as? String ?? "İsim yok"
                    let cookingTime = data["cooking time"] as? String ?? "Süre yok"
                    let recipe = data["recipe"] as? String ?? "Tarif yok"
                    let imageUrl = data["imageUrl"] as? String ?? "Foto yok"
                    let type = data["type"] as? String ?? "Type yok"
                    let introText = data["introText"] as? String ?? "intro text yok"
                    let ingredients = data["ingredients"] as? [String] ?? ["Malzeme yok"]
                    let recipeStep = data["recipeStep"] as? [String] ?? ["Tarif yok"]
                    
                    let food = Food(name: name, cookingTime: cookingTime, recipe: recipe, imageUrl: imageUrl, type: type, introText: introText, ingredients: ingredients, recipeStep: recipeStep)
                    self.snacks?.append(food)
                }
                self.delegate?.reloadData()
            }
        }
    }
}

extension FoodSliderCellViewModel: FoodSliderCellViewModelProtocol {
    func didSelectItemAt(index: Int) -> Food? {
        
        if type == "Soups" {
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
        if type == "Soups" {
            if let food = soups?[index] {
                return food
            }
        } else if type == "Main Dishes" {
            if let food = mainDishes?[index] {
                return food
            }
        } else if type == "Snacks" {
            if let food = snacks?[index] {
                return food
            }
        } else if type == "Purees" {
            if let food = purees?[index] {
                return food
            }
        }
         return nil
    }
    
    func minimumLineSpacingForSectionAt() -> CGFloat {
        10
    }
    
    func minimumInteritemSpacingForSectionAt() -> CGFloat {
        3
    }
    
    func numberOfItemsInSection() -> Int {
        return soups!.count
    }
    
    func viewDidLoad() {
        delegate?.prepareCollectionView()
        
        readSoups()
        readMainDishes()
        readPurees()
        readSnacks()
    }
}
