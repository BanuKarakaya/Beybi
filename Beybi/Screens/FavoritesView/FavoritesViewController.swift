//
//  FavoritesViewController.swift
//  Beybi
//
//  Created by Banu on 27.01.2025.
//

import UIKit
import Food
import FoodDetailPageModule
import CommonModule

class FavoritesViewController: UIViewController {
    
    @IBOutlet weak var favCollectionView: UICollectionView!
    var beybiColor = UIColor(red: 237/255, green: 136/255, blue: 74/255, alpha: 1.0)
    var borderColor = UIColor(red: 237/255, green: 136/255, blue: 74/255, alpha: 0.25)
    var searchRecipe = UIColor(red: 174/255, green: 165/255, blue: 164/255, alpha: 0.5)
    var beybiWhite = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1.0)
    
    private lazy var viewModel: FavoritesViewModelProtocol = FavoritesViewModel(delegate: self)

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.viewDidLoad()
        prepareSearchController()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.viewWillApear()
    }
}
 
extension FavoritesViewController: UICollectionViewDelegate {
    
}

extension FavoritesViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.numberOfItems()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeCell(cellType: FoodCell.self, indexPath: indexPath)
        if let food = viewModel.foodAtIndex(index: indexPath.item) {
            let cellViewModel = FoodCellViewModel(delegate: cell, food: food)
            cell.viewModel = cellViewModel
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.didSelectItemAt(index: indexPath.item)
    }
}

extension FavoritesViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        .init(width: (favCollectionView.frame.width - 48)/2, height: 237)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        .init(top: 16, left: 16, bottom: 16, right: 16)
    }
}

extension FavoritesViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        viewModel.searchBarSearchButtonClicked(searchText: searchBar.text)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        viewModel.searchBarCancelButtonClicked()
    }
}

extension FavoritesViewController: FavoritesViewModelDelegate {
    func navigateToDetail(selectedCell: Food) {
        let detailVC = UIStoryboard(name: "DetailStoryboard", bundle: .init(identifier: "com.banu.FoodDetailPageModule")).instantiateViewController(withIdentifier: "FoodDetailPageViewController") as! FoodDetailPageViewController
        let detailVM = FoodDetailPageViewModel(delegate: detailVC)
        detailVM.selectedFood = selectedCell
        detailVC.viewModel = detailVM
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
    func reloadData() {
        favCollectionView.reloadData()
    }
    
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
    
    func prepareUI() {
        self.title = "Favorites"
        let appearance = UINavigationBarAppearance()
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        appearance.backgroundColor = .white
    }
    
    func prepareCollectionView() {
        favCollectionView.dataSource = self
        favCollectionView.delegate = self
        favCollectionView.register(cellType: FoodCell.self)
    }
}
