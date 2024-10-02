//
//  FoodSliderMiniCell.swift
//  Beybi
//
//  Created by Banu on 15.09.2024.
//

import UIKit
import SDWebImage

class FoodSliderMiniCell: UICollectionViewCell {

    @IBOutlet weak var foodName: UILabel!
    @IBOutlet weak var view: UIView!
    @IBOutlet weak var foodImage: UIImageView!
    
    var viewModel: FoodSliderMiniCellViewModelProtocol! {
        didSet {
            viewModel.delegate = self
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
        foodImage.layer.cornerRadius = 10
    }
    
    func configureCell(food: Food?) {
        foodName.text = food?.name
        prepareBannerImage(with: food?.imageUrl)
    }
}
