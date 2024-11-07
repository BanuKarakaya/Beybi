//
//  EnjoyYourMealCellViewModel.swift
//  Beybi
//
//  Created by Banu on 7.11.2024.
//

import Foundation
import FirebaseFirestore
import FirebaseStorage

protocol EnjoyYourMealCellViewModelProtocol {
    var delegate: EnjoyYourMealCellViewModelDelegate? { get set }
    
    func imageAtIndex(index: Int) -> Eym?
    func numberOfItems() -> Int
    func viewDidLoad()
}

protocol EnjoyYourMealCellViewModelDelegate: AnyObject {
    func reloadData()
    func setUI()
}

class EnjoyYourMealCellViewModel {
    weak var delegate: EnjoyYourMealCellViewModelDelegate?
    let firestore = Firestore.firestore()
    var images: [Eym]? = []
    
    init(delegate: EnjoyYourMealCellViewModelDelegate) {
        self.delegate = delegate
    }
    
    func readImages() {
        firestore.collection("Enjoy Your Meal").getDocuments { (querySnapshot, error) in
            if let error = error {
                print("Hata: \(error.localizedDescription)")
            } else {
                for document in querySnapshot!.documents {
                    let data = document.data()
                    let imageUrl = data["imageUrl"] as? String ?? "Foto yok"
        
                    let image = Eym(imageUrl: imageUrl)
                    print(image)
                    self.images?.append(image)
                }
                self.delegate?.reloadData()
            }
        }
    }
}

extension EnjoyYourMealCellViewModel: EnjoyYourMealCellViewModelProtocol {
    func viewDidLoad() {
        readImages()
        delegate?.setUI()
    }
    
    func numberOfItems() -> Int {
        return images?.count ?? 0
    }
    
    func imageAtIndex(index: Int) -> Eym? {
        if let image = images?[index] {
            return image
        }
        return nil
    }
}
