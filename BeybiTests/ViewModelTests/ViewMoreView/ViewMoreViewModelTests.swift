//
//  ViewMoreViewModelTests.swift
//  BeybiTests
//
//  Created by Banu on 15.01.2025.
//

@testable import Beybi
import XCTest

final class ViewMoreViewModelTests: XCTestCase {
    private var viewModel: ViewMoreViewModel!
    private var view: MockViewMoreViewController!
    
    override func setUp() {
        super.setUp()
        view = .init()
        viewModel = .init(delegate: view)
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func test_setTitle_withParameters() {
        XCTAssertNil(view.foodTypeValue)
        XCTAssertFalse(view.invokedPrepareUI)
        
        let foodType: String? = .init()
        viewModel.setTitle(foodType: foodType)
        
        XCTAssertTrue(view.invokedPrepareUI)
        XCTAssertEqual(view.foodTypeValue, foodType)
    }
}
