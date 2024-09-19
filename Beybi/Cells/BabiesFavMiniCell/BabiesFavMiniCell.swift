//
//  BabiesFavMiniCell.swift
//  Beybi
//
//  Created by Banu on 18.09.2024.
//

import UIKit

class BabiesFavMiniCell: UICollectionViewCell {

    @IBOutlet weak var foodImage: UIImageView!
    
    private lazy var viewModel: BabiesFavMiniCellViewModelProtocol = BabiesFavMiniCellViewModel(delegate: self)
   
    override func awakeFromNib() {
        super.awakeFromNib()
        viewModel.viewDidLoad()
    }
}

extension BabiesFavMiniCell: BabiesFavMiniCellViewModelDelegate {
    func setUI() {
        self.layer.cornerRadius = 10
        foodImage.layer.cornerRadius = 5
    }
}
