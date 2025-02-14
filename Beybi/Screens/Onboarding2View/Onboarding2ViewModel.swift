//
//  Onboarding2ViewModel.swift
//  Beybi
//
//  Created by Banu on 15.02.2025.
//

import Foundation

protocol Onboarding2ViewModelProtocol {
    func viewDidLoad()
    func navigateToHomeVC()
}

protocol Onboarding2ViewModelDelegate: AnyObject {
    func prepareUI()
    func navigateToHomeVC()
}

final class Onboarding2ViewModel {
    private weak var delegate: Onboarding2ViewModelDelegate?
    
    init(delegate: Onboarding2ViewModelDelegate?) {
        self.delegate = delegate
    }
}

extension Onboarding2ViewModel: Onboarding2ViewModelProtocol {
    func navigateToHomeVC() {
        delegate?.navigateToHomeVC()
    }
    
    func viewDidLoad() {
        delegate?.prepareUI()
    }
}

