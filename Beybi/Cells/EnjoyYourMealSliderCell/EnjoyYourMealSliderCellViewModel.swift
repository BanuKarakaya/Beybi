//
//  EnjoyYourMealSliderCellViewModel.swift
//  Beybi
//
//  Created by Banu on 7.11.2024.
//

import Foundation

protocol EnjoyYourMealSliderCellViewModelProtocol {
    func load()
}

protocol EnjoyYourMealSliderCellViewModelDelegate: AnyObject {
    func configureCell(imageUrl: Eym?)
    func prepareBannerImage(with urlString: String?)
}

final class EnjoyYourMealSliderCellViewModel {
    private weak var delegate: EnjoyYourMealSliderCellViewModelDelegate?
    private var imageUrl: Eym?
    
    init(delegate: EnjoyYourMealSliderCellViewModelDelegate?, imageUrl: Eym?) {
        self.delegate = delegate
        self.imageUrl = imageUrl
    }
}

extension EnjoyYourMealSliderCellViewModel: EnjoyYourMealSliderCellViewModelProtocol {
    func load() {
        if let imageUrl = imageUrl {
            delegate?.configureCell(imageUrl: imageUrl)
        }
    }
}
