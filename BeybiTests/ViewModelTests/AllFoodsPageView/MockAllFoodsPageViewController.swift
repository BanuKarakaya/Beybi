//
//  MockAllFoodsPageViewController.swift
//  BeybiTests
//
//  Created by Banu on 15.01.2025.
//

@testable import Beybi

final class MockAllFoodsPageViewController: AllFoodsPageViewModelDelegate {
   
    var invokedSetUI = false
    func setUI() {
        invokedSetUI = true
    }
    
    var invokedPrepareCollectionView = false
    func prepareCollectionView() {
        invokedPrepareCollectionView = true
    }
}
