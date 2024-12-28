//
//  EditViewModel.swift
//  Beybi
//
//  Created by Banu on 23.12.2024.
//

import Foundation
 
protocol EditViewModelProtocol {
    func viewDidLoad()
    func addPhotoButtonTappedd()
    func openCameraa()
    func openPhotoLibraryy()
}

protocol EditViewModelDelegate: AnyObject {
    func prepareUI()
    func addPhotoButtonTapped()
    func openCamera()
    func openPhotoLibrary()
}

final class EditViewModel {
    private weak var delegate: EditViewModelDelegate?
    
    init(delegate: EditViewModelDelegate?) {
        self.delegate = delegate
    }
}
 
extension EditViewModel: EditViewModelProtocol {
    func openPhotoLibraryy() {
        delegate?.openPhotoLibrary()
    }
    
    func openCameraa() {
        delegate?.openCamera()
    }
    
    func addPhotoButtonTappedd() {
        delegate?.addPhotoButtonTapped()
    }
    
    func viewDidLoad() {
        delegate?.prepareUI()
    }
}
