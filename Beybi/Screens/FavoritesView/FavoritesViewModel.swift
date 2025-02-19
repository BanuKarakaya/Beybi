//
//  FavoritesViewModel.swift
//  Beybi
//
//  Created by Banu on 12.02.2025.
//

import Foundation
import Food

protocol FavoritesViewModelProtocol {
    func viewDidLoad()
    func viewWillApear()
    func foodAtIndex(index: Int) -> Food?
    func numberOfItems() -> Int
    func searchBarSearchButtonClicked(searchText: String?)
    func searchBarCancelButtonClicked()
    func didSelectItemAt(index: Int)
}

protocol FavoritesViewModelDelegate: AnyObject {
    func prepareCollectionView()
    func prepareUI()
    func prepareSearchController()
    func reloadData()
    func navigateToDetail(selectedCell: Food)
}

final class FavoritesViewModel {
    private weak var delegate: FavoritesViewModelDelegate?
    private var favFoods: [Food?] = []
    private var favFoodsName: [String?] = []
    private var searchFoods: [Food?] = []
    var isSearching = false
    private let networkManager: NetworkManagerInterface
    
    init(delegate: FavoritesViewModelDelegate?, networkManager: NetworkManagerInterface = NetworkManager.shared) {
        self.delegate = delegate
        self.networkManager = networkManager
    }
    
    func readFavs() {
        networkManager.getFavs { responseData in
            switch responseData {
            case .success(let foods):
                self.favFoods = foods
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

extension FavoritesViewModel: FavoritesViewModelProtocol {
    func didSelectItemAt(index: Int) {
        var selectedCell: Food?
        
        if isSearching {
            selectedCell = searchFoods[index]
        } else {
            selectedCell = favFoods[index]
        }
        delegate?.navigateToDetail(selectedCell: selectedCell!)
    }
    
    func searchBarCancelButtonClicked() {
        isSearching = false
        delegate?.reloadData()
    }
    
    func searchBarSearchButtonClicked(searchText: String?) {
        if let searchText = searchText {
            isSearching = true
            for i in 0 ..< favFoods.count {
                favFoodsName.append(favFoods[i]?.name)
            }
            let filtered = favFoodsName.filter { $0!.contains(searchText) }
            searchFoods = favFoods.filter { filtered.contains($0?.name)}
            delegate?.reloadData()
        }
    }
    
    func viewWillApear() {
        if isSearching == false {
            readFavs()
        }
    }
    
    func numberOfItems() -> Int {
        return (isSearching ? searchFoods.count : favFoods.count)
    }
    
    func foodAtIndex(index: Int) -> Food? {
        if isSearching {
            if let food = searchFoods[index] {
                return food
            }
        } else {
            if let food = favFoods[index] {
                return food
            }
        }
        return nil

    }
    
    func viewDidLoad() {
        delegate?.prepareCollectionView()
        delegate?.prepareUI()
        delegate?.prepareSearchController()
        readFavs()
    }
}
