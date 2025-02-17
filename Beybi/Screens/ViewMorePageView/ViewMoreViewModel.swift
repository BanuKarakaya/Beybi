//
//  ViewMoreViewModel.swift
//  Beybi
//
//  Created by Banu on 19.09.2024.
//

import Foundation
import FirebaseFirestore
import FirebaseStorage

protocol ViewMoreViewModelProtocol {
    func viewDidLoad()
    func numberOfItemsInSection() -> Int
    func foodAtIndex(index: Int) -> Food?
    func didSelectItemAt(index: Int)
    func setTitle(foodType: String?)
}

protocol ViewMoreViewModelDelegate: AnyObject {
    func prepareCollectionView()
    func prepareUI(foodType: String?)
    func navigateToDetailVC(selectedCell: Food?)
    func reloadData()
}

final class ViewMoreViewModel {
    private weak var delegate: ViewMoreViewModelDelegate?
    private var foodArray: [Food]? = []
    let firestore = Firestore.firestore()
    var foodType: String?
    
    init(delegate: ViewMoreViewModelDelegate) {
        self.delegate = delegate
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
                    let ingredients = data["ingredients"] as? [String] ?? ["no ingredients"]
                    let recipeStep = data["recipeStep"] as? [String] ?? ["No recipe step"]
                    
                    let food = Food(name: name, cookingTime: cookingTime, recipe: recipe, imageUrl: imageUrl, type: type, introText: introText, ingredients: ingredients, recipeStep: recipeStep)
                    self.foodArray?.append(food)
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
                    let name = data["name"] as? String ?? "İsim yok"
                    let cookingTime = data["cooking time"] as? String ?? "20-25 min"
                    let recipe = data["recipe"] as? String ?? "Tarif yok"
                    let imageUrl = data["imageUrl"] as? String ?? "Foto yok"
                    let type = data["type"] as? String ?? "Type yok"
                    let introText = data["introText"] as? String ?? "intro text yok"
                    let ingredients = data["ingredients"] as? [String] ?? ["Malzeme yok"]
                    let recipeStep = data["recipeStep"] as? [String] ?? ["Tarif yok"]
                    
                    let food = Food(name: name, cookingTime: cookingTime, recipe: recipe, imageUrl: imageUrl, type: type, introText: introText, ingredients: ingredients, recipeStep: recipeStep)
                    print(food)
                    self.foodArray?.append(food)
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
                    let name = data["name"] as? String ?? "İsim yok"
                    let cookingTime = data["cooking time"] as? String ?? "35-40 min"
                    let recipe = data["recipe"] as? String ?? "Tarif yok"
                    let imageUrl = data["imageUrl"] as? String ?? "Foto yok"
                    let type = data["type"] as? String ?? "Type yok"
                    let introText = data["introText"] as? String ?? "intro text yok"
                    let ingredients = data["ingredients"] as? [String] ?? ["Malzeme yok"]
                    let recipeStep = data["recipeStep"] as? [String] ?? ["Tarif yok"]
                    
                    let food = Food(name: name, cookingTime: cookingTime, recipe: recipe, imageUrl: imageUrl, type: type, introText: introText, ingredients: ingredients, recipeStep: recipeStep)
                    self.foodArray?.append(food)
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
                    let name = data["name"] as? String ?? "İsim yok"
                    let cookingTime = data["cooking time"] as? String ?? "Süre yok"
                    let recipe = data["recipe"] as? String ?? "Tarif yok"
                    let imageUrl = data["imageUrl"] as? String ?? "Foto yok"
                    let type = data["type"] as? String ?? "Type yok"
                    let introText = data["introText"] as? String ?? "intro text yok"
                    let ingredients = data["ingredients"] as? [String] ?? ["Malzeme yok"]
                    let recipeStep = data["recipeStep"] as? [String] ?? ["Tarif yok"]
                    
                    let food = Food(name: name, cookingTime: cookingTime, recipe: recipe, imageUrl: imageUrl, type: type, introText: introText, ingredients: ingredients, recipeStep: recipeStep)
                    self.foodArray?.append(food)
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
                    let name = data["name"] as? String ?? "İsim yok"
                    let cookingTime = data["cooking time"] as? String ?? "Süre yok"
                    let recipe = data["recipe"] as? String ?? "Tarif yok"
                    let imageUrl = data["imageUrl"] as? String ?? "Foto yok"
                    let type = data["type"] as? String ?? "Type yok"
                    let introText = data["introText"] as? String ?? "intro text yok"
                    let ingredients = data["ingredients"] as? [String] ?? ["Malzeme yok"]
                    let recipeStep = data["recipeStep"] as? [String] ?? ["Tarif yok"]
                    
                    let food = Food(name: name, cookingTime: cookingTime, recipe: recipe, imageUrl: imageUrl, type: type, introText: introText, ingredients: ingredients, recipeStep: recipeStep)
                    self.foodArray?.append(food)
                }
                self.delegate?.reloadData()
            }
        }
    }
}

extension ViewMoreViewModel: ViewMoreViewModelProtocol {
    func setTitle(foodType: String?) {
        delegate?.prepareUI(foodType: foodType)
    }
    
    func didSelectItemAt(index: Int) {
        var selectedCell: Food?
        
        selectedCell = foodArray?[index]
        delegate?.navigateToDetailVC(selectedCell: selectedCell)
    }
    
    func foodAtIndex(index: Int) -> Food? {
        if let food = foodArray?[index] {
            return food
        }
        return nil
    }
    
   
    func numberOfItemsInSection() -> Int {
        foodArray?.count ?? 0
    }
    
    func viewDidLoad() {
        delegate?.prepareCollectionView()
        setTitle(foodType: foodType)
        
        if foodType == "Breakfast" {
           readBreakfast()
        } else if foodType == "Soups" {
            readSoups()
        } else if foodType == "Main Dishes" {
            readMainDishes()
        } else if foodType == "Purees" {
            readPurees()
        } else {
            readSnacks()
        }
    }
}

