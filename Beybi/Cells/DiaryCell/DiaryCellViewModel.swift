//
//  DiaryCellViewModel.swift
//  Beybi
//
//  Created by Banu on 23.12.2024.
//

import Foundation

protocol DiaryCellViewModelProtocol {
    func awakeFromNib()
    func load()
}

protocol DiaryCellViewModelDelegate: AnyObject {
    func prepareUI()
    func configureDiaryCell(diary: DemoEntity)
    func NSToUIImage(image: Data) -> Image
}

final class DiaryCellViewModel {
    private weak var delegate: DiaryCellViewModelDelegate?
    private var diary: DemoEntity?
    
    init(delegate: DiaryCellViewModelDelegate?, diary: DemoEntity?) {
        self.delegate = delegate
        self.diary = diary
    }
}

extension DiaryCellViewModel: DiaryCellViewModelProtocol {
    func load() {
        if let diary = diary {
            delegate?.configureDiaryCell(diary: diary)
        }
    }
    
    func awakeFromNib() {
        delegate?.prepareUI()
    }
}
