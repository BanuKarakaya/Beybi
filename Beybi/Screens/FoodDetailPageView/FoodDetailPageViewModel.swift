//
//  FoodDetailPageViewModel.swift
//  Beybi
//
//  Created by Banu on 11.10.2024.
//

import Foundation

protocol FoodDetailPageViewModelProtocol {
    var delegate: FoodDetailPageViewModelDelegate? { get set }
}

protocol FoodDetailPageViewModelDelegate: AnyObject {
    
}

class FoodDetailPageViewModel {
    weak var delegate: FoodDetailPageViewModelDelegate?
    
    init(delegate: FoodDetailPageViewModelDelegate) {
        self.delegate = delegate
    }
}

extension FoodDetailPageViewModel: FoodDetailPageViewModelProtocol {
    
}
