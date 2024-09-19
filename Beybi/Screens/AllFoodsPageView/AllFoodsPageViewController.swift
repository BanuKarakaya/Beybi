//
//  AllFoodsPageViewController.swift
//  Beybi
//
//  Created by Banu on 14.09.2024.
//

import UIKit

class AllFoodsPageViewController: UIViewController {
    

    @IBOutlet weak var allFoodsCollectionView: UICollectionView!
    
    private lazy var viewModel: AllFoodsPageViewModelProtocol = AllFoodsPageViewModel(delegate: self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.viewDidLoad()
    }
}

extension AllFoodsPageViewController: UICollectionViewDelegate {
    
}

extension AllFoodsPageViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.numberOfItemsInSection()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell =  collectionView.dequeCell(cellType: FoodSliderCellController.self, indexPath: indexPath)
        return cell
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
        allFoodsCollectionView.backgroundColor = .systemGray6
    }
}
