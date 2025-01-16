//
//  BabiesFavMiniCellViewModel.swift
//  Beybi
//
//  Created by Banu on 19.09.2024.
//

import Foundation

protocol BabiesFavMiniCellViewModelProtocol {
    func viewDidLoad()
    func load()
}

protocol BabiesFavMiniCellViewModelDelegate: AnyObject {
    func setUI()
    func configure(food: Food?)
    func prepareBannerImage(with urlString: String?)
}

final class BabiesFavMiniCellViewModel {
    private weak var delegate: BabiesFavMiniCellViewModelDelegate?
    private var food: Food?
   
    init(delegate: BabiesFavMiniCellViewModelDelegate?, food: Food?) {
        self.delegate = delegate
        self.food = food
    }
}

extension BabiesFavMiniCellViewModel: BabiesFavMiniCellViewModelProtocol {
    func load() {
        if let food = food {
            delegate?.configure(food: food)
        }
    }
    
    func viewDidLoad() {
        delegate?.setUI()
    }
}
