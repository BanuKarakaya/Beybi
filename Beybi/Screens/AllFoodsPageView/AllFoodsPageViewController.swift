//
//  AllFoodsPageViewController.swift
//  Beybi
//
//  Created by Banu on 14.09.2024.
//

import UIKit

class AllFoodsPageViewController: UIViewController {
    
    @IBOutlet weak var enjoyYourMealView: UIView!
    @IBOutlet weak var allFoodsCollectionView: UICollectionView!
    @IBOutlet weak var enjoyYourMealViewHeight: NSLayoutConstraint!
    private lazy var viewModel: AllFoodsPageViewModelProtocol = AllFoodsPageViewModel(delegate: self)
    private var previousOffsetY: CGFloat = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(navigateToViewMoreVC), name: .viewMoreButtonTapped, object: nil)
    }
    
    @objc func navigateToViewMoreVC() {
        let viewMoreVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ViewMoreViewController") as! ViewMoreViewController
        navigationController?.pushViewController(viewMoreVC, animated: true)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: .viewMoreButtonTapped, object: nil)
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
         let type = viewModel.typeAtIndex(index: indexPath.item)
         let cellViewModel = FoodSliderCellViewModel()
         cellViewModel.type = type
         cell.viewModel = cellViewModel
    
         return cell
    }
}

extension AllFoodsPageViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let isScrollingDown = offsetY > previousOffsetY
        let isScrollingUp = offsetY < previousOffsetY
       
        if isScrollingDown && offsetY > 50 {
            UIView.animate(withDuration: 0.6, animations: {
                self.enjoyYourMealViewHeight.constant = 0
                self.view.layoutIfNeeded()
            })
        } else if isScrollingUp {
            UIView.animate(withDuration: 0.4, animations: {
                self.enjoyYourMealViewHeight.constant = 40
                self.view.layoutIfNeeded()
            })
        }
        previousOffsetY = offsetY
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
