//
//  OnboardingViewModelTests.swift
//  BeybiTests
//
//  Created by Banu on 15.01.2025.
//

@testable import Beybi
import XCTest

final class OnboardingViewModelTests: XCTestCase {
    private var viewModel: OnboardingViewModel!
    private var view: MockOnboardingViewController!
    
    override func setUp() {
        super.setUp()
        view = .init()
        viewModel = .init(delegate: view)
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func test_viewDidLoad_InvokesRequiredMethod() {
        XCTAssertFalse(view.invokedPrepareUI)
        viewModel.viewDidLoad()
        XCTAssertTrue(view.invokedPrepareUI)
    }
    
    func test_navigateToHomeVC_InvokesRequiredMethod() {
        XCTAssertFalse(view.invokedNavigateToHomeVC)
        viewModel.viewDidLoad()
        XCTAssertTrue(view.invokedNavigateToHomeVC)
    }
}

