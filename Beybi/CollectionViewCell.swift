//
//  CollectionViewCell.swift
//  Beybi
//
//  Created by Banu on 15.09.2024.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var foodName: UILabel!
    @IBOutlet weak var view: UIView!
    @IBOutlet weak var foodImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = 10
        foodImage.layer.cornerRadius = 10
    }

}
