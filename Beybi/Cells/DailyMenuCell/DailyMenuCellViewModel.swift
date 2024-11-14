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
    func numberOfItemsInSection(breakfastTapped: Bool, lunchTapped: Bool, dinnerTapped: Bool) -> Int
    func createDailyDinnerMenu() -> [Food]
    func createDailyBreakfastMenu() -> [Food]
    func createDailyLunchMenu() -> [Food]
    func foodAtIndex(index: Int, breakfastTapped: Bool, lunchTapped: Bool, dinnerTapped: Bool) -> Food?
    func sendSelectedCell()
    func didSelectItemAt(index: Int, breakfastTapped: Bool, lunchTapped: Bool, dinnerTapped: Bool) -> Food?
}

protocol DailyMenuCellViewModelDelegate: AnyObject {
    func prepareCollectionView()
    func prepareUI()
    func reloadData()
}

class DailyMenuCellViewModel {
    weak var delegate: DailyMenuCellViewModelDelegate?
    let firestore = Firestore.firestore()
    var breakfasts: [Food]? = []
    var soups: [Food]? = []
    var mainDishes: [Food]? = []
    var purees: [Food]? = []
    var snacks: [Food]? = []
    var randomBreakfastArray: [Food] = []
    var randomLunchArray: [Food] = []
    var randomDinnerArray: [Food] = []
    var selectedCell: Food?
    let group = DispatchGroup()
    
    init(delegate: DailyMenuCellViewModelDelegate) {
        self.delegate = delegate
    }
    
