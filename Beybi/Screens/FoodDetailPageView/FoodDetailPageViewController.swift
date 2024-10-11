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
    
    
    private lazy var viewModel: FoodDetailPageViewModelProtocol = FoodDetailPageViewModel(delegate: self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        recipeLabel.numberOfLines = 0
        typeView.layer.cornerRadius = 5
        typeView.layer.borderWidth = 1
        typeView.layer.borderColor = beybiColor.cgColor
        typeLabel.textColor = beybiColor
        foodImage.layer.cornerRadius = 5
    }
}

extension FoodDetailPageViewController: FoodDetailPageViewModelDelegate {
    
}
