//
//  FoodSliderMiniCellViewModel.swift
//  Beybi
//
//  Created by Banu on 19.09.2024.
//

import Foundation

protocol FoodSliderMiniCellViewModelProtocol {
    var delegate: FoodSliderMiniCellViewModelDelegate? { get set }
    
    func viewDidLoad()
    func load()
}

protocol FoodSliderMiniCellViewModelDelegate: AnyObject {
    func setUI()
    func configureCell(food: Food?)
    func prepareBannerImage(with urlString: String?)
}

class FoodSliderMiniCellViewModel {
    weak var delegate: FoodSliderMiniCellViewModelDelegate?
    var food: Food?
}

extension FoodSliderMiniCellViewModel: FoodSliderMiniCellViewModelProtocol {
    func load() {
        if let food = food {
            delegate?.configureCell(food: food)
        }
    }
    
    func viewDidLoad() {
        delegate?.setUI()
    }
}
