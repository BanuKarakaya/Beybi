//
//  ViewMoreCell.swift
//  Beybi
//
//  Created by Banu on 30.09.2024.
//

import UIKit
import SDWebImage

final class ViewMoreCell: UICollectionViewCell {

    @IBOutlet private weak var foodImage: UIImageView!
    @IBOutlet private weak var foodName: UILabel!
    @IBOutlet private weak var typeName: UILabel!
    @IBOutlet private weak var timeLabel: UILabel!
    @IBOutlet private weak var typeView: UIView!
   
    var viewModel: ViewMoreCellViewModelProtocol! {
        didSet {
            viewModel.delegate = self
            viewModel.load()
            viewModel.viewDidLoad()
        }
    }
}

extension ViewMoreCell: ViewMoreCellViewModelDelegate {
    func prepareBannerImage(with urlString: String?) {
        if let imageUrlString = urlString, let url = URL(string:imageUrlString){
            foodImage.sd_setImage(with: url)
        }
    }
    
    func configure(food: Food?) {
        foodName.text = food?.name
        typeName.text = food?.type
        timeLabel.text = food?.cookingTime
        prepareBannerImage(with: food?.imageUrl)
        
    }
    
    func setUI() {
        self.layer.cornerRadius = 10
        foodImage.layer.cornerRadius = 8
        typeView.layer.cornerRadius = 5
    }
    
    
    
}
