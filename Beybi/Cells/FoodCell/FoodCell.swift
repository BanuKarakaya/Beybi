//
//  FoodCell.swift
//  Beybi
//
//  Created by Banu on 15.09.2024.
//

import UIKit

final class FoodCell: UICollectionViewCell {

    @IBOutlet private weak var foodName: UILabel!
    @IBOutlet private weak var typeView: UIView!
    @IBOutlet private weak var typeLabel: UILabel!
    @IBOutlet private weak var foodImage: UIImageView!
    
    var viewModel: FoodCellViewModelProtocol! {
        didSet {
            viewModel.delegate = self
            viewModel.load()
            viewModel.viewDidLoad()
        }
    }
}

extension FoodCell: FoodCellViewModelDelegate {
    func prepareBannerImage(with urlString: String?) {
        if let imageUrlString = urlString, let url = URL(string:imageUrlString){
            foodImage.sd_setImage(with: url)
        }
    }
    
    func configureCell(food: Food?) {
        foodName.text = food?.name
        typeLabel.text = food?.type
        prepareBannerImage(with: food?.imageUrl)
    }
    
    func setUI() {
        self.layer.cornerRadius = 10
        typeView.layer.cornerRadius = 5
    }
}
