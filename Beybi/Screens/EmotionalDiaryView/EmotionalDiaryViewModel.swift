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
    func navigateToEditView()
}

protocol EmotionalDiaryViewModelDelegate: AnyObject {
    func prepareUI()
    func prepareCollectionView()
    func reloadData()
    func navigateToEditVC()
    func appDelegate() -> AppDelegate
}

final class EmotionalDiaryViewModel {
    private weak var delegate: EmotionalDiaryViewModelDelegate?
    private var diaries: [DemoEntity] = []
    
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
    func navigateToEditView() {
        delegate?.navigateToEditVC()
    }
    
    func fetchDiariesFromCoreData() {
        fetchDiaries()
    }
    
    func numberOfItems() -> Int {
        diaries.count + 1
    }
    
    func viewDidLoad() {
        delegate?.prepareUI()
        delegate?.prepareCollectionView()
        fetchDiaries()
    }
}
