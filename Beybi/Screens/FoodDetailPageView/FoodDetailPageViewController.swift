//
//  FoodDetailPageViewController.swift
//  Beybi
//
//  Created by Banu on 11.10.2024.
//

import UIKit

class FoodDetailPageViewController: UIViewController {

    private lazy var viewModel: FoodDetailPageViewModelProtocol = FoodDetailPageViewModel(delegate: self)
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
}

extension FoodDetailPageViewController: FoodDetailPageViewModelDelegate {
    
}
