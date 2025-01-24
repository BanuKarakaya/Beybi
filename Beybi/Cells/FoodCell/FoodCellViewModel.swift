//
//  FoodCellViewModel.swift
//  Beybi
//
//  Created by Banu on 19.09.2024.
//

import Foundation
import Food

protocol FoodCellViewModelProtocol {
    func viewDidLoad()
    func load()
}

protocol FoodCellViewModelDelegate: AnyObject {
    func setUI()
    func configureCell(food: Food?)
    func prepareBannerImage(with urlString: String?)
}

final class FoodCellViewModel {
    private weak var delegate: FoodCellViewModelDelegate?
    private var food: Food?
    
    init(delegate: FoodCellViewModelDelegate?, food: Food?) {
        self.delegate = delegate
        self.food = food
    }
}

extension FoodCellViewModel: FoodCellViewModelProtocol {
    func load() {
        if let food = food {
            delegate?.configureCell(food: food)
        }
    }
    
    func viewDidLoad() {
        delegate?.setUI()
    }
}
