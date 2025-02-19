//
//  PhotoCellViewModel.swift
//  Beybi
//
//  Created by Banu on 15.02.2025.
//

import Foundation

protocol PhotoCellViewModelProtocol {
    func load()
}

protocol PhotoCellViewModelDelegate: AnyObject {
    func configure(image: uiImage)
}

class PhotoCellViewModel {
    private weak var delegate: PhotoCellViewModelDelegate?
    private var image: uiImage?
    
    init(delegate: PhotoCellViewModelDelegate?, image: uiImage?) {
        self.delegate = delegate
        self.image = image
    }
}

extension PhotoCellViewModel: PhotoCellViewModelProtocol {
    func load() {
        if let diaryImage = image {
            delegate?.configure(image: diaryImage)
        }
    }
}
