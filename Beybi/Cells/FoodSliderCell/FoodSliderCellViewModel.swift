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
    let group = DispatchGroup()
    
    func readSoups() {
        firestore.collection("soups").getDocuments { (querySnapshot, error) in
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
                    
                    let soup = Food(name: name, cookingTime: cookingTime, recipe: recipe, imageUrl: imageUrl, type: type)
                    self.soups?.append(soup)
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
                    let cookingTime = data["cooking time"] as? String ?? "Süre yok"
                    let recipe = data["recipe"] as? String ?? "Tarif yok"
                    let imageUrl = data["imageUrl"] as? String ?? "Foto yok"
                    let type = data["type"] as? String ?? "Type yok"
                    
                    let soup = Food(name: name, cookingTime: cookingTime, recipe: recipe, imageUrl: imageUrl, type: type)
                    self.mainDishes?.append(soup)
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
                    
                    let soup = Food(name: name, cookingTime: cookingTime, recipe: recipe, imageUrl: imageUrl, type: type)
                    self.purees?.append(soup)
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
                    
                    let soup = Food(name: name, cookingTime: cookingTime, recipe: recipe, imageUrl: imageUrl, type: type)
                    self.snacks?.append(soup)
                }
                self.delegate?.reloadData()
            }
        }
    }
}

extension FoodSliderCellViewModel: FoodSliderCellViewModelProtocol {
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
        
        group.enter()
        readSoups()
        group.leave()
        
        group.enter()
        readMainDishes()
        group.leave()
        
        group.enter()
        readPurees()
        group.leave()
        
        group.enter()
        readSoups()
        group.leave()
        
        group.enter()
        readSnacks()
        group.leave()
        
        group.notify(queue: .main) {
            print("Tüm veriler çekildi!")
        }
    }
}
