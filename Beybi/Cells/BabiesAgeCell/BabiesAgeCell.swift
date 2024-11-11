//
//  BabiesAgeCell.swift
//  Beybi
//
//  Created by Banu on 15.09.2024.
//

import UIKit

class BabiesAgeCell: UICollectionViewCell {
    
  @IBOutlet weak var babyInfoCollectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    var viewModel: BabiesAgeCellViewModelProtocol = BabiesAgeCellViewModel()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        viewModel.viewDidLoad()
        viewModel.delegate = self
        babyInfoCollectionView.dataSource = self
        babyInfoCollectionView.delegate = self
        babyInfoCollectionView.register(cellType: BabyInfloSliderCell.self)
        babyInfoCollectionView.showsHorizontalScrollIndicator = false
    }
}

extension BabiesAgeCell: UICollectionViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageWidth = scrollView.frame.width
        let currentPage = Int((scrollView.contentOffset.x + pageWidth / 2) / pageWidth)
        pageControl.currentPage = currentPage
    }
}

extension BabiesAgeCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.numberOfItems()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeCell(cellType: BabyInfloSliderCell.self, indexPath: indexPath)
        if let image = viewModel.infoAtIndex(index: indexPath.item) {
            let cellViewModel = BabyInfoSliderCellViewModel()
            cellViewModel.info = image
            cell.viewModel = cellViewModel
        }
        return cell
    }
}

extension BabiesAgeCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        .init(width: 380, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        0
    }
}

extension BabiesAgeCell: BabiesAgeCellViewModelDelegate {
    func reloadData() {
        babyInfoCollectionView.reloadData()
    }
}
