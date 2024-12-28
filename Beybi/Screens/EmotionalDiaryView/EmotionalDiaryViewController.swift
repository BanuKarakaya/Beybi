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
    
    private lazy var viewModel: EmotionalDiaryViewModelProtocol! = EmotionalDiaryViewModel(delegate: self)
   
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(addCell), name: .saveButtonTapped, object: nil)
    }
    
    @objc func addCell() {
        viewModel.fetchDiariesFromCoreData()
    }
    
    
    @IBAction func addDiaryButtonTapped(_ sender: Any) {
        viewModel.navigateToEditView()
    }
    
}

extension EmotionalDiaryViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.numberOfItems()
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

extension EmotionalDiaryViewController: EmotionalDiaryViewModelDelegate {
    func appDelegate() -> AppDelegate {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate
    }
    
    func navigateToEditVC() {
        let editVM = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "EditViewController") as! EditViewController
        navigationController?.pushViewController(editVM, animated: true)
    }
    
    func reloadData() {
        diaryCollectionView.reloadData()
    }
    
    func prepareCollectionView() {
        diaryCollectionView.delegate = self
        diaryCollectionView.dataSource = self
        diaryCollectionView.register(cellType: DiaryCell.self)
    }
    
    func prepareUI() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithDefaultBackground()
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        self.title = "Emotional Diary"
    }
}
