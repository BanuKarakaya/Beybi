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
    func configure(text: String?)
}

class CategoriesCellViewModel {
    private weak var delegate: CategoriesCellViewModelDelegate?
    private var foodTypeText: String?
    
    init(delegate: CategoriesCellViewModelDelegate?, foodTypeText: String?) {
        self.delegate = delegate
        self.foodTypeText = foodTypeText
    }
}

extension CategoriesCellViewModel: CategoriesCellViewModelProtocol {
    func viewDidLoad() {
        delegate?.setUI()
    }
    
    func load() {
        if let text = foodTypeText {
            delegate?.configure(text: text)
        }
    }
}
