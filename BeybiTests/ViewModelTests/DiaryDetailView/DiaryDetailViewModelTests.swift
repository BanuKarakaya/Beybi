//
//  DiaryDetailViewModelTests.swift
//  BeybiTests
//
//  Created by Banu on 15.01.2025.
//

import XCTest
@testable import Beybi

final class DiaryDetailViewModelTests: XCTestCase {
    private var viewModel: DiaryDetailViewModel!
    private var view: MockDiaryDetailViewController!
    
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
        XCTAssertFalse(view.invokedConfigure)
        XCTAssertNil(view.invokedConfigureParametres)
        
        let selectedDiary: DemoEntity? = .init()
        viewModel.viewDidLoad()
        
        XCTAssertTrue(view.invokedPrepareUI)
        XCTAssertTrue(view.invokedConfigure)
        XCTAssertEqual(view.invokedConfigureParametres, selectedDiary)
    }
}


