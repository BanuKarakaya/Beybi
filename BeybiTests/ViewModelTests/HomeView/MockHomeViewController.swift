//
//  MockHomeViewController.swift
//  BeybiTests
//
//  Created by Banu on 15.01.2025.
//

@testable import Beybi

final class MockHomeViewController: HomeViewModelDelegate {
    
    var invokedPrepareCollectionView = false
    func prepareCollectionView() {
        invokedPrepareCollectionView = true
    }
    
    var invokedPrepareUI = false
    func prepareUI() {
        invokedPrepareUI = true
    }
}
