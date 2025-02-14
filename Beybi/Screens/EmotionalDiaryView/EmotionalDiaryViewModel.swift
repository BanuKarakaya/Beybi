//
//  EmotionalDiaryViewModel.swift
//  Beybi
//
//  Created by Banu on 23.12.2024.
//

import Foundation
import CoreData

protocol EmotionalDiaryViewModelProtocol {
    func viewDidLoad()
    func numberOfItems() -> Int
    func fetchDiariesFromCoreData()
    func addDiaryButtonTapped()
    func diaryAtIndex(index: Int) -> DemoEntity
    func didSelectItemAt(index: Int)
    func emptyViewIsHidden()
}

protocol EmotionalDiaryViewModelDelegate: AnyObject {
    func prepareUI()
    func prepareCollectionView()
    func reloadData()
    func navigateToEditVC()
    func appDelegate() -> AppDelegate
    func navigateToDetailVC(selectedCell: DemoEntity?)
    func emptyView(hidden: Bool)
    func deleteButtonTapped(cell: DiaryCell)
}

final class EmotionalDiaryViewModel {
    private weak var delegate: EmotionalDiaryViewModelDelegate?
    var diaries: [DemoEntity] = []
    
    init(delegate: EmotionalDiaryViewModelDelegate?) {
        self.delegate = delegate
    }
    
    func fetchDiaries() {
        let appDelegate = delegate?.appDelegate()
        let context = appDelegate?.persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<DemoEntity> = DemoEntity.fetchRequest()
        
        do {
            if let context = context {
                diaries = try context.fetch(fetchRequest)
            }
        } catch {
            print("Failed to fetch diaries: \(error)")
        }
        delegate?.reloadData()
    }
}

extension EmotionalDiaryViewModel: EmotionalDiaryViewModelProtocol {
    func emptyViewIsHidden() {
        if diaries.count == 0 {
            delegate?.emptyView(hidden: false)
        } else {
            delegate?.emptyView(hidden: true)
        }
    }
    
    func didSelectItemAt(index: Int) {
        var selectedCell: DemoEntity?
        
        selectedCell = diaries[index]
        delegate?.navigateToDetailVC(selectedCell: selectedCell)
    }
    
    func diaryAtIndex(index: Int) -> DemoEntity {
        let diary = diaries[index]
        return diary
    }
    
    func addDiaryButtonTapped() {
        delegate?.navigateToEditVC()
    }
    
    func fetchDiariesFromCoreData() {
        fetchDiaries()
    }
    
    func numberOfItems() -> Int {
        diaries.count
    }
    
    func viewDidLoad() {
        delegate?.prepareUI()
        delegate?.prepareCollectionView()
        fetchDiaries()
        emptyViewIsHidden()
    }
}
