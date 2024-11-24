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
    
    func awakeFromNib()
    func numberOfItemsInSection() -> Int
    func minimumLineSpacingForSectionAt() -> CGFloat
    func foodAtIndex(index: Int) -> Food?
    func didSelectItemAt(index: Int)
}

protocol BabiesFavCellViewModelDelegate: AnyObject {
    func prepareCollectionView()
    func reloadData()
}

final class BabiesFavCellViewModel {
    weak var delegate: BabiesFavCellViewModelDelegate?
    let firestore = Firestore.firestore()
    var babyFavs: [Food]? = []
    var selectedCell: Food?
    
    init(delegate: BabiesFavCellViewModelDelegate) {
        self.delegate = delegate
    }
    
    func readBabyFavs() {
        firestore.collection("babies fav").getDocuments { (querySnapshot, error) in
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
                    let introText = data["introText"] as? String ?? "No intrpText"
                    let ingredients = data["ingredients"] as? [String] ?? ["No ingredients"]
                    let recipeStep = data["recipeStep"] as? [String] ?? ["No recipe"]
                    
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
    
    func didSelectItemAt(index: Int) {
        selectedCell = babyFavs?[index]
        
        let selectedCell: [String: Food?] = ["selectedCell": selectedCell]
        NotificationCenter.default.post(name: .favSliderCellTapped, object: nil, userInfo: selectedCell)
    }
    
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
    
    func awakeFromNib() {
        delegate?.prepareCollectionView()
        readBabyFavs()
    }
}
