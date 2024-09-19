//
//  BabiesFavMiniCell.swift
//  Beybi
//
//  Created by Banu on 18.09.2024.
//

import UIKit

class BabiesFavMiniCell: UICollectionViewCell {

    @IBOutlet weak var foodImage: UIImageView!
   
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = 10
        foodImage.layer.cornerRadius = 5
    }

}
