//
//  EmotionalDiaryViewController.swift
//  Beybi
//
//  Created by Banu on 23.12.2024.
//

import UIKit
import CoreData
import CommonModule

class EmotionalDiaryViewController: UIViewController {

    @IBOutlet weak var diaryCollectionView: UICollectionView!
    @IBOutlet weak var emptyImage: UIImageView!
    @IBOutlet weak var emptyText: UILabel!
    @IBOutlet weak var emptyButton: UIButton!
    
    var lastSwipedCell: DiaryCell?
    
    private lazy var viewModel: EmotionalDiaryViewModelProtocol! = EmotionalDiaryViewModel(delegate: self)
   
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(addCell), name: .saveButtonTapped, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleCellSwipe(_:)), name: .cellDidSwipe, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleCellDelete(_:)), name: .cellDidDelete, object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        diaryCollectionView.reloadData()
    }
    
    @objc private func handleCellSwipe(_ notification: Notification) {
            if let swipedCell = notification.object as? DiaryCell {
                if swipedCell != lastSwipedCell {
                    lastSwipedCell?.resetToOriginalState()
                    lastSwipedCell = swipedCell
                }
            }
        }
    
    @objc private func handleCellDelete(_ notification: Notification) {
        if let deleteCell = notification.object as? DiaryCell {
            deleteButtonTapped(cell: deleteCell)
        }
    }
    
    @objc func addCell() {
        viewModel.fetchDiariesFromCoreData()
        viewModel.emptyViewIsHidden()
    }
    
    @IBAction func addDiaryButtonTapped(_ sender: Any) {
        viewModel.addDiaryButtonTapped()
    }
    
    @IBAction func emptyAddRecordButton(_ sender: Any) {
        viewModel.addDiaryButtonTapped()
    }
    
}

extension EmotionalDiaryViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.numberOfItems()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeCell(cellType: DiaryCell.self, indexPath: indexPath)
        let diary = viewModel.diaryAtIndex(index: indexPath.item)
        let cellViewModel = DiaryCellViewModel(delegate: cell, diary: diary)
        cell.viewModel = cellViewModel
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.didSelectItemAt(index: indexPath.item)
    }
}

extension EmotionalDiaryViewController: UICollectionViewDelegate {
}

extension EmotionalDiaryViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        .init(top: 16, left: 16, bottom: 16, right: 16)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        .init(width: diaryCollectionView.frame.width - 32, height: 305 )
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 16
    }
}

extension EmotionalDiaryViewController: EmotionalDiaryViewModelDelegate {
    func deleteButtonTapped(cell: DiaryCell) {
            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        guard let indexPathItem = diaryCollectionView.indexPath(for: cell)?.item else { return }
            let objectToDelete = viewModel.diaryAtIndex(index: indexPathItem)
            context.delete(objectToDelete)
            
            do {
                try context.save()
                print("Veri başarıyla silindi.")
            } catch {
                print("Hata: Veri silinemedi - \(error.localizedDescription)")
            }
            viewModel.fetchDiariesFromCoreData()
            viewModel.emptyViewIsHidden()
    }
    
    func emptyView(hidden: Bool) {
        emptyImage.isHidden = hidden
        emptyText.isHidden = hidden
        emptyButton.isHidden = hidden
    }
    
    func navigateToDetailVC(selectedCell: DemoEntity?) {
        let detailVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DiaryDetailViewController") as! DiaryDetailViewController
        navigationController?.pushViewController(detailVC, animated: true)
        let detailViewModel = DiaryDetailViewModel(delegate: detailVC)
        detailVC.viewModel = detailViewModel
        detailViewModel.selectedDiary = selectedCell
    }
    
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
