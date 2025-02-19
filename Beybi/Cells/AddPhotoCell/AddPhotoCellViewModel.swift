//
//  AddPhotoCellViewModel.swift
//  Beybi
//
//  Created by Banu on 15.02.2025.
//

import Foundation

protocol AddPhotoCellViewModelProtocol {
    func load()
}

protocol AddPhotoCellViewModelDelegate: AnyObject {
    func configure(image: uiimage)
    func setUI()
}

class AddPhotoCellViewModel {
    private weak var delegate: AddPhotoCellViewModelDelegate?
    var image: uiimage?
    
    init(delegate: AddPhotoCellViewModelDelegate?, image: uiimage?) {
        self.delegate = delegate
        self.image = image
    }
}

extension AddPhotoCellViewModel: AddPhotoCellViewModelProtocol {
    func load() {
        if let diaryImage = image {
            delegate?.configure(image: diaryImage)
        }
        delegate?.setUI()
    }
}
