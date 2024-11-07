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
    private var previousOffsetY: CGFloat = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(getFoodTypeLabelValue(_:)), name: .getTypeLabelValue, object: nil)
    }
 
    @objc func getFoodTypeLabelValue(_ notification: NSNotification) {
        print(notification.userInfo)
        if let dict = notification.userInfo as NSDictionary? {
            if let foodType = dict["foodType"] as? String {
                let viewMoreVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ViewMoreViewController") as! ViewMoreViewController
                let viewMoreVM = ViewMoreViewModel(delegate: viewMoreVC)
                viewMoreVM.foodType = foodType
                viewMoreVC.viewModel = viewMoreVM
                navigationController?.pushViewController(viewMoreVC, animated: true)
            }
        }
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

extension AllFoodsPageViewController: AllFoodsPageViewModelDelegate {
  
    func prepareCollectionView() {
        allFoodsCollectionView.dataSource = self
        allFoodsCollectionView.delegate = self
        
        allFoodsCollectionView.register(cellType: FoodSliderCellController.self)
        allFoodsCollectionView.register(UINib(nibName: "EnjoyYourMealHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "EnjoyYourMealHeaderView")
    }
    
    func setUI() {
        allFoodsCollectionView.backgroundColor = .systemGray6
        self.title = "Foods"
        let appearance = UINavigationBarAppearance()
        appearance.configureWithDefaultBackground()
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance


    }
}
