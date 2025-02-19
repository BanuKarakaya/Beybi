//
//  ViewMoreViewModel.swift
//  Beybi
//
//  Created by Banu on 19.09.2024.
//


import Foundation
import FirebaseFirestore
import FirebaseStorage
import Food

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
    private let networkManager: NetworkManagerInterface
    
    init(delegate: ViewMoreViewModelDelegate, networkManager: NetworkManagerInterface = NetworkManager.shared) {
        self.delegate = delegate
        self.networkManager = networkManager
    }
    
    func readRecommendedRecipes() {
        networkManager.getRecommendedRecipes { responseData in
            switch responseData {
            case .success(let foods):
                self.foodArray = foods
                DispatchQueue.main.async {
                    self.delegate?.reloadData()
                }
                print(foods)
                break
            case .failure(let error):
                print(error)
                break
            }
        }
    }
    
    func readTraditionalRecipes() {
        networkManager.getTraditionalRecipes { responseData in
            switch responseData {
            case .success(let foods):
                self.foodArray = foods
                DispatchQueue.main.async {
                    self.delegate?.reloadData()
                }
                print(foods)
                break
            case .failure(let error):
                print(error)
                break
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
        
        if foodType == "Recommended Recipes" {
            readRecommendedRecipes()
        } else {
            readTraditionalRecipes()
        }
    }
}
 
