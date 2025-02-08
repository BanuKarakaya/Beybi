//
//  FoodSliderCellController.swift
//  Beybi
//
//  Created by Banu on 14.09.2024.
//

import UIKit
import CommonModule

final class FoodSliderCellController: UICollectionViewCell {

    @IBOutlet weak var foodTypeLabel: UILabel!
    @IBOutlet private weak var horizontalCollectionView: UICollectionView!
    
    
    var viewModel: FoodSliderCellViewModelProtocol! {
        didSet {
            viewModel.viewDidLoad()
        }
    }

    @IBAction func viewMoreButtonTapped(_ sender: Any) {
        let foodType: [String: String] = ["foodType": foodTypeLabel.text ?? ""]
        NotificationCenter.default.post(name: .getTypeLabelValue, object: nil, userInfo: foodType)
    }
}

extension FoodSliderCellController: UICollectionViewDelegate {
    
}
  
extension FoodSliderCellController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.numberOfItemsInSection()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeCell(cellType: FoodCell.self, indexPath: indexPath)
        if let food = viewModel.foodAtIndex(index: indexPath.item) {
           let cellViewModel = FoodCellViewModel(delegate: cell, food: food)
           cell.viewModel = cellViewModel
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.didSelectItemAt(index: indexPath.item)
        viewModel.sendSelectedCell()
    }
}

extension FoodSliderCellController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: 160, height: 237)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        viewModel.minimumInteritemSpacingForSectionAt()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 16
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 16, bottom: 0, right:0 )
    }
}

extension FoodSliderCellController: FoodSliderCellViewModelDelegate {
    func configureCell(type: String) {
        foodTypeLabel.text = type
    }
    
    func reloadData() {
        horizontalCollectionView.reloadData()
    }
    
    func prepareCollectionView() {
        horizontalCollectionView.delegate = self
        horizontalCollectionView.dataSource = self
        horizontalCollectionView.showsHorizontalScrollIndicator = false
        
        horizontalCollectionView.register(cellType: FoodCell.self)
    }
}
