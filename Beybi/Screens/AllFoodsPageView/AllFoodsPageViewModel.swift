//
//  AllFoodsPageViewModel.swift
//  Beybi
//
//  Created by Banu on 14.09.2024.
//

import Foundation

protocol AllFoodsPageViewModelProtocol {
    var delegate: AllFoodsPageViewModelDelegate? { get set }
    
    func viewDidLoad()
    func numberOfItemsInSection() -> Int
}

protocol AllFoodsPageViewModelDelegate: AnyObject {
    func setUI()
    func prepareCollectionView()
}

class AllFoodsPageViewModel {
    weak var delegate: AllFoodsPageViewModelDelegate?
    
    init(delegate: AllFoodsPageViewModelDelegate) {
        self.delegate = delegate
    }
}

extension AllFoodsPageViewModel: AllFoodsPageViewModelProtocol {
    func numberOfItemsInSection() -> Int {
        7
    }
    
    func viewDidLoad() {
        delegate?.setUI()
        delegate?.prepareCollectionView()
    }
    
    
}
