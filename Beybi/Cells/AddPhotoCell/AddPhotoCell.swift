//
//  AddPhotoCell.swift
//  Beybi
//
//  Created by Banu on 13.02.2025.
//

import UIKit

typealias uiimage = UIImage

class AddPhotoCell: UICollectionViewCell {

    @IBOutlet weak var diaryPhoto: UIImageView!

   var viewModel: AddPhotoCellViewModelProtocol! {
       didSet {
            viewModel.load()
        }
    }
}

extension AddPhotoCell: AddPhotoCellViewModelDelegate {
    func setUI() {
        self.layer.cornerRadius = 10
    }
    
    func configure(image: uiimage) {
        diaryPhoto.image = image
    }
}
