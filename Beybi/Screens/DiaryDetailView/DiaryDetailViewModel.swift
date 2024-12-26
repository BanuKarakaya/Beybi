//
//  DiaryDetailViewModel.swift
//  Beybi
//
//  Created by Banu on 26.12.2024.
//

import Foundation

protocol DiaryDetailViewModelProtocol {
    func viewDidLoad()
}

protocol DiaryDetailViewModelDelegate: AnyObject {
    func prepareUI()
}

final class DiaryDetailViewModel {
    private weak var delegate: DiaryDetailViewModelDelegate?
    
    init(delegate: DiaryDetailViewModelDelegate?) {
        self.delegate = delegate
    }
}

extension DiaryDetailViewModel: DiaryDetailViewModelProtocol {
    func viewDidLoad() {
        delegate?.prepareUI()
    }
}
