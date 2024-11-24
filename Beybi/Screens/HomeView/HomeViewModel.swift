//
//  HomeViewModel.swift
//  Beybi
//
//  Created by Banu on 14.09.2024.
//

import Foundation

protocol HomeViewModelProtocol {
    var delegate: HomeViewModelDelegate? { get set }
    
    func viewDidLoad()
    func numberOfSections() -> Int
    func numberOfItemsInSection() -> Int 
}

protocol HomeViewModelDelegate: AnyObject {
    func prepareCollectionView()
    func prepareUI()
}

final class HomeViewModel {
    weak var delegate: HomeViewModelDelegate?
    
    init(delegate: HomeViewModelDelegate) {
        self.delegate = delegate
    }
}

extension HomeViewModel: HomeViewModelProtocol {
    
    func numberOfItemsInSection() -> Int {
        return 1
    }
    
    func numberOfSections() -> Int {
        return 4
    }
    
    func viewDidLoad() {
        delegate?.prepareCollectionView()
        delegate?.prepareUI()
    }
}
