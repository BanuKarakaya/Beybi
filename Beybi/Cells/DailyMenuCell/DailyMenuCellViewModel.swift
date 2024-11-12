//
//  DailyMenuCellViewModel.swift
//  Beybi
//
//  Created by Banu on 19.09.2024.
//

import Foundation
import FirebaseFirestore
import FirebaseStorage

protocol DailyMenuCellViewModelProtocol {
    var delegate: DailyMenuCellViewModelDelegate? { get set }
    
    func viewDidLoad()
    func numberOfItemsInSection() -> Int
    func createDailyMenu() -> [Food]
    func foodAtIndex(index: Int) -> Food?
}

protocol DailyMenuCellViewModelDelegate: AnyObject {
    func prepareCollectionView()
    func prepareUI()
    func reloadData()
}

class DailyMenuCellViewModel {
    weak var delegate: DailyMenuCellViewModelDelegate?
    let firestore = Firestore.firestore()
    var soups: [Food]? = []
    var mainDishes: [Food]? = []
    var purees: [Food]? = []
    var snacks: [Food]? = []
    var randomMealsArray: [Food] = []
    let group = DispatchGroup()
    
    init(delegate: DailyMenuCellViewModelDelegate) {
        self.delegate = delegate
    }
    
    func readSoups() {
        group.enter()
        firestore.collection("soups").getDocuments { (querySnapshot, error) in
            defer { self.group.leave() }
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
        group.enter()
        firestore.collection("main dishes").getDocuments { (querySnapshot, error) in
            defer { self.group.leave() }
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
        group.enter()
        firestore.collection("purees").getDocuments { (querySnapshot, error) in
            defer { self.group.leave() }
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
        group.enter()
        firestore.collection("snacks").getDocuments { (querySnapshot, error) in
            defer { self.group.leave() }
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

extension DailyMenuCellViewModel: DailyMenuCellViewModelProtocol {
    func foodAtIndex(index: Int) -> Food? {
         let food = randomMealsArray[index]
            return food
    }
    
    func createDailyMenu() -> [Food] {
        let lastDate = UserDefaults.standard.object(forKey: "lastGeneratedDate") as? Date
        let currentDate = Date()
       
        if let lastDate = lastDate, currentDate.timeIntervalSince(lastDate) < 86400 {
            if let data = UserDefaults.standard.object(forKey: "randomMeals") as? Data,
               let savedMeals = try? JSONDecoder().decode([Food].self, from: data) {
                 randomMealsArray = savedMeals
                return randomMealsArray
            } else {
                var randomSoup = soups?.shuffled().prefix(1).first
                var randomMain = mainDishes?.shuffled().prefix(1).first
                var randomPuree = purees?.shuffled().prefix(1).first
                var randomSnack = snacks?.shuffled().prefix(1).first
                randomMealsArray.append(randomSoup!)
                randomMealsArray.append(randomMain!)
                randomMealsArray.append(randomPuree!)
                randomMealsArray.append(randomSnack!)
                if let encoded = try? JSONEncoder().encode(randomMealsArray) {
                    UserDefaults.standard.set(encoded, forKey: "randomMeals")
                }
                return randomMealsArray
            }
        } else {
            var randomSoup = soups?.shuffled().prefix(1).first
            var randomMain = mainDishes?.shuffled().prefix(1).first
            var randomPuree = purees?.shuffled().prefix(1).first
            var randomSnack = snacks?.shuffled().prefix(1).first
            randomMealsArray.append(randomSoup!)
            randomMealsArray.append(randomMain!)
            randomMealsArray.append(randomPuree!)
            randomMealsArray.append(randomSnack!)
            UserDefaults.standard.set(Date(), forKey: "lastGeneratedDate")
            if let encoded = try? JSONEncoder().encode(randomMealsArray) {
                UserDefaults.standard.set(encoded, forKey: "randomMeals")
            }
            return randomMealsArray
        }
    }
    
    func numberOfItemsInSection() -> Int {
        randomMealsArray.count
    }
    
    func viewDidLoad() {
        delegate?.prepareCollectionView()
        delegate?.prepareUI()
        readSoups()
        readMainDishes()
        readPurees()
        readSnacks()
        
        group.notify(queue: .main) {
            print("All processes finished")
            self.createDailyMenu()
            self.delegate?.reloadData()
        }
    }
}
