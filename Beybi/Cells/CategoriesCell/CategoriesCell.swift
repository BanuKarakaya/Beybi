//
//  CategoriesCell.swift
//  Beybi
//
//  Created by Banu on 26.01.2025.
//

import UIKit

class CategoriesCell: UICollectionViewCell {

    var beybiColor = UIColor(red: 237/255, green: 136/255, blue: 74/255, alpha: 1.0)
    
    @IBOutlet weak var typeLabel: UILabel!
    
   
    var viewModel: CategoriesCellViewModelProtocol! {
        didSet {
            viewModel.load()
            viewModel.viewDidLoad()
        }
    }
}

extension CategoriesCell: CategoriesCellViewModelDelegate {
    func configure(text: String?) {
        typeLabel.text = text
    }
    
    func setUI() {
        self.layer.cornerRadius = 8
//        self.layer.borderWidth = 0.7
//        self.layer.borderColor = beybiColor.cgColor
    }
}
