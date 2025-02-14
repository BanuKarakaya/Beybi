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
    //func load()
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
    private var type: String?
    private let networkManager: NetworkManagerInterface
    var selectedCell: Food?
    
    init(delegate: FoodSliderCellViewModelDelegate?, networkManager: NetworkManagerInterface = NetworkManager.shared) {
        self.delegate = delegate
        self.networkManager = networkManager
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
}

extension FoodSliderCellViewModel: FoodSliderCellViewModelProtocol {
    func sendSelectedCell() {
        let selectedCell: [String: Food?] = ["selectedCell": selectedCell]
        NotificationCenter.default.post(name: .foodSliderCellTapped, object: nil, userInfo: selectedCell as [AnyHashable : Any])
    }

    func didSelectItemAt(index: Int) -> Food? {
        selectedCell = recommendedRecipes?[index]
        return selectedCell
    }
//
//    //func load() {
//    //    if let type = type {
//     //       delegate?.configureCell(type: type)
//    //    }
//    //}
//    
    func foodAtIndex(index: Int) -> Food? {
        if let food = recommendedRecipes?[index] {
                return food
        }
        return nil
    }
    
    func minimumInteritemSpacingForSectionAt() -> CGFloat {
        16
    }
    
    func numberOfItemsInSection() -> Int {
        return recommendedRecipes?.count ?? 0
    }
    
    func viewDidLoad() {
        readRecommendedRecipes()
        delegate?.prepareCollectionView()
    }
}
