//
//  AllFoodsPageViewModel.swift
//  Beybi
//
//  Created by Banu on 14.09.2024.
//

 
import Foundation
import Food
import UIKit
import FirebaseFirestore
import FirebaseStorage

protocol AllFoodsPageViewModelProtocol {
    func viewDidLoad()
    func numberOfItemsInSection() -> Int
    func foodAtIndex(index: Int) -> Food?
    func didSelectItemAt(index: Int)
    func categoryAt(index: Int) -> Categories?
    func didSelectItemAtCategories(index: Int)
    func searchBarSearchButtonClicked(searchText: String?)
    func searchBarCancelButtonClicked()
}

protocol AllFoodsPageViewModelDelegate: AnyObject {
    func setUI()
    func prepareCollectionView()
    func prepareSearchController()
    func reloadData()
    func navigateToDetail(selectedCell: Food)
}

struct Categories {
    let name: String
    var isSelected: Bool
    var image: UIimage
}

final class AllFoodsPageViewModel {
    private weak var delegate: AllFoodsPageViewModelDelegate?
    private var categories: [Categories] = []
    private let firestore = Firestore.firestore()
    private var foodArray: [Food]? = []
    private var favFoodsName: [String?] = []
    private var searchFoods: [Food?] = []
    var isSearching = false
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
    func searchBarSearchButtonClicked(searchText: String?) {
        if let searchText = searchText {
            isSearching = true
            for i in 0 ..< foodArray!.count {
                favFoodsName.append(foodArray?[i].name)
            }
            let filtered = favFoodsName.filter { $0!.contains(searchText) }
            if let foodS = foodArray {
                searchFoods = foodS.filter { filtered.contains($0.name)}
                delegate?.reloadData()
            }
            
        }
    }
    
    func searchBarCancelButtonClicked() {
        isSearching = false
        delegate?.reloadData()
    }
    
    func didSelectItemAtCategories(index: Int) {
        var selectedType: String
        
        selectedType = categories[index].name
        for i in 0 ..< categories.count {
            categories[i].isSelected = false
        }
        categories[index].isSelected = true
        
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
    
    func categoryAt(index: Int) -> Categories? {
        categories[index]
    }
    
    func didSelectItemAt(index: Int) {
        var selectedCell: Food?
        
        if isSearching {
            selectedCell = searchFoods[index]
        } else {
            selectedCell = foodArray?[index]
        }
    
        delegate?.navigateToDetail(selectedCell: selectedCell!)
    }
    
    
    func foodAtIndex(index: Int) -> Food? {
        if isSearching {
            if let food = searchFoods[index] {
                return food
            }
        } else {
            if let food = foodArray?[index] {
                return food
            }
        }
        return nil
    }
    
    func numberOfItemsInSection() -> Int {
        return (isSearching ? searchFoods.count : foodArray?.count ?? 0)
    }
    
    func viewDidLoad() {
        categories = [
            Categories.init(name: "Breakfast", isSelected: true, image: UIImage(named: "2")!),
            Categories.init(name: "Soups", isSelected: false, image: UIImage(named: "1")!),
            Categories.init(name: "Main Dishes", isSelected: false, image: UIImage(named: "3")!),
            Categories.init(name: "Purees", isSelected: false, image: UIImage(named: "5")!),
            Categories.init(name: "Snacks", isSelected: false, image: UIImage(named: "4")!)
        ]
        delegate?.setUI()
        delegate?.prepareCollectionView()
        delegate?.prepareSearchController()
        readBreakfasts()
    }
}

