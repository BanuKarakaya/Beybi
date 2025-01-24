//
//  BabyInfoSliderCellViewModel.swift
//  Beybi
//
//  Created by Banu on 8.11.2024.
//

import Foundation
import Food

protocol BabyInfoSliderCellViewModelProtocol {
    func load()
}

protocol BabyInfoSliderCellViewModelDelegate: AnyObject {
    func configureCell(info: Info?)
    func prepareBannerImage(with urlString: String?)
}

final class BabyInfoSliderCellViewModel {
    private weak var delegate: BabyInfoSliderCellViewModelDelegate?
    private var info: Info?
    
    init(delegate: BabyInfoSliderCellViewModelDelegate?, info: Info?) {
        self.delegate = delegate
        self.info = info
    }
}

extension BabyInfoSliderCellViewModel: BabyInfoSliderCellViewModelProtocol {
    func load() {
        if let info = info {
            delegate?.configureCell(info: info)
        }
    }
}
