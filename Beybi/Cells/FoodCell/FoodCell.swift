//
//  FoodCell.swift
//  Beybi
//
//  Created by Banu on 15.09.2024.
//

import UIKit
import Food

final class FoodCell: UICollectionViewCell {

    
    @IBOutlet weak var foodName: UILabel!
    @IBOutlet private weak var foodImage: UIImageView!
    
    var viewModel: FoodCellViewModelProtocol! {
        didSet {
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
        prepareBannerImage(with: food?.imageUrl)
    }
    
    func setUI() {
        self.layer.cornerRadius = 10
        foodImage.layer.cornerRadius = 10
    }
}
