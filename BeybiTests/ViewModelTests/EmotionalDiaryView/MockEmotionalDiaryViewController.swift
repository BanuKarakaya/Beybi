//
//  MockEmotionalDiaryViewController.swift
//  BeybiTests
//
//  Created by Banu on 15.01.2025.
//

@testable import Beybi

final class MockEmotionalDiaryViewController: EmotionalDiaryViewModelDelegate {
    var invokedPrepareUI = false
    func prepareUI() {
        invokedPrepareUI = true
    }
    
    var invokedPrepareCollectionView = false
    func prepareCollectionView() {
        invokedPrepareCollectionView = true
    }
    
    var invokedReloadData = false
    func reloadData() {
        invokedReloadData = true
    }
    
    var invokednavigateToEditVC = false
    func navigateToEditVC() {
        invokednavigateToEditVC = true
    }
    
    var invokedAppDelegate = false
    func appDelegate() -> Beybi.AppDelegate {
        invokedAppDelegate = true
    }
    
    var invokedNavigateToDetailVC = false
    var selectedCellValue: Beybi.DemoEntity?
    func navigateToDetailVC(selectedCell: Beybi.DemoEntity?) {
        invokedNavigateToDetailVC = true
        selectedCellValue = selectedCell
    }
    
    var invokedEmptyImageView = false
    var isHiddenValue: Bool?
    func emptyImageView(hidden: Bool) {
        invokedEmptyImageView = true
        isHiddenValue = hidden
    }
    
    var invokedDeleteButtonTapped = false
    func deleteButtonTapped(cell: Beybi.DiaryCell) {
        invokedDeleteButtonTapped = true
    }
}
