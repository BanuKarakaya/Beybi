//
//  ViewMoreViewController.swift
//  Beybi
//
//  Created by Banu on 19.09.2024.
//

import UIKit

class ViewMoreViewController: UIViewController {

    @IBOutlet weak var viewMoreCollectionView: UICollectionView!
    
    private lazy var viewModel: ViewMoreViewModelProtocol = ViewMoreViewModel(delegate: self)
    
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
        let cell = collectionView.dequeCell(cellType: FoodSliderMiniCell.self, indexPath: indexPath)
        return cell
    }
}

extension ViewMoreViewController: ViewMoreViewModelDelegate {
    func prepareCollectionView() {
        viewMoreCollectionView.delegate = self
        viewMoreCollectionView.dataSource = self
        
        viewMoreCollectionView.register(cellType: FoodSliderMiniCell.self)
    }
}
