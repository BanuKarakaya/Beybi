//
//  EnjoyYourMealSliderCell.swift
//  Beybi
//
//  Created by Banu on 7.11.2024.
//

import UIKit

final class EnjoyYourMealSliderCell: UICollectionViewCell {
    @IBOutlet private weak var enjoyYourMealImage: UIImageView!
    
    var viewModel: EnjoyYourMealSliderCellViewModelProtocol! {
        didSet {
            viewModel.load()
        }
    }
}

extension EnjoyYourMealSliderCell: EnjoyYourMealSliderCellViewModelDelegate {
    func configureCell(imageUrl: Eym?) {
        prepareBannerImage(with: imageUrl?.imageUrl)
    }
    
    func prepareBannerImage(with urlString: String?) {
        if let imageUrlString = urlString, let url = URL(string:imageUrlString){
            enjoyYourMealImage.sd_setImage(with: url)
        }
    }
}
