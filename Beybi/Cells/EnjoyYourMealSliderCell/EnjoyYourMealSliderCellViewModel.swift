//
//  EnjoyYourMealSliderCellViewModel.swift
//  Beybi
//
//  Created by Banu on 7.11.2024.
//

import Foundation

protocol EnjoyYourMealSliderCellViewModelProtocol {
    var delegate: EnjoyYourMealSliderCellViewModelDelegate? { get set }
    
    func load()
}

protocol EnjoyYourMealSliderCellViewModelDelegate: AnyObject {
    func configureCell(imageUrl: Eym?)
    func prepareBannerImage(with urlString: String?)
}

class EnjoyYourMealSliderCellViewModel {
    weak var delegate: EnjoyYourMealSliderCellViewModelDelegate?
    var imageUrl: Eym?
}

extension EnjoyYourMealSliderCellViewModel: EnjoyYourMealSliderCellViewModelProtocol {
    func load() {
        if let imageUrl = imageUrl {
            delegate?.configureCell(imageUrl: imageUrl)
        }
    }
}
