//
//  AllFoodsPageViewModelTests.swift
//  BeybiTests
//
//  Created by Banu on 15.01.2025.
//

@testable import Beybi
import XCTest

final class AllFoodsPageViewModelTests: XCTestCase {
    private var viewModel: AllFoodsPageViewModel!
    private var view: MockAllFoodsPageViewController!
    
    override func setUp() {
        super.setUp()
        view = .init()
        viewModel = .init(delegate: view)
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func test_viewDidLoad_InvokesRequiredMethod() {
        XCTAssertFalse(view.invokedPrepareCollectionView)
        XCTAssertFalse(view.invokedSetUI)
        viewModel.viewDidLoad()
        XCTAssertTrue(view.invokedPrepareCollectionView)
        XCTAssertTrue(view.invokedSetUI)
    }
    
    func tests_numberOfItemsInSection_ReturnItemsCount() {
        XCTAssertEqual(viewModel.numberOfItemsInSection(), 5)
    }
    
    func tests_typeAtIndex_returnType() {
        
    }
}
