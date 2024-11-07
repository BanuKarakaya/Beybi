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
    func load()
}

protocol BabiesFavMiniCellViewModelDelegate: AnyObject {
    func setUI()
    func configure(food: Food?)
    func prepareBannerImage(with urlString: String?)
}

class BabiesFavMiniCellViewModel {
    weak var delegate: BabiesFavMiniCellViewModelDelegate?
    var food: Food?
   
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
