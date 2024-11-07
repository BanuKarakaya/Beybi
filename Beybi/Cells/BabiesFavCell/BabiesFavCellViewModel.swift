//
//  BabiesFavCellViewModel.swift
//  Beybi
//
//  Created by Banu on 19.09.2024.
//

import Foundation
import FirebaseFirestore
import FirebaseStorage

protocol BabiesFavCellViewModelProtocol {
    var delegate: BabiesFavCellViewModelDelegate? { get set }
    
    func viewDidLoad()
    func numberOfItemsInSection() -> Int
    func minimumLineSpacingForSectionAt() -> CGFloat
    func foodAtIndex(index: Int) -> Food?
}

protocol BabiesFavCellViewModelDelegate: AnyObject {
    func prepareCollectionView()
    func reloadData()
}

class BabiesFavCellViewModel {
    weak var delegate: BabiesFavCellViewModelDelegate?
    let firestore = Firestore.firestore()
    var babyFavs: [Food]? = []
    
    init(delegate: BabiesFavCellViewModelDelegate) {
        self.delegate = delegate
    }
    
    func readBabyFavs() {
        firestore.collection("babies fav").getDocuments { (querySnapshot, error) in
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
                    print(food)
                    self.babyFavs?.append(food)
                }
                self.delegate?.reloadData()
            }
        }
    }
}

extension BabiesFavCellViewModel: BabiesFavCellViewModelProtocol {
    func foodAtIndex(index: Int) -> Food? {
        if let food = babyFavs?[index] {
            return food
        }
        return nil
    }
    
    func minimumLineSpacingForSectionAt() -> CGFloat {
        5
    }
    
    func numberOfItemsInSection() -> Int {
        babyFavs?.count ?? 0
    }
    
    func viewDidLoad() {
        delegate?.prepareCollectionView()
        readBabyFavs()
    }
}
