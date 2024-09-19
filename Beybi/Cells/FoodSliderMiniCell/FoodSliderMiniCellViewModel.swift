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
}

protocol FoodSliderMiniCellViewModelDelegate: AnyObject {
    func setUI()
}

class FoodSliderMiniCellViewModel {
    weak var delegate: FoodSliderMiniCellViewModelDelegate?
    
    init(delegate: FoodSliderMiniCellViewModelDelegate) {
        self.delegate = delegate
    }
}

extension FoodSliderMiniCellViewModel: FoodSliderMiniCellViewModelProtocol {
    func viewDidLoad() {
        delegate?.setUI()
    }
}
