//
//  FoodSliderMiniCellViewModel.swift
//  Beybi
//
//  Created by Banu on 19.09.2024.
//

import Foundation
import Food

protocol FoodSliderMiniCellViewModelProtocol {
    func viewDidLoad()
    func load()
}

protocol FoodSliderMiniCellViewModelDelegate: AnyObject {
    func setUI()
    func configureCell(food: Food?)
    func prepareBannerImage(with urlString: String?)
}

final class FoodSliderMiniCellViewModel {
    private weak var delegate: FoodSliderMiniCellViewModelDelegate?
    private var food: Food?
    
    init(delegate: FoodSliderMiniCellViewModelDelegate?, food: Food?) {
        self.delegate = delegate
        self.food = food
    }
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
