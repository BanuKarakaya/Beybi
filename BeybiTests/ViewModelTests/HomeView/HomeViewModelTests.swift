//
//  HomeViewModelTests.swift
//  BeybiTests
//
//  Created by Banu on 15.01.2025.
//

import XCTest
@testable import Beybi

final class HomeViewModelTests: XCTestCase {
    private var viewModel: HomeViewModel!
    private var view: MockHomeViewController!
    
    override func setUp() {
        super.setUp()
        view = .init()
        viewModel = .init(delegate: view)
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func test_numberOfItemsInSection_returnItemsCount() {
        XCTAssertEqual(viewModel.numberOfItemsInSection(), 1)
    }
    
    func test_numberOfSections_returnSectionsCount() {
        XCTAssertEqual(viewModel.numberOfSections(), 4)
    }
    
    func test_viewDidLoad_InvokesRequiredMethod() {
        XCTAssertFalse(view.invokedPrepareCollectionView)
        XCTAssertFalse(view.invokedPrepareUI)
        
        viewModel.viewDidLoad()
        
        XCTAssertTrue(view.invokedPrepareCollectionView)
        XCTAssertTrue(view.invokedPrepareUI)
    }
}
