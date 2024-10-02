//
//  ViewMoreCell.swift
//  Beybi
//
//  Created by Banu on 30.09.2024.
//

import UIKit

class ViewMoreCell: UICollectionViewCell {

    @IBOutlet weak var foodImage: UIImageView!
    private lazy var viewModel: ViewMoreCellViewModelProtocol = ViewMoreCellViewModel(delegate: self)
    
    override func awakeFromNib() {
        super.awakeFromNib()
        viewModel.viewDidLoad()
    }
}

extension ViewMoreCell: ViewMoreCellViewModelDelegate {
    func setUI() {
        foodImage.layer.cornerRadius = 10
    }
    
    
}
