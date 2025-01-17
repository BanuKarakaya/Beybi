//
//  EditViewModelTests.swift
//  BeybiTests
//
//  Created by Banu on 15.01.2025.
//

import XCTest
@testable import Beybi

final class EditViewModelTests: XCTestCase {
    private var viewModel: EditViewModel!
    private var view: MockEditViewController!
    
    override func setUp() {
        super.setUp()
        view = .init()
        viewModel = .init(delegate: view)
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func test_openPhotoLibraryy_InvokesRequiredMethod() {
        XCTAssertFalse(view.invokedopenPhotoLibrary)
        viewModel.openPhotoLibraryy()
        XCTAssertTrue(view.invokedopenPhotoLibrary)
    }
    
    func test_openCameraa_InvokesRequiredMethod() {
        XCTAssertFalse(view.invokedopenCamera)
        viewModel.openCameraa()
        XCTAssertTrue(view.invokedopenCamera)
    }
    
    func test_addPhotoButtonTappedd_InvokesRequiredMethod() {
        XCTAssertFalse(view.invokedaddPhotoButtonTapped)
        XCTAssertNil(view.invokedaddPhotoButtonTappedParameters)
        let button: Beybi.Button = .init()
        viewModel.addPhotoButtonTappedd(sender: button)
        XCTAssertTrue(view.invokedaddPhotoButtonTapped)
        XCTAssertEqual(view.invokedaddPhotoButtonTappedParameters, button)
    }
    
    func test_viewDidLoad_InvokesRequiredMethod() {
        XCTAssertFalse(view.invokedPrepareUI)
        viewModel.viewDidLoad()
        XCTAssertTrue(view.invokedPrepareUI)
    }
}
