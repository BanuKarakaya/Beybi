//
//  BabiesFavMiniCellViewModel.swift
//  Beybi
//
//  Created by Banu on 19.09.2024.
//

import Foundation

protocol BabiesFavMiniCellViewModelProtocol {
    var delegate: BabiesFavMiniCellViewModelDelegate? { get set }
    
    func viewDidLoad()
}

protocol BabiesFavMiniCellViewModelDelegate: AnyObject {
    func setUI()
}

class BabiesFavMiniCellViewModel {
    weak var delegate: BabiesFavMiniCellViewModelDelegate?
    
    init(delegate: BabiesFavMiniCellViewModelDelegate) {
        self.delegate = delegate
    }
}

extension BabiesFavMiniCellViewModel: BabiesFavMiniCellViewModelProtocol {
    func viewDidLoad() {
        delegate?.setUI()
    }
}
