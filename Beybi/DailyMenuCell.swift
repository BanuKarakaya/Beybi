//
//  DailyMenuCell.swift
//  Beybi
//
//  Created by Banu on 15.09.2024.
//

import UIKit

class DailyMenuCell: UICollectionViewCell {

    @IBOutlet weak var menuCollectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        menuCollectionView.delegate = self
        menuCollectionView.dataSource = self
        
        menuCollectionView.register(cellType: FoodCell.self)
    }

}

extension DailyMenuCell: UICollectionViewDelegate {
    
}

extension DailyMenuCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        5
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
