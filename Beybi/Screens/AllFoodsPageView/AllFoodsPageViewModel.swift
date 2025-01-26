//
//  AllFoodsPageViewModel.swift
//  Beybi
//
//  Created by Banu on 14.09.2024.
//

import Foundation

protocol AllFoodsPageViewModelProtocol {
    func viewDidLoad()
    func numberOfItemsInSection() -> Int
    func typeAtIndex(index: Int) -> String
}

protocol AllFoodsPageViewModelDelegate: AnyObject {
    func setUI()
    func prepareCollectionView()
    func prepareSearchController()
}

final class AllFoodsPageViewModel {
    private weak var delegate: AllFoodsPageViewModelDelegate?
    private var types = ["Breakfast","Soups","Main Dishes","Purees","Snacks","Recommended Recipes"]
    
    init(delegate: AllFoodsPageViewModelDelegate) {
        self.delegate = delegate
    }
}

extension AllFoodsPageViewModel: AllFoodsPageViewModelProtocol {
    func typeAtIndex(index: Int) -> String {
        let type = types[index]
        return type
    }
    
    func numberOfItemsInSection() -> Int {
        10
    }
    
    func viewDidLoad() {
        delegate?.setUI()
        delegate?.prepareCollectionView()
        delegate?.prepareSearchController()
    }
}
