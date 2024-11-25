//
//  FoodSliderCellController.swift
//  Beybi
//
//  Created by Banu on 14.09.2024.
//

import UIKit

final class FoodSliderCellController: UICollectionViewCell {

    @IBOutlet private weak var foodTypeImage: UIImageView!
    @IBOutlet private weak var foodTypeLabel: UILabel!
    @IBOutlet private weak var horizontalCollectionView: UICollectionView!
    
    
    var viewModel: FoodSliderCellViewModelProtocol! {
        didSet {
            viewModel.viewDidLoad()
            viewModel.load()
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
        let cell = collectionView.dequeCell(cellType: FoodSliderMiniCell.self, indexPath: indexPath)
        if let food = viewModel.foodAtIndex(index: indexPath.item) {
            let cellViewModel = FoodSliderMiniCellViewModel(delegate: cell, food: food)
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
        return .init(width: self.frame.width - 30, height: (self.frame.height - 4) / 4)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        viewModel.minimumInteritemSpacingForSectionAt()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        viewModel.minimumLineSpacingForSectionAt()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 5, left: 0, bottom: 5, right:0 )
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
        
        horizontalCollectionView.register(cellType: FoodSliderMiniCell.self)
    }
}
