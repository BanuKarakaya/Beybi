//
//  MockEditViewController.swift
//  BeybiTests
//
//  Created by Banu on 15.01.2025.
//

@testable import Beybi

final class MockEditViewController: EditViewModelDelegate {
   
    var invokedPrepareUI = false
    func prepareUI() {
        invokedPrepareUI = true
    }
    
    var invokedaddPhotoButtonTapped = false
    var invokedaddPhotoButtonTappedParameters: Beybi.Button!
    func addPhotoButtonTapped(sender: Beybi.Button) {
        invokedaddPhotoButtonTapped = true
        invokedaddPhotoButtonTappedParameters = sender
    }
    
    var invokedopenCamera = false
    func openCamera() {
        invokedopenCamera = true
    }
    
    var invokedopenPhotoLibrary = false
    func openPhotoLibrary() {
        invokedopenPhotoLibrary = true
    }
}
