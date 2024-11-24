//
//  BabiesAgeCellViewModel.swift
//  Beybi
//
//  Created by Banu on 19.09.2024.
//

import Foundation
import FirebaseFirestore
import FirebaseStorage

protocol BabiesAgeCellViewModelProtocol {
    var delegate: BabiesAgeCellViewModelDelegate? { get set }
    
    func infoAtIndex(index: Int) -> Info?
    func numberOfItems() -> Int
    func awakeFromNib()
}

protocol BabiesAgeCellViewModelDelegate: AnyObject {
    func reloadData()
}

final class BabiesAgeCellViewModel {
    weak var delegate: BabiesAgeCellViewModelDelegate?
    let firestore = Firestore.firestore()
    var images: [Info]? = []
    
    func readInfo() {
        firestore.collection("info").getDocuments { (querySnapshot, error) in
            if let error = error {
                print("Hata: \(error.localizedDescription)")
            } else if let querySnapshot = querySnapshot {
                for document in querySnapshot.documents {
                    let data = document.data()
                    let imageUrl = data["imageUrl"] as? String ?? "No foto"
                    let infoText = data["infoText"] as? String ?? "No infoText"
        
                    let image = Info(imageUrl: imageUrl, infoText: infoText)
                    print(image)
                    self.images?.append(image)
                }
                self.delegate?.reloadData()
            }
        }
    }
}

extension BabiesAgeCellViewModel: BabiesAgeCellViewModelProtocol {
    func awakeFromNib() {
        readInfo()
    }
    
    func numberOfItems() -> Int {
        return images?.count ?? 0
    }
    
    func infoAtIndex(index: Int) -> Info? {
        if let image = images?[index] {
            return image
        }
        return nil
    }
}
