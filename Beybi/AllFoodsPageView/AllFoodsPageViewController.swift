//
//  AllFoodsPageViewController.swift
//  Beybi
//
//  Created by Banu on 14.09.2024.
//

import UIKit

class AllFoodsPageViewController: UIViewController {
    
    @IBOutlet weak var allFoodsCollectionView: UICollectionView!
    
    var viewModel: AllFoodsPageViewModelProtocol = AllFoodsPageViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        viewModel.viewDidLoad()
        allFoodsCollectionView.backgroundColor = .systemGray6
    }
}

extension AllFoodsPageViewController: AllFoodsPageViewModelDelegate {
    func prepareCollectionView() {
        allFoodsCollectionView.dataSource = self
        allFoodsCollectionView.delegate = self
        
        allFoodsCollectionView.register(cellType: FoodSliderCellController.self)
    }
    
    func setUI() {
        allFoodsCollectionView.backgroundColor = .white
    }
}

extension AllFoodsPageViewController: UICollectionViewDelegate {
    
}

extension AllFoodsPageViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        7
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell =  collectionView.dequeCell(cellType: FoodSliderCellController.self, indexPath: indexPath)
        return cell
    }
    
    
}
