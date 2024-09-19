//
//  ViewMoreViewModel.swift
//  Beybi
//
//  Created by Banu on 19.09.2024.
//

import Foundation

protocol ViewMoreViewModelProtocol {
    var delegate: ViewMoreViewModelDelegate? { get set }
    
    func viewDidLoad()
    func numberOfItemsInSection() -> Int
}

protocol ViewMoreViewModelDelegate: AnyObject {
    func prepareCollectionView()
}

class ViewMoreViewModel {
    weak var delegate: ViewMoreViewModelDelegate?
    
    init(delegate: ViewMoreViewModelDelegate) {
        self.delegate = delegate
    }
}

extension ViewMoreViewModel: ViewMoreViewModelProtocol {
    func numberOfItemsInSection() -> Int {
        15
    }
    
    func viewDidLoad() {
        delegate?.prepareCollectionView()
    }
}
