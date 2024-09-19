//
//  BabiesFavCellViewModel.swift
//  Beybi
//
//  Created by Banu on 19.09.2024.
//

import Foundation

protocol BabiesFavCellViewModelProtocol {
    var delegate: BabiesFavCellViewModelDelegate? { get set }
    
    func viewDidLoad()
    func numberOfItemsInSection() -> Int
    func minimumLineSpacingForSectionAt() -> CGFloat
}

protocol BabiesFavCellViewModelDelegate: AnyObject {
    func prepareCollectionView()
}

class BabiesFavCellViewModel {
    weak var delegate: BabiesFavCellViewModelDelegate?
    
    init(delegate: BabiesFavCellViewModelDelegate) {
        self.delegate = delegate
    }
}

extension BabiesFavCellViewModel: BabiesFavCellViewModelProtocol {
    func minimumLineSpacingForSectionAt() -> CGFloat {
        5
    }
    
    func numberOfItemsInSection() -> Int {
        8
    }
    
    func viewDidLoad() {
        delegate?.prepareCollectionView()
    }
}
