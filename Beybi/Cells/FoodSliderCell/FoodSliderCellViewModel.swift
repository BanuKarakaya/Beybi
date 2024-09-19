//
//  FoodSliderCellViewModel.swift
//  Beybi
//
//  Created by Banu on 14.09.2024.
//

import Foundation

protocol FoodSliderCellViewModelProtocol {
    var delegate: FoodSliderCellViewModelDelegate? { get set }
    
    func viewDidLoad()
    func numberOfItemsInSection() -> Int
    func minimumInteritemSpacingForSectionAt() -> CGFloat
    func minimumLineSpacingForSectionAt() -> CGFloat
}

protocol FoodSliderCellViewModelDelegate: AnyObject {
    func prepareUI()
    func prepareCollectionView()
}

class FoodSliderCellViewModel {
    weak var delegate: FoodSliderCellViewModelDelegate?
    
    init(delegate: FoodSliderCellViewModelDelegate) {
        self.delegate = delegate
    }
}

extension FoodSliderCellViewModel: FoodSliderCellViewModelProtocol {
    func minimumLineSpacingForSectionAt() -> CGFloat {
        10
    }
    
    func minimumInteritemSpacingForSectionAt() -> CGFloat {
        3
    }
    
    func numberOfItemsInSection() -> Int {
        9
    }
    
    func viewDidLoad() {
        delegate?.prepareUI()
        delegate?.prepareCollectionView()
    }
}
