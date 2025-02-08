//
//  FavoritesViewController.swift
//  Beybi
//
//  Created by Banu on 27.01.2025.
//

import UIKit

class FavoritesViewController: UIViewController {
    
    var beybiColor = UIColor(red: 237/255, green: 136/255, blue: 74/255, alpha: 1.0)
    var borderColor = UIColor(red: 237/255, green: 136/255, blue: 74/255, alpha: 0.25)
    var searchRecipe = UIColor(red: 174/255, green: 165/255, blue: 164/255, alpha: 0.5)
    var beybiWhite = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1.0)

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Favorites"
        let appearance = UINavigationBarAppearance()
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        appearance.backgroundColor = .white
        prepareSearchController()
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
}


extension FavoritesViewController: UISearchBarDelegate {
    
}
