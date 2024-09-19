//
//  FoodSliderMiniCell.swift
//  Beybi
//
//  Created by Banu on 15.09.2024.
//

import UIKit

class FoodSliderMiniCell: UICollectionViewCell {

    @IBOutlet weak var foodName: UILabel!
    @IBOutlet weak var view: UIView!
    @IBOutlet weak var foodImage: UIImageView!
    
    private lazy var viewModel: FoodSliderMiniCellViewModelProtocol = FoodSliderMiniCellViewModel(delegate: self)
    
    override func awakeFromNib() {
        super.awakeFromNib()
        viewModel.viewDidLoad()
    }
}

extension FoodSliderMiniCell: FoodSliderMiniCellViewModelDelegate {
    func setUI() {
        self.layer.cornerRadius = 10
        foodImage.layer.cornerRadius = 10
    }
}
