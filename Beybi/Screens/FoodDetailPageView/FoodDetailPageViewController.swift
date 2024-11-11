//
//  FoodDetailPageViewController.swift
//  Beybi
//
//  Created by Banu on 11.10.2024.
//

import UIKit

class FoodDetailPageViewController: UIViewController {

    @IBOutlet weak var typeView: UIView!
    @IBOutlet weak var recipeLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var foodImage: UIImageView!
    @IBOutlet weak var ingredientsCollectionView: UICollectionView!
    @IBOutlet weak var recipeCollectionView: UICollectionView!
    @IBOutlet weak var foodName: UILabel!
    @IBOutlet weak var ingredientsView: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    var beybiColor = UIColor(red: 162/255.0, green: 10/255.0, blue: 30/255.0, alpha: 0.9)
    var darkBeybiColor = UIColor(red: 113/255.0, green: 27/255.0, blue: 41/255.0, alpha: 1)
    
    lazy var viewModel: FoodDetailPageViewModelProtocol = FoodDetailPageViewModel(delegate: self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.viewDidLoad()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if let heightConstraint = recipeCollectionView.constraints.first(where: { $0.identifier == "collectionViewHeight" }) {
            heightConstraint.constant = recipeCollectionView.contentSize.height
        }
    }
}

extension FoodDetailPageViewController: UICollectionViewDelegate {
    
}

extension FoodDetailPageViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == ingredientsCollectionView {
            return viewModel.numberOfItemsForIngredients()
        } else if collectionView == recipeCollectionView {
            return viewModel.numberOfItemsForRecipeStep()
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == ingredientsCollectionView {
            let cell = collectionView.dequeCell(cellType: IngredientsCell.self, indexPath: indexPath)
            let ingredient = viewModel.ingredientsAtIndex(index: indexPath.item)
            let cellViewModel = IngredientsCellViewModel()
            cellViewModel.ingredients = ingredient
            cell.viewModel = cellViewModel
            
            return cell
        } else if collectionView == recipeCollectionView {
            let cell = collectionView.dequeCell(cellType: RecipeCell.self, indexPath: indexPath)
            let recipeStep = viewModel.recipeStepAtIndex(index: indexPath.item)
            let cellViewModel = RecipeViewModel()
            cellViewModel.recipeStep = recipeStep
            cellViewModel.recipeIndex = indexPath.item
            cell.viewModel = cellViewModel
                
            return cell
        }
        return UICollectionViewCell()
    }
}

extension FoodDetailPageViewController: FoodDetailPageViewModelDelegate {
    func prepareCollectionView() {
        ingredientsCollectionView.delegate = self
        ingredientsCollectionView.dataSource = self
        ingredientsCollectionView.register(cellType: IngredientsCell.self)
        
        recipeCollectionView.delegate = self
        recipeCollectionView.dataSource = self
        recipeCollectionView.isScrollEnabled = false
        recipeCollectionView.register(cellType: RecipeCell.self)
    }
    
    func prepareUI() {
        recipeLabel.numberOfLines = 0
        typeView.layer.cornerRadius = 5
        typeView.layer.borderWidth = 1
        typeView.layer.borderColor = darkBeybiColor.cgColor
        typeLabel.textColor = darkBeybiColor
        foodImage.layer.cornerRadius = 5
        ingredientsView.layer.cornerRadius = 10
        ingredientsCollectionView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
    }
    
    func prepareBannerImage(with urlString: String?) {
        if let imageUrlString = urlString, let url = URL(string:imageUrlString){
            foodImage.sd_setImage(with: url)
        }
    }
    
    func configure(selectedFood: Food?) {
        typeLabel.text = selectedFood?.type
        foodName.text = selectedFood?.name
        prepareBannerImage(with: selectedFood?.imageUrl)
        recipeLabel.text = selectedFood?.introText
        self.title = selectedFood?.name
    }
}

