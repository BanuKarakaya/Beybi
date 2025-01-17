//
//  FoodDetailPageViewModelTests.swift
//  BeybiTests
//
//  Created by Banu on 15.01.2025.
//

@testable import Beybi
import XCTest

final class FoodDetailPageViewModelTests: XCTestCase {
    private var viewModel: FoodDetailPageViewModel!
    private var view: MockFoodDetailPageViewController!
    
    override func setUp() {
        super.setUp()
        view = .init()
        viewModel = .init(delegate: view)
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
}
