//
//  DiaryCellViewModel.swift
//  Beybi
//
//  Created by Banu on 23.12.2024.
//

import Foundation

protocol DiaryCellViewModelProtocol {
    func awakeFromNib()
}

protocol DiaryCellViewModelDelegate: AnyObject {
    func prepareUI()
}

final class DiaryCellViewModel {
    private weak var delegate: DiaryCellViewModelDelegate?
    
    init(delegate: DiaryCellViewModelDelegate?) {
        self.delegate = delegate
    }
}

extension DiaryCellViewModel: DiaryCellViewModelProtocol {
    func awakeFromNib() {
        delegate?.prepareUI()
    }
}
