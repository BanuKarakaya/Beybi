//
//  ViewMoreCellViewModel.swift
//  Beybi
//
//  Created by Banu on 1.10.2024.
//

import Foundation

protocol ViewMoreCellViewModelProtocol {
    var delegate: ViewMoreCellViewModelDelegate? { get set }
    
    func viewDidLoad()
}

protocol ViewMoreCellViewModelDelegate: AnyObject {
    func setUI()
}

class ViewMoreCellViewModel {
    weak var delegate: ViewMoreCellViewModelDelegate?
    
    init(delegate: ViewMoreCellViewModelDelegate) {
        self.delegate = delegate
    }
}

extension ViewMoreCellViewModel: ViewMoreCellViewModelProtocol {
    func viewDidLoad() {
        delegate?.setUI()
    }
}
