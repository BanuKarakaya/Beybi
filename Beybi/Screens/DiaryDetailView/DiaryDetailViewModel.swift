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
    func configure(selectedDiary: DemoEntity?)
    func NSToUIImage(image: Data) -> Image
    func prepareCollectionView()
}

final class DiaryDetailViewModel {
    private weak var delegate: DiaryDetailViewModelDelegate?
    var selectedDiary: DemoEntity?
    
    init(delegate: DiaryDetailViewModelDelegate?) {
        self.delegate = delegate
    }
}

extension DiaryDetailViewModel: DiaryDetailViewModelProtocol {
    func viewDidLoad() {
        delegate?.prepareUI()
        delegate?.configure(selectedDiary: selectedDiary)
        delegate?.prepareCollectionView()
    }
}
