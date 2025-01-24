//
//  FoodSliderMiniCell.swift
//  Beybi
//
//  Created by Banu on 15.09.2024.
//

import UIKit
import SDWebImage
import Food

final class FoodSliderMiniCell: UICollectionViewCell {

    @IBOutlet private weak var foodName: UILabel!
    @IBOutlet private weak var view: UIView!
    @IBOutlet private weak var foodImage: UIImageView!
    @IBOutlet private weak var typeView: UIView!
    @IBOutlet private weak var typeLabel: UILabel!
    @IBOutlet private weak var cookingTimeLabel: UILabel!
    
    var viewModel: FoodSliderMiniCellViewModelProtocol! {
        didSet {
            viewModel.load()
            viewModel.viewDidLoad()
        }
    }
}

extension FoodSliderMiniCell: FoodSliderMiniCellViewModelDelegate {
    func prepareBannerImage(with urlString: String?) {
        if let imageUrlString = urlString, let url = URL(string:imageUrlString){
            foodImage.sd_setImage(with: url)
        }
    }
    
    func setUI() {
        self.layer.cornerRadius = 10
        foodImage.layer.cornerRadius = 5
        typeView.layer.cornerRadius = 5
    }
    
    func configureCell(food: Food?) {
        foodName.text = food?.name
        prepareBannerImage(with: food?.imageUrl)
        typeLabel.text = food?.type
        cookingTimeLabel.text = food?.cookingTime
    }
}
