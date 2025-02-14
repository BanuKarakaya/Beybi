//
//  AllFoodsPageViewModel.swift
//  Beybi
//
//  Created by Banu on 14.09.2024.
//

 
import Foundation
import Food
import FirebaseFirestore
import FirebaseStorage

protocol AllFoodsPageViewModelProtocol {
    func viewDidLoad()
    func numberOfItemsInSection() -> Int
    func foodAtIndex(index: Int) -> Food?
    func didSelectItemAt(index: Int)
    func typeAtIndex(index: Int) -> String?
    func didSelectItemAtCategories(index: Int)
}

protocol AllFoodsPageViewModelDelegate: AnyObject {
    func setUI()
    func prepareCollectionView()
    func prepareSearchController()
    func reloadData()
    func navigateToDetail(selectedCell: Food)
}

final class AllFoodsPageViewModel {
    private weak var delegate: AllFoodsPageViewModelDelegate?
    private var types = ["Breakfast","Soups","Main Dishes","Purees","Snacks"]
    private let firestore = Firestore.firestore()
    private var foodArray: [Food]? = []
    private let networkManager: NetworkManagerInterface
    
    init(delegate: AllFoodsPageViewModelDelegate, networkManager: NetworkManagerInterface = NetworkManager.shared) {
        self.delegate = delegate
        self.networkManager = networkManager
    }
    
    func readSoups() {
        networkManager.getSoups { responseData in
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
    
    func readBreakfasts() {
        networkManager.getBreakfasts { responseData in
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
    
    func readMainDishes() {
        networkManager.getMainDishes { responseData in
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
    
    func readSnacks() {
        networkManager.getSnacks { responseData in
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
    
    func readPurees() {
        networkManager.getPurees { responseData in
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

extension AllFoodsPageViewModel: AllFoodsPageViewModelProtocol {
    func didSelectItemAtCategories(index: Int) {
        var selectedType: String
        
        selectedType = types[index]
        
        if selectedType == "Breakfast" {
            readBreakfasts()
        } else if selectedType == "Soups" {
            readSoups()
        } else if selectedType == "Main Dishes" {
            readMainDishes()
        } else if selectedType == "Purees" {
            readPurees()
        } else {
            readSnacks()
        }
    }
    
    func typeAtIndex(index: Int) -> String? {
        let type = types[index]
        return type
    }
    
    func didSelectItemAt(index: Int) {
        var selectedCell: Food?
        
        selectedCell = foodArray?[index]
        delegate?.navigateToDetail(selectedCell: selectedCell!)
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
        delegate?.setUI()
        delegate?.prepareCollectionView()
        delegate?.prepareSearchController()
        readBreakfasts()
    }
}

