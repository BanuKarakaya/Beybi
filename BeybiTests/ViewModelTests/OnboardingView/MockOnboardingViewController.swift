//
//  MockOnboardingViewController.swift
//  BeybiTests
//
//  Created by Banu on 15.01.2025.
//

@testable import Beybi

final class MockOnboardingViewController: OnboardingViewModelDelegate {
    
    var invokedPrepareUI = false
    func prepareUI() {
        invokedPrepareUI = true
    }
    
    var invokedNavigateToHomeVC = false
    func navigateToHomeVC() {
        invokedNavigateToHomeVC = true
    }
}
