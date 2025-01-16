//
//  BabiesFavMiniCell.swift
//  Beybi
//
//  Created by Banu on 18.09.2024.
//

import UIKit

final class BabiesFavMiniCell: UICollectionViewCell {

    @IBOutlet private weak var foodImage: UIImageView!
    @IBOutlet private weak var foodNameLabel: UILabel!
    @IBOutlet private weak var typeView: UIView!
    @IBOutlet private weak var typeLabel: UILabel!
    @IBOutlet private weak var cookingTimeLabel: UILabel!
    
     var viewModel: BabiesFavMiniCellViewModelProtocol! {
        didSet {
            viewModel.load()
            viewModel.viewDidLoad()
        }
    }
}

extension BabiesFavMiniCell: BabiesFavMiniCellViewModelDelegate {
    func prepareBannerImage(with urlString: String?) {
        if let imageUrlString = urlString, let url = URL(string:imageUrlString){
            foodImage.sd_setImage(with: url)
        }
    }
    
    func configure(food: Food?) {
        foodNameLabel.text = food?.name
        typeLabel.text = food?.type
        cookingTimeLabel.text = food?.cookingTime
        prepareBannerImage(with: food?.imageUrl)
    }
    
    func setUI() {
        self.layer.cornerRadius = 10
        foodImage.layer.cornerRadius = 5
        typeView.layer.cornerRadius = 3
    }
}
