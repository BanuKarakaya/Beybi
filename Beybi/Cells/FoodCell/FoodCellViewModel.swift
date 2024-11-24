//
//  FoodCellViewModel.swift
//  Beybi
//
//  Created by Banu on 19.09.2024.
//

import Foundation

protocol FoodCellViewModelProtocol {
    var delegate: FoodCellViewModelDelegate? { get set }
    
    func viewDidLoad()
    func load()
}

protocol FoodCellViewModelDelegate: AnyObject {
    func setUI()
    func configureCell(food: Food?)
    func prepareBannerImage(with urlString: String?)
}

final class FoodCellViewModel {
    weak var delegate: FoodCellViewModelDelegate?
    var food: Food?
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
