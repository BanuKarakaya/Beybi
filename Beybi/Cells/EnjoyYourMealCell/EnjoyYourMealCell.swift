//
//  EnjoyYourMealCell.swift
//  Beybi
//
//  Created by Banu on 27.09.2024.
//

import UIKit
import CommonModule

final class EnjoyYourMealCell: UICollectionViewCell {

    @IBOutlet private weak var sliderCollectionView: UICollectionView!
    var timer: Timer?
    var currentIndex = 0
    lazy var viewModel: EnjoyYourMealCellViewModelProtocol = EnjoyYourMealCellViewModel(delegate: self)
    
    override func awakeFromNib() {
        super.awakeFromNib()
        viewModel.viewDidLoad()
        startAutoScroll()
    }
    
    func startAutoScroll() {
        timer = Timer.scheduledTimer(timeInterval: 7.0, target: self, selector: #selector(autoScrollCollectionView), userInfo: nil, repeats: true)
    }
    
    @objc func autoScrollCollectionView() {
        if currentIndex < sliderCollectionView.numberOfItems(inSection: 0) - 1 {
            currentIndex += 1
        } else {
            currentIndex = 0
        }
        let indexPath = IndexPath(item: currentIndex, section: 0)
        sliderCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
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
            let cellViewModel = EnjoyYourMealSliderCellViewModel(delegate: cell, imageUrl: image)
            cell.viewModel = cellViewModel
        }
        return cell
    }
}

extension EnjoyYourMealCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        .init(width: sliderCollectionView.frame.width, height: 40)
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
