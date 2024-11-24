//
//  BabyInfoSliderCellViewModel.swift
//  Beybi
//
//  Created by Banu on 8.11.2024.
//

import Foundation

protocol BabyInfoSliderCellViewModelProtocol {
    var delegate: BabyInfoSliderCellViewModelDelegate? { get set }
    
    func load()
}

protocol BabyInfoSliderCellViewModelDelegate: AnyObject {
    func configureCell(info: Info?)
    func prepareBannerImage(with urlString: String?)
}

final class BabyInfoSliderCellViewModel {
    weak var delegate: BabyInfoSliderCellViewModelDelegate?
    var info: Info?
}

extension BabyInfoSliderCellViewModel: BabyInfoSliderCellViewModelProtocol {
    func load() {
        if let info = info {
            delegate?.configureCell(info: info)
        }
    }
}
