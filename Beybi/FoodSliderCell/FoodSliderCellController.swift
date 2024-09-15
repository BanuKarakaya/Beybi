//
//  FoodSliderCellController.swift
//  Beybi
//
//  Created by Banu on 14.09.2024.
//

import UIKit

class FoodSliderCellController: UICollectionViewCell {

    @IBOutlet weak var foodTypeImage: UIImageView!
    @IBOutlet weak var foodTypeLabel: UILabel!
    @IBOutlet weak var horizontalCollectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        horizontalCollectionView.delegate = self
        horizontalCollectionView.dataSource = self
        foodTypeImage.layer.cornerRadius = 10

        horizontalCollectionView.register(cellType: CollectionViewCell.self)
    }

    @IBAction func viewMoreButtonTapped(_ sender: Any) {
    }
}

extension FoodSliderCellController: UICollectionViewDelegate {
    
}
  
extension FoodSliderCellController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        9
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeCell(cellType: CollectionViewCell.self, indexPath: indexPath)
        return cell
    }
}

extension FoodSliderCellController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: self.frame.width - 30, height: (self.frame.height - 4) / 4)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 5, left: 0, bottom: 5, right:0 )
    }
}

