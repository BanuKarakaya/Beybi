//
//  MockDiaryDetailViewController.swift
//  BeybiTests
//
//  Created by Banu on 15.01.2025.
//

import Foundation
@testable import Beybi

final class MockDiaryDetailViewController: DiaryDetailViewModelDelegate {
    
    var invokedPrepareUI = false
    func prepareUI() {
        invokedPrepareUI = true
    }
    
    var invokedConfigure = false
    var invokedConfigureParametres: Beybi.DemoEntity!
    func configure(selectedDiary: Beybi.DemoEntity?) {
        invokedConfigure = true
        invokedConfigureParametres = selectedDiary
    }
    
    var invokedNSToUIImage = false
    var invokedNSToUIImageParametres: Data!
    func NSToUIImage(image: Data) -> Beybi.Image {
        invokedNSToUIImage = true
        invokedNSToUIImageParametres = image
        let beybiImage: Beybi.Image
        beybiImage = .init()
        return beybiImage
    }
}

