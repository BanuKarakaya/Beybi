//
//  EnjoyYourMealCell.swift
//  Beybi
//
//  Created by Banu on 27.09.2024.
//

import UIKit

class EnjoyYourMealCell: UICollectionViewCell {

    @IBOutlet weak var sliderCollectionView: UICollectionView!
    lazy var viewModel: EnjoyYourMealCellViewModelProtocol = EnjoyYourMealCellViewModel(delegate: self)
    
    override func awakeFromNib() {
        super.awakeFromNib()
        viewModel.viewDidLoad()
    }
}

extension EnjoyYourMealCell: UICollectionViewDelegate {
    
}

extension EnjoyYourMealCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.numberOfItems()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeCell(cellType: EnjoyYourMealSliderCell.self, indexPath: indexPath)
        if let image = viewModel.imageAtIndex(index: indexPath.item) {
            let cellViewModel = EnjoyYourMealSliderCellViewModel()
            cellViewModel.imageUrl = image
            cell.viewModel = cellViewModel
        }
        return cell
    }
}

extension EnjoyYourMealCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        .init(width: collectionView.frame.width, height: 40)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

extension EnjoyYourMealCell: EnjoyYourMealCellViewModelDelegate {
    func setUI() {
        sliderCollectionView.delegate = self
        sliderCollectionView.dataSource = self
        sliderCollectionView.register(cellType: EnjoyYourMealSliderCell.self)
        sliderCollectionView.layer.cornerRadius = 10
        sliderCollectionView.showsHorizontalScrollIndicator = false
    }
    
    func reloadData() {
        sliderCollectionView.reloadData()
    }
}
