//
//  ViewMoreCellViewModel.swift
//  Beybi
//
//  Created by Banu on 1.10.2024.
//

import Foundation

protocol ViewMoreCellViewModelProtocol {
    func viewDidLoad()
    func load()
}

protocol ViewMoreCellViewModelDelegate: AnyObject {
    func setUI()
    func configure(food: Food?)
    func prepareBannerImage(with urlString: String?)
}

final class ViewMoreCellViewModel {
    private weak var delegate: ViewMoreCellViewModelDelegate?
    private var food: Food?
    
    init(delegate: ViewMoreCellViewModelDelegate?, food: Food?) {
        self.delegate = delegate
        self.food = food
    }
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
