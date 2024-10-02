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
    var type: String?
    let firestore = Firestore.firestore()
    
    func readrecipe() {
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
                    
                    print("Çorba Adı: \(name)")
                    print("Pişirme Süresi: \(cookingTime)")
                    print("Tarif: \(recipe)")
                    
                    
                    let soup = Food(name: name, cookingTime: cookingTime, recipe: recipe, imageUrl: imageUrl)
                    self.soups?.append(soup)
                   
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
        if let food = soups?[index] {
            return food
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
        readrecipe()
    }
}
