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
}

protocol FoodCellViewModelDelegate: AnyObject {
    func setUI()
}

class FoodCellViewModel {
    weak var delegate: FoodCellViewModelDelegate?
    
    init(delegate: FoodCellViewModelDelegate) {
        self.delegate = delegate
    }
}

extension FoodCellViewModel: FoodCellViewModelProtocol {
    func viewDidLoad() {
        delegate?.setUI()
    }
}
