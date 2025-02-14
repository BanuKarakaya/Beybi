//
//  Onboarding3ViewModel.swift
//  Beybi
//
//  Created by Banu on 15.02.2025.
//

import Foundation

protocol Onboarding3ViewModelProtocol {
    func viewDidLoad()
    func navigateToHomeVC()
}

protocol Onboarding3ViewModelDelegate: AnyObject {
    func prepareUI()
    func navigateToHomeVC()
}

final class Onboarding3ViewModel {
    private weak var delegate: Onboarding3ViewModelDelegate?
    
    init(delegate: Onboarding3ViewModelDelegate?) {
        self.delegate = delegate
    }
}

extension Onboarding3ViewModel: Onboarding3ViewModelProtocol {
    func navigateToHomeVC() {
        delegate?.navigateToHomeVC()
    }
    
    func viewDidLoad() {
        delegate?.prepareUI()
    }
}

