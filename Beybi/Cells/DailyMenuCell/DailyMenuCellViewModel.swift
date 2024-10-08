//
//  DailyMenuCellViewModel.swift
//  Beybi
//
//  Created by Banu on 19.09.2024.
//

import Foundation

protocol DailyMenuCellViewModelProtocol {
    var delegate: DailyMenuCellViewModelDelegate? { get set }
    
    func viewDidLoad()
    func numberOfItemsInSection() -> Int
}

protocol DailyMenuCellViewModelDelegate: AnyObject {
    func prepareCollectionView()
    func prepareUI()
}

class DailyMenuCellViewModel {
    weak var delegate: DailyMenuCellViewModelDelegate?
    
    init(delegate: DailyMenuCellViewModelDelegate) {
        self.delegate = delegate
    }
}

extension DailyMenuCellViewModel: DailyMenuCellViewModelProtocol {
    func numberOfItemsInSection() -> Int {
        5
    }
    
    func viewDidLoad() {
        delegate?.prepareCollectionView()
        delegate?.prepareUI()
    }
}
