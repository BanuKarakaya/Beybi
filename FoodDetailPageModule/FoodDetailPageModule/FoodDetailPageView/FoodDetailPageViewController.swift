//
//  FoodDetailPageViewController.swift
//  Beybi
//
//  Created by Banu on 11.10.2024.
//

import UIKit
import Food
import CommonModule
import SDWebImage

public class FoodDetailPageViewController: UIViewController {
    
    @IBOutlet weak var foodImage: UIImageView!
    @IBOutlet weak var topConstraints: NSLayoutConstraint!
    @IBOutlet weak var blueView: UIView!
    @IBOutlet weak var scrollViewLine: UIView!
    @IBOutlet weak var foodName: UILabel!
    @IBOutlet weak var ingredientsCollectionView: UICollectionView!
    @IBOutlet weak var recipeCollectionView: UICollectionView!
    
    
    var beybiColor = UIColor(red: 162/255.0, green: 10/255.0, blue: 30/255.0, alpha: 0.9)
    var darkBeybiColor = UIColor(red: 113/255.0, green: 27/255.0, blue: 41/255.0, alpha: 1)
    
    public lazy var viewModel: FoodDetailPageViewModelProtocol = FoodDetailPageViewModel(delegate: self)
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.viewDidLoad()
        scrollViewLine.layer.cornerRadius = 2
        blueView.layer.cornerRadius = 20
        let swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(_:)))
                swipeUp.direction = .up
        blueView.addGestureRecognizer(swipeUp)

                let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(_:)))
                swipeDown.direction = .down
        blueView.addGestureRecognizer(swipeDown)
    }
    
    @objc func handleSwipe(_ gesture: UISwipeGestureRecognizer) {
            switch gesture.direction {
            case .up:
                moveView(up: true)
            case .down:
                moveView(up: false)
            default:
                break
            }
        }
    
    func moveView(up: Bool) {
            let newConstant: CGFloat = up ? 0 : 335
            UIView.animate(withDuration: 0.8) {
                self.topConstraints.constant = newConstant
                self.view.layoutIfNeeded()
            }
        }
    
    public override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if let heightConstraint = recipeCollectionView.constraints.first(where: { $0.identifier == "collectionViewHeight" }) {
            heightConstraint.constant = recipeCollectionView.contentSize.height
        }
    }
}

extension FoodDetailPageViewController: UICollectionViewDelegate {
    
}

extension FoodDetailPageViewController: UICollectionViewDataSource {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
         if collectionView == ingredientsCollectionView {
            return viewModel.numberOfItemsForIngredients()
         } else if collectionView == recipeCollectionView {
            return viewModel.numberOfItemsForRecipeStep()
         }
            return 0
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
         if collectionView == ingredientsCollectionView {
            let cell = collectionView.dequeCell(cellType: IngredientsCell.self, indexPath: indexPath)
            let ingredient = viewModel.ingredientsAtIndex(index: indexPath.item)
            let cellViewModel = IngredientsCellViewModel(delegate: cell, ingredients: ingredient)
            cell.viewModel = cellViewModel
        
            return cell
         } else if collectionView == recipeCollectionView {
            let cell = collectionView.dequeCell(cellType: RecipeCell.self, indexPath: indexPath)
            let recipeStep = viewModel.recipeStepAtIndex(index: indexPath.item)
            let cellViewModel = RecipeViewModel(delegate: cell, recipeStep: recipeStep, recipeIndex: indexPath.item)
            cell.viewModel = cellViewModel
                    
            return cell
        }
        return UICollectionViewCell()
    }
}

extension FoodDetailPageViewController: FoodDetailPageViewModelDelegate {
    public func prepareCollectionView() {
        ingredientsCollectionView.delegate = self
        ingredientsCollectionView.dataSource = self
        ingredientsCollectionView.register(UINib(nibName: "IngredientsCell", bundle: .init(identifier: "com.banu.FoodDetailPageModule")), forCellWithReuseIdentifier: "IngredientsCell")
        
        recipeCollectionView.delegate = self
        recipeCollectionView.dataSource = self
        recipeCollectionView.isScrollEnabled = false
        recipeCollectionView.register(UINib(nibName: "RecipeCell", bundle: .init(identifier: "com.banu.FoodDetailPageModule")), forCellWithReuseIdentifier: "RecipeCell")
    }
    
    public func prepareUI() {
//        recipeLabel.numberOfLines = 0
//        ingredientsCollectionView.showsHorizontalScrollIndicator = false
    }
    
    public func prepareBannerImage(with urlString: String?) {
        if let imageUrlString = urlString, let url = URL(string:imageUrlString){
            foodImage.sd_setImage(with: url)
        }
    }
    
    public func configure(selectedFood: Food?) {
        //foodName.text = """
       
          prepareBannerImage(with: selectedFood?.imageUrl)
//          recipeLabel.text = selectedFood?.introText
          self.title = selectedFood?.name
    }
}

