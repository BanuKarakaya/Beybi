//
//  BabyInfloSliderCell.swift
//  Beybi
//
//  Created by Banu on 8.11.2024.
//

import UIKit

class BabyInfloSliderCell: UICollectionViewCell {

    @IBOutlet weak var infoImage: UIImageView!
    @IBOutlet weak var infoText: UILabel!
    
    var viewModel: BabyInfoSliderCellViewModelProtocol! {
        didSet {
            viewModel.delegate = self
            viewModel.load()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        infoText.numberOfLines = 0
    }
}

extension BabyInfloSliderCell: BabyInfoSliderCellViewModelDelegate {
    func prepareBannerImage(with urlString: String?) {
        if let imageUrlString = urlString, let url = URL(string:imageUrlString){
            infoImage.sd_setImage(with: url)
        }
    }
    
    func configureCell(info: Info?) {
        prepareBannerImage(with: info?.imageUrl)
        infoText.text = info?.infoText
    }
}
