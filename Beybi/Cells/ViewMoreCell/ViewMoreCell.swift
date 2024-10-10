//
//  ViewMoreCell.swift
//  Beybi
//
//  Created by Banu on 30.09.2024.
//

import UIKit

class ViewMoreCell: UICollectionViewCell {

    @IBOutlet weak var foodImage: UIImageView!
    @IBOutlet weak var foodName: UILabel!
    @IBOutlet weak var typeName: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var typeView: UIView!
   
    private lazy var viewModel: ViewMoreCellViewModelProtocol = ViewMoreCellViewModel(delegate: self)
    
    override func awakeFromNib() {
        super.awakeFromNib()
        viewModel.viewDidLoad()
    }
}

extension ViewMoreCell: ViewMoreCellViewModelDelegate {
    func setUI() {
        self.layer.cornerRadius = 10
        foodImage.layer.cornerRadius = 8
        typeView.layer.cornerRadius = 5
    }
    
    
}
