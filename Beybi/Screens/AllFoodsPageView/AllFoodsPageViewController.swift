//
//  AllFoodsPageViewController.swift
//  Beybi
//
//  Created by Banu on 14.09.2024.
//

import UIKit
import Food
import FoodDetailPageModule
import CommonModule

final class AllFoodsPageViewController: UIViewController {
    
    @IBOutlet private weak var allFoodsCollectionView: UICollectionView!
    @IBOutlet weak var categoriesCollectionView: UICollectionView!
    
    private lazy var viewModel: AllFoodsPageViewModelProtocol = AllFoodsPageViewModel(delegate: self)
    private var previousOffsetY: CGFloat = 0
    var beybiColor = UIColor(red: 237/255, green: 136/255, blue: 74/255, alpha: 1.0)
    var borderColor = UIColor(red: 237/255, green: 136/255, blue: 74/255, alpha: 0.25)
    var searchRecipe = UIColor(red: 174/255, green: 165/255, blue: 164/255, alpha: 0.5)
    var beybiWhite = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1.0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(getFoodTypeLabelValue(_:)), name: .getTypeLabelValue, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(navigateToDetail(_:)), name: .foodSliderCellTapped, object: nil)
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
    
    @objc func navigateToDetail(_ notification: NSNotification) {
        if let dict = notification.userInfo as NSDictionary? {
            if let selectedCell = dict["selectedCell"] as? Food {
                let detailVC = UIStoryboard(name: "DetailStoryboard", bundle: .init(identifier: "com.banu.FoodDetailPageModule")).instantiateViewController(withIdentifier: "FoodDetailPageViewController") as! FoodDetailPageViewController
                let detailVM = FoodDetailPageViewModel(delegate: detailVC)
                detailVM.selectedFood = selectedCell
                detailVC.viewModel = detailVM
                navigationController?.pushViewController(detailVC, animated: true)
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
        if collectionView == categoriesCollectionView {
            return 5
        } else if collectionView == allFoodsCollectionView {
            return viewModel.numberOfItemsInSection()
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == categoriesCollectionView {
            let cell = collectionView.dequeCell(cellType: CategoriesCell.self, indexPath: indexPath)
            
            return cell
        } else if collectionView == allFoodsCollectionView {
            let cell = collectionView.dequeCell(cellType: FoodCell.self, indexPath: indexPath)
       
            return cell
        }
        return UICollectionViewCell()
    }
}

extension AllFoodsPageViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == categoriesCollectionView {
            return CGSize(width: 89, height: 98)
        } else if collectionView == allFoodsCollectionView {
            return CGSize(width: 172.5, height: 237)
        } else {
            return CGSize(width: 89, height: 98)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if collectionView == categoriesCollectionView {
            return UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 0)
        } else if collectionView == allFoodsCollectionView {
            return UIEdgeInsets(top: 16, left: 16, bottom: 0, right: 16)
        } else {
            return UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 0)
        }
    }
}

extension AllFoodsPageViewController: UISearchBarDelegate {
    
}

extension AllFoodsPageViewController: AllFoodsPageViewModelDelegate {
    func prepareSearchController() {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.hidesNavigationBarDuringPresentation = true
        searchController.obscuresBackgroundDuringPresentation = false
        navigationItem.searchController = searchController
        UIBarButtonItem.appearance(whenContainedInInstancesOf: [UISearchBar.self]).tintColor = beybiColor
        
        var searchBar = searchController.searchBar
        searchBar.searchTextField.attributedPlaceholder = NSAttributedString(
            string: "Search recipe",
            attributes: [NSAttributedString.Key.foregroundColor: searchRecipe]
        )
        searchBar.searchTextField.backgroundColor = .white
        if let searchIconView = searchBar.searchTextField.leftView as? UIImageView {
           searchIconView.tintColor = beybiColor
        }
        
        if let searchTextField = searchBar.searchTextField as? UITextField {
            searchTextField.layer.borderColor = borderColor.cgColor
            searchTextField.layer.borderWidth = 1.0
            searchTextField.layer.cornerRadius = 12
            searchTextField.clipsToBounds = true
            searchTextField.backgroundColor = beybiWhite
        }
        
        searchController.searchBar.delegate = self
    }
    
  
    func prepareCollectionView() {
        allFoodsCollectionView.dataSource = self
        allFoodsCollectionView.delegate = self
        allFoodsCollectionView.showsVerticalScrollIndicator = false
        allFoodsCollectionView.register(cellType: FoodCell.self)
        categoriesCollectionView.dataSource = self
        categoriesCollectionView.delegate = self
        categoriesCollectionView.register(cellType: CategoriesCell.self)
        categoriesCollectionView.showsHorizontalScrollIndicator = false
    }
    
    func setUI() {
        self.title = "Foods"
        let appearance = UINavigationBarAppearance()
        //appearance.configureWithDefaultBackground()
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        appearance.backgroundColor = beybiWhite
    }
}
