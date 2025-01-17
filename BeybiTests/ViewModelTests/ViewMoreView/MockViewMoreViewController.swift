//
//  MockViewMoreViewController.swift
//  BeybiTests
//
//  Created by Banu on 15.01.2025.
//

@testable import Beybi

final class MockViewMoreViewController: ViewMoreViewModelDelegate {
   
    var invokedPrepareCollectionView = false
    func prepareCollectionView() {
        invokedPrepareCollectionView = true
    }
    
    var invokedPrepareUI = false
    var foodTypeValue: String?
    func prepareUI(foodType: String?) {
        invokedPrepareUI = true
        foodTypeValue = foodType
    }
    
    var invokednavigateToDetailVC = false
    func navigateToDetailVC(selectedCell: Beybi.Food?) {
        invokednavigateToDetailVC = true
    }
    
    var invokedReloadData = false
    func reloadData() {
        invokedReloadData = true
    }
}
