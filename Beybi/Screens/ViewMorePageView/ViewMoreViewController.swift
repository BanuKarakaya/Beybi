//
//  ViewMoreViewController.swift
//  Beybi
//
//  Created by Banu on 19.09.2024.
//

import UIKit

final class ViewMoreViewController: UIViewController {

    @IBOutlet private weak var viewMoreCollectionView: UICollectionView!
    
    lazy var viewModel: ViewMoreViewModelProtocol = ViewMoreViewModel(delegate: self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.viewDidLoad()
    }
}

extension ViewMoreViewController: UICollectionViewDelegate {
    
}

extension ViewMoreViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.numberOfItemsInSection()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeCell(cellType: ViewMoreCell.self, indexPath: indexPath)
        if let food = viewModel.foodAtIndex(index: indexPath.item) {
            let cellViewModel = ViewMoreCellViewModel(delegate: cell, food: food)
            cell.viewModel = cellViewModel
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.didSelectItemAt(index: indexPath.item)
    }
}

extension ViewMoreViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        .init(width: viewMoreCollectionView.frame.width - 18, height: 90)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        .init(top: 6.5, left: 6.5, bottom: 6.5, right: 6.5)
    }
}

extension ViewMoreViewController: ViewMoreViewModelDelegate {
    func prepareUI(foodType: String?) {
        self.title = foodType
    }
    
    func reloadData() {
        viewMoreCollectionView.reloadData()
    }
    
    func navigateToDetailVC(selectedCell: Food?) {
        let detailVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "FoodDetailPageViewController") as! FoodDetailPageViewController
        navigationController?.pushViewController(detailVC, animated: true)
        let detailViewModel = FoodDetailPageViewModel(delegate: detailVC)
        detailVC.viewModel = detailViewModel
        detailViewModel.selectedFood = selectedCell
    }
    
    func prepareCollectionView() {
        viewMoreCollectionView.delegate = self
        viewMoreCollectionView.dataSource = self
        viewMoreCollectionView.showsVerticalScrollIndicator = false
        viewMoreCollectionView.register(cellType: ViewMoreCell.self)
    }
}
