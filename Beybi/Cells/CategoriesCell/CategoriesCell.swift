//
//  CategoriesCell.swift
//  Beybi
//
//  Created by Banu on 26.01.2025.
//

import UIKit
typealias image = UIImage

class CategoriesCell: UICollectionViewCell {

    var beybiColor = UIColor(red: 237/255, green: 136/255, blue: 74/255, alpha: 1.0)
    let color = UIColor(red: 0x3D / 255.0, green: 0x28 / 255.0, blue: 0x20 / 255.0, alpha: 1.0)
    
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var typeImage: UIImageView!
    
    var viewModel: CategoriesCellViewModelProtocol! {
        didSet {
            viewModel.load()
            viewModel.viewDidLoad()
        }
    }
}

extension CategoriesCell: CategoriesCellViewModelDelegate {
    func configure(text: String?, image: image) {
        typeLabel.text = text
        typeImage.image = image
    }
  
    func setUI() {
        self.layer.cornerRadius = 8
//        self.layer.borderWidth = 0.7
//        self.layer.borderColor = beybiColor.cgColor
    }
    
    func prepareUIForSelectedState() {
        self.layer.cornerRadius = 8
        self.layer.borderWidth = 1.2
        self.layer.borderColor = beybiColor.cgColor
        self.typeLabel.textColor = beybiColor
    }
    
    func prepareUIForUnSelectedState() {
        self.layer.cornerRadius = 8
        self.layer.borderWidth = 0
        self.typeLabel.textColor = color
    }
}
