//
//  FoodCell.swift
//  Beybi
//
//  Created by Banu on 15.09.2024.
//

import UIKit

class FoodCell: UICollectionViewCell {

    @IBOutlet weak var foodName: UILabel!
    @IBOutlet weak var typeView: UIButton!
    @IBOutlet weak var typeName: UILabel!
   
    private lazy var viewModel: FoodCellViewModelProtocol = FoodCellViewModel(delegate: self)
    
    override func awakeFromNib() {
        super.awakeFromNib()
        viewModel.viewDidLoad()
    }
}

extension FoodCell: FoodCellViewModelDelegate {
    func setUI() {
        self.layer.cornerRadius = 10
        typeView.layer.cornerRadius = 3
    }
}
