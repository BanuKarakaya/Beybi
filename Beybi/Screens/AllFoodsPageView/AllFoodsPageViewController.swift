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
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "EnjoyYourMealHeaderView", for: indexPath) as! EnjoyYourMealHeaderView
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return .init(width: view.frame.width, height: 40)
    }
    
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
        allFoodsCollectionView.backgroundColor = .white
        allFoodsCollectionView.backgroundColor = .systemGray6
        self.title = "Foods"
        let appearance = UINavigationBarAppearance()
        appearance.configureWithDefaultBackground()
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance


    }
}
