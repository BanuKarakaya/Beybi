//
//  DiaryCell.swift
//  Beybi
//
//  Created by Banu on 23.12.2024.
//

import UIKit

class DiaryCell: UICollectionViewCell {

    var viewModel: DiaryCellViewModelProtocol! {
        didSet {
            viewModel.awakeFromNib()
        }
    }
}

extension DiaryCell: DiaryCellViewModelDelegate {
    func prepareUI() {
        self.layer.cornerRadius = 10
    }
}