    func readBreakfast() {
        group.enter()
        firestore.collection("breakfastMenu").getDocuments { (querySnapshot, error) in
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
                    self.breakfasts?.append(food)
                }
                self.delegate?.reloadData()
            }
        }
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
    func didSelectItemAt(index: Int, breakfastTapped: Bool, lunchTapped: Bool, dinnerTapped: Bool) -> Food? {
        if breakfastTapped {
            selectedCell = randomBreakfastArray[index]
            return selectedCell
        } else if lunchTapped {
            selectedCell = randomLunchArray[index]
            return selectedCell
        } else if dinnerTapped {
            selectedCell = randomDinnerArray[index]
            return selectedCell
        } else {
            selectedCell = randomDinnerArray[index]
            return selectedCell
        }
    }
    
    func sendSelectedCell() {
        let selectedCell: [String: Food?] = ["selectedCell": selectedCell]
        NotificationCenter.default.post(name: .foodCellTapped, object: nil, userInfo: selectedCell)
    }
    
    func foodAtIndex(index: Int, breakfastTapped: Bool, lunchTapped: Bool, dinnerTapped: Bool) -> Food? {
        if breakfastTapped {
            let food = randomBreakfastArray[index]
                return food
        } else if lunchTapped {
            let food = randomLunchArray[index]
                return food
        } else if dinnerTapped {
            let food = randomDinnerArray[index]
                return food
        } else {
            let food = randomDinnerArray[index]
                return food
        }
    }
    
    func createDailyDinnerMenu() -> [Food] {
        let lastDate = UserDefaults.standard.object(forKey: "lastGeneratedDate") as? Date
        let currentDate = Date()
       
        if let lastDate = lastDate, currentDate.timeIntervalSince(lastDate) < 86400 {
            if let data = UserDefaults.standard.object(forKey: "randomMeals") as? Data,
               let savedMeals = try? JSONDecoder().decode([Food].self, from: data) {
                randomDinnerArray = savedMeals
                return randomDinnerArray
            } else {
                var randomSoup = soups?.shuffled().prefix(1).first
                var randomMain = mainDishes?.shuffled().prefix(1).first
                var randomPuree = purees?.shuffled().prefix(1).first
                var randomSnack = snacks?.shuffled().prefix(1).first
                randomDinnerArray.append(randomSoup!)
                randomDinnerArray.append(randomMain!)
                randomDinnerArray.append(randomPuree!)
                randomDinnerArray.append(randomSnack!)
                if let encoded = try? JSONEncoder().encode(randomDinnerArray) {
                    UserDefaults.standard.set(encoded, forKey: "randomMeals")
                }
                return randomDinnerArray
            }
        } else {
            var randomSoup = soups?.shuffled().prefix(1).first
            var randomMain = mainDishes?.shuffled().prefix(1).first
            var randomPuree = purees?.shuffled().prefix(1).first
            var randomSnack = snacks?.shuffled().prefix(1).first
            randomDinnerArray.append(randomSoup!)
            randomDinnerArray.append(randomMain!)
            randomDinnerArray.append(randomPuree!)
            randomDinnerArray.append(randomSnack!)
            UserDefaults.standard.set(Date(), forKey: "lastGeneratedDate")
            if let encoded = try? JSONEncoder().encode(randomDinnerArray) {
                UserDefaults.standard.set(encoded, forKey: "randomMeals")
            }
            return randomDinnerArray
        }
    }
    
    func createDailyBreakfastMenu() -> [Food] {
        let lastDate = UserDefaults.standard.object(forKey: "lastGeneratedDate") as? Date
        let currentDate = Date()
       
        if let lastDate = lastDate, currentDate.timeIntervalSince(lastDate) < 86400 {
            if let data = UserDefaults.standard.object(forKey: "randomBreakfast") as? Data,
               let savedMeals = try? JSONDecoder().decode([Food].self, from: data) {
                randomBreakfastArray = savedMeals
                return randomBreakfastArray
            } else {
                var randomBreakfast = breakfasts?.shuffled().prefix(1).first
                var randomPuree = purees?.shuffled().prefix(1).first
                randomBreakfastArray.append(randomBreakfast!)
                randomBreakfastArray.append(randomPuree!)
                if let encoded = try? JSONEncoder().encode(randomBreakfastArray) {
                    UserDefaults.standard.set(encoded, forKey: "randomBreakfast")
                }
                return randomBreakfastArray
            }
        } else {
            var randomBreakfast = breakfasts?.shuffled().prefix(1).first
            var randomPuree = purees?.shuffled().prefix(1).first
            randomBreakfastArray.append(randomBreakfast!)
            randomBreakfastArray.append(randomPuree!)
            UserDefaults.standard.set(Date(), forKey: "lastGeneratedDate")
            if let encoded = try? JSONEncoder().encode(randomBreakfastArray) {
                UserDefaults.standard.set(encoded, forKey: "randomBreakfast")
            }
            return randomBreakfastArray
        }
    }
    
    func createDailyLunchMenu() -> [Food] {
        let lastDate = UserDefaults.standard.object(forKey: "lastGeneratedDate") as? Date
        let currentDate = Date()
       
        if let lastDate = lastDate, currentDate.timeIntervalSince(lastDate) < 86400 {
            if let data = UserDefaults.standard.object(forKey: "randomLunch") as? Data,
               let savedMeals = try? JSONDecoder().decode([Food].self, from: data) {
                randomLunchArray = savedMeals
                return randomLunchArray
            } else {
                var randomSoup = soups?.shuffled().prefix(1).first
                var randomPuree = purees?.shuffled().prefix(1).first
                var randomSnack = snacks?.shuffled().prefix(1).first
                randomLunchArray.append(randomSoup!)
                randomLunchArray.append(randomPuree!)
                randomLunchArray.append(randomSnack!)
                if let encoded = try? JSONEncoder().encode(randomLunchArray) {
                    UserDefaults.standard.set(encoded, forKey: "randomLunch")
                }
                return randomLunchArray
            }
        } else {
            var randomSoup = soups?.shuffled().prefix(1).first
            var randomPuree = purees?.shuffled().prefix(1).first
            var randomSnack = snacks?.shuffled().prefix(1).first
            randomLunchArray.append(randomSoup!)
            randomLunchArray.append(randomPuree!)
            randomLunchArray.append(randomSnack!)
            UserDefaults.standard.set(Date(), forKey: "lastGeneratedDate")
            if let encoded = try? JSONEncoder().encode(randomLunchArray) {
                UserDefaults.standard.set(encoded, forKey: "randomLunch")
            }
            return randomLunchArray
        }
    }
    
    func numberOfItemsInSection(breakfastTapped: Bool, lunchTapped: Bool, dinnerTapped: Bool) -> Int {
        if breakfastTapped {
            return randomBreakfastArray.count
        } else if lunchTapped {
            return randomLunchArray.count
        } else if dinnerTapped {
            return randomDinnerArray.count
        } else {
            return randomDinnerArray.count
        }
    }
    
    func viewDidLoad() {
        delegate?.prepareCollectionView()
        delegate?.prepareUI()
        readBreakfast()
        readSoups()
        readMainDishes()
        readPurees()
        readSnacks()
        
        group.notify(queue: .main) {
            print("All processes finished")
            self.createDailyDinnerMenu()
            self.createDailyBreakfastMenu()
            self.createDailyLunchMenu()
            self.delegate?.reloadData()
        }
    }
}
