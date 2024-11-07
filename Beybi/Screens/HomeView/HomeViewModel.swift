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
    func sizeForItemAt(section: Int) -> CGSize
}

protocol HomeViewModelDelegate: AnyObject {
    func prepareCollectionView()
    func prepareUI()
}

class HomeViewModel {
    weak var delegate: HomeViewModelDelegate?
    
    init(delegate: HomeViewModelDelegate) {
        self.delegate = delegate
    }
}

extension HomeViewModel: HomeViewModelProtocol {
    func sizeForItemAt(section: Int) -> CGSize {
        switch section {
              case 0:
                  return CGSize(width: 380, height: 140)
              case 1:
                  return CGSize(width: 380, height: 240)
              case 2:
                  return CGSize(width: 380, height: 50)
              case 3:
                  return CGSize(width: 380, height: 240)
              default:
                  return CGSize(width: 100, height: 100)
              }
    }
    
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
