//
//  EmotionalDiaryViewModelTests.swift
//  BeybiTests
//
//  Created by Banu on 15.01.2025.
//

@testable import Beybi
import XCTest

final class EmotionalDiaryViewModelTests: XCTestCase {
    private var viewModel: EmotionalDiaryViewModel!
    private var view: MockEmotionalDiaryViewController!
    
    override func setUp() {
        super.setUp()
        view = .init()
        viewModel = .init(delegate: view)
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func test_EmptyImageViewIsHidden_whenDiariesIsEmpty() {
        viewModel.diaries = []
        XCTAssertNil(view.isHiddenValue)
        XCTAssertFalse(view.invokedEmptyImageView)
        
        viewModel.emptyImageViewIsHidden()
        
        XCTAssertTrue(view.invokedEmptyImageView)
        XCTAssertEqual(view.isHiddenValue, false)
    }
    
    func test_EmptyImageViewIsHidden_whenDiariesIsNotEmpty() {
        viewModel.diaries = [DemoEntity.]
        XCTAssertNil(view.isHiddenValue)
        XCTAssertFalse(view.invokedEmptyImageView)
        
        viewModel.emptyImageViewIsHidden()
        
        XCTAssertTrue(view.invokedEmptyImageView)
        XCTAssertEqual(view.isHiddenValue, true)
        
    }
    
    func test_didSelectItemAt() {
        XCTAssertNil(view.selectedCellValue)
        XCTAssertFalse(view.invokedNavigateToDetailVC)
        let selectedCell: DemoEntity? = .init()
        
        viewModel.didSelectItemAt(index: 2)
        
        XCTAssertTrue(view.invokedNavigateToDetailVC)
        XCTAssertEqual(view.selectedCellValue, selectedCell)
    }
    
    func test_addDiaryButtonTapped() {
        XCTAssertFalse(view.invokednavigateToEditVC)
        
        viewModel.addDiaryButtonTapped()
        
        XCTAssertTrue(view.invokednavigateToEditVC)
    }
}

