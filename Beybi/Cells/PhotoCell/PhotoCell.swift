//
//  PhotoCell.swift
//  Beybi
//
//  Created by Banu on 31.01.2025.
//

import UIKit

typealias uiImage = UIImage

class PhotoCell: UICollectionViewCell {

    @IBOutlet weak var diaryPhoto: UIImageView!
    
    var viewModel: PhotoCellViewModelProtocol! {
        didSet {
             viewModel.load()
         }
     }
}

extension PhotoCell: PhotoCellViewModelDelegate {
    func configure(image: uiImage) {
        diaryPhoto.image = image
    }
}

