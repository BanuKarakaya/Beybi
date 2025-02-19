//
//  CategoriesCellViewModel.swift
//  Beybi
//
//  Created by Banu on 11.02.2025.
//

import Foundation

protocol CategoriesCellViewModelProtocol {
    func viewDidLoad()
    func load()
}

protocol CategoriesCellViewModelDelegate: AnyObject {
    func setUI()
    func configure(text: String?, image: image)
    func prepareUIForSelectedState()
    func prepareUIForUnSelectedState()
}

class CategoriesCellViewModel {
    private weak var delegate: CategoriesCellViewModelDelegate?
    private var foodTypeText: String?
    private var foodTypeTImage: image?
    
    private var isSelected: Bool
    
    init(delegate: CategoriesCellViewModelDelegate?,
         foodTypeText: String?,
         isSelected: Bool,
         foodTypeImage: image) {
        self.delegate = delegate
        self.foodTypeText = foodTypeText
        self.isSelected = isSelected
        self.foodTypeTImage = foodTypeImage
    }
}

extension CategoriesCellViewModel: CategoriesCellViewModelProtocol {
    func viewDidLoad() {
        delegate?.setUI()
    }
    
    func load() {
        if let text = foodTypeText {
            if let foodImage = foodTypeTImage {
                delegate?.configure(text: text, image: foodImage)
            }
        }
        
        if isSelected {
            delegate?.prepareUIForSelectedState()
        } else {
            delegate?.prepareUIForUnSelectedState()
        }
    }
}
