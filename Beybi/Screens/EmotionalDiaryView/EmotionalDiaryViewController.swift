//
//  EmotionalDiaryViewController.swift
//  Beybi
//
//  Created by Banu on 23.12.2024.
//

import UIKit
import CoreData

class EmotionalDiaryViewController: UIViewController {

    @IBOutlet weak var diaryCollectionView: UICollectionView!
    var diaries: [DemoEntity] = []
   
    override func viewDidLoad() {
        super.viewDidLoad()
        let appearance = UINavigationBarAppearance()
        appearance.configureWithDefaultBackground()
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        
        self.title = "Emotional Diary"
        
        diaryCollectionView.delegate = self
        diaryCollectionView.dataSource = self
        diaryCollectionView.register(cellType: DiaryCell.self)
        
        NotificationCenter.default.addObserver(self, selector: #selector(addCell), name: .saveButtonTapped, object: nil)
        
    }
    
    @objc func addCell() {
        fetchDiaries()
    }
    
    func fetchDiaries() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let fetchRequest: NSFetchRequest<DemoEntity> = DemoEntity.fetchRequest()
        
        do {
            diaries = try context.fetch(fetchRequest)
        } catch {
            print("Failed to fetch diaries: \(error)")
        }
    }
    
    @IBAction func addDiaryButtonTapped(_ sender: Any) {
    
        let editVM = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "EditViewController") as! EditViewController
        navigationController?.pushViewController(editVM, animated: true)
    }
    
}

extension EmotionalDiaryViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        diaries.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeCell(cellType: DiaryCell.self, indexPath: indexPath)
        return cell
    }
}

extension EmotionalDiaryViewController: UICollectionViewDelegate {
    
}

extension EmotionalDiaryViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        .init(top: 8, left: 0, bottom: 8, right: 0)
    }
}
