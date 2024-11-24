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
    func load()
}

protocol ViewMoreCellViewModelDelegate: AnyObject {
    func setUI()
    func configure(food: Food?)
    func prepareBannerImage(with urlString: String?)
}

final class ViewMoreCellViewModel {
    weak var delegate: ViewMoreCellViewModelDelegate?
    var food: Food?
}

extension ViewMoreCellViewModel: ViewMoreCellViewModelProtocol {
    func load() {
        if let food = food {
            delegate?.configure(food: food)
        }
    }
    
    func viewDidLoad() {
        delegate?.setUI()
    }
}
