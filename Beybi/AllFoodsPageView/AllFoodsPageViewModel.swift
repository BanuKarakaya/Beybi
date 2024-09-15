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
}

protocol AllFoodsPageViewModelDelegate: AnyObject {
    func setUI()
    func prepareCollectionView()
}

class AllFoodsPageViewModel {
    weak var delegate: AllFoodsPageViewModelDelegate?
}

extension AllFoodsPageViewModel: AllFoodsPageViewModelProtocol {
    func viewDidLoad() {
        delegate?.setUI()
        delegate?.prepareCollectionView()
    }
    
    
}
