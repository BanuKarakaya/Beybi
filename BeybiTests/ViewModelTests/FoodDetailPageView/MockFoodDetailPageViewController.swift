//
//  MockFoodDetailPageViewController.swift
//  BeybiTests
//
//  Created by Banu on 15.01.2025.
//

@testable import Beybi

final class MockFoodDetailPageViewController: FoodDetailPageViewModelDelegate {
    
    var invokedConfigure = false
    var invokedConfigureParameters: Beybi.Food!
    func configure(selectedFood: Beybi.Food?) {
        invokedConfigure = true
        invokedConfigureParameters = selectedFood
    }
    
    var invokedPrepareBannerImage = false
    func prepareBannerImage(with urlString: String?) {
        invokedPrepareBannerImage = true
    }
    
    var invokedPrepareUI = false
    func prepareUI() {
        invokedPrepareUI = true
    }
    
    var invokedPrepareCollectionView = false
    func prepareCollectionView() {
        invokedPrepareCollectionView = true
    }
}
