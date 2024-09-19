//
//  DailyMenuCell.swift
//  Beybi
//
//  Created by Banu on 15.09.2024.
//

import UIKit

class DailyMenuCell: UICollectionViewCell {

    @IBOutlet weak var menuCollectionView: UICollectionView!
    
    private lazy var viewModel: DailyMenuCellViewModelProtocol = DailyMenuCellViewModel(delegate: self)
    
    override func awakeFromNib() {
        super.awakeFromNib()
        viewModel.viewDidLoad()
    }
}

extension DailyMenuCell: UICollectionViewDelegate {
    
}

extension DailyMenuCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.numberOfItemsInSection()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeCell(cellType: FoodCell.self, indexPath: indexPath)
        return cell
    }
}

extension DailyMenuCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        .init(width: 120, height: 170)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 2, left: 6, bottom: 12, right: 10 )
    }
}

extension DailyMenuCell: DailyMenuCellViewModelDelegate {
    func prepareCollectionView() {
        menuCollectionView.delegate = self
        menuCollectionView.dataSource = self
        
        menuCollectionView.register(cellType: FoodCell.self)
    }
}
