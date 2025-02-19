//
//  FoodSliderCellViewModel.swift
//  Beybi
//
//  Created by Banu on 14.09.2024.
//

import Foundation
import Food

protocol FoodSliderCellViewModelProtocol {
    func viewDidLoad()
    func numberOfItemsInSection() -> Int
    func minimumInteritemSpacingForSectionAt() -> CGFloat
    func foodAtIndex(index: Int) -> Food?
    func load()
    func didSelectItemAt(index: Int) -> Food?
    func sendSelectedCell()
}

protocol FoodSliderCellViewModelDelegate: AnyObject {
    func prepareCollectionView()
    func reloadData()
    func configureCell(type: String)
}

final class FoodSliderCellViewModel {
    private weak var delegate: FoodSliderCellViewModelDelegate?
    private var recommendedRecipes: [Food]? = []
    private var traditionalRecipes: [Food]? = []
    private var type: String?
    private let networkManager: NetworkManagerInterface
    var selectedCell: Food?
    
    init(delegate: FoodSliderCellViewModelDelegate?, type: String?, networkManager: NetworkManagerInterface = NetworkManager.shared) {
        self.delegate = delegate
        self.networkManager = networkManager
        self.type = type
    }

    func readRecommendedRecipes() {
        networkManager.getRecommendedRecipes { responseData in
            switch responseData {
            case .success(let foods):
                self.recommendedRecipes = foods
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
                self.traditionalRecipes = foods
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

extension FoodSliderCellViewModel: FoodSliderCellViewModelProtocol {
    func sendSelectedCell() {
        let selectedCell: [String: Food?] = ["selectedCell": selectedCell]
        NotificationCenter.default.post(name: .foodSliderCellTapped, object: nil, userInfo: selectedCell as [AnyHashable : Any])
    }

    func didSelectItemAt(index: Int) -> Food? {
        if type == "Recommended Recipes" {
            selectedCell = recommendedRecipes?[index]
        } else {
            selectedCell = traditionalRecipes?[index]
        }
        return selectedCell
    }

    func load() {
       if let type = type {
            delegate?.configureCell(type: type)
        }
    }
    
    func foodAtIndex(index: Int) -> Food? {
        if type == "Recommended Recipes" {
            if let food = recommendedRecipes?[index] {
                return food
            }
        } else {
            if let food = traditionalRecipes?[index] {
                return food
            }
        }
        
        return nil
    }
    
    func minimumInteritemSpacingForSectionAt() -> CGFloat {
        16
    }
    
    func numberOfItemsInSection() -> Int {
        if type == "Recommended Recipes" {
            return recommendedRecipes?.count ?? 0
        } else {
            return traditionalRecipes?.count ?? 0
        }
    }
    
    func viewDidLoad() {
        readRecommendedRecipes()
        readTraditionalRecipes()
        delegate?.prepareCollectionView()
    }
}
