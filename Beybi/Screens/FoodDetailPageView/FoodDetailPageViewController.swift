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
    var beybiColor = UIColor(red: 162/255.0, green: 10/255.0, blue: 30/255.0, alpha: 0.9)
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var foodImage: UIImageView!
    @IBOutlet weak var ingredientsCollectionView: UICollectionView!
    @IBOutlet weak var recipeCollectionView: UICollectionView!
    @IBOutlet weak var foodName: UILabel!
    
    private lazy var viewModel: FoodDetailPageViewModelProtocol = FoodDetailPageViewModel(delegate: self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        recipeLabel.numberOfLines = 0
        typeView.layer.cornerRadius = 5
        typeView.layer.borderWidth = 1
        typeView.layer.borderColor = beybiColor.cgColor
        typeLabel.textColor = beybiColor
        foodImage.layer.cornerRadius = 5
        ingredientsCollectionView.delegate = self
        ingredientsCollectionView.dataSource = self
        ingredientsCollectionView.register(cellType: IngredientsCell.self)
        ingredientsCollectionView.showsHorizontalScrollIndicator = false
        recipeCollectionView.delegate = self
        recipeCollectionView.dataSource = self
        recipeCollectionView.register(cellType: RecipeCell.self)
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
            return 10
        } else if collectionView == recipeCollectionView {
            return 10
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == ingredientsCollectionView {
            let cell = collectionView.dequeCell(cellType: IngredientsCell.self, indexPath: indexPath)
            return cell
        } else if collectionView == recipeCollectionView {
            let cell = collectionView.dequeCell(cellType: RecipeCell.self, indexPath: indexPath)
            return cell
        }
        return UICollectionViewCell()
    }
}

extension FoodDetailPageViewController: FoodDetailPageViewModelDelegate {
    func prepareBannerImage(with urlString: String?) {
        if let imageUrlString = urlString, let url = URL(string:imageUrlString){
            foodImage.sd_setImage(with: url)
        }
    }
    
    func configure(selectedFood: Food?) {
        typeLabel.text = selectedFood?.type
        foodName.text = selectedFood?.name
        prepareBannerImage(with: selectedFood?.imageUrl)
        recipeLabel.text = selectedFood?.recipe
    }
}

