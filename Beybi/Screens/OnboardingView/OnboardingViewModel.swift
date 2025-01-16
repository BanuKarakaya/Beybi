//
//  OnboardingViewModel.swift
//  Beybi
//
//  Created by Banu on 23.11.2024.
//

import Foundation

protocol OnboardingViewModelProtocol {
    func viewDidLoad()
    func navigateToHomeVC()
}

protocol OnboardingViewModelDelegate: AnyObject {
    func prepareUI()
    func navigateToHomeVC()
}

final class OnboardingViewModel {
    private weak var delegate: OnboardingViewModelDelegate?
    
    init(delegate: OnboardingViewModelDelegate?) {
        self.delegate = delegate
    }
}

extension OnboardingViewModel: OnboardingViewModelProtocol {
    func navigateToHomeVC() {
        delegate?.navigateToHomeVC()
    }
    
    func viewDidLoad() {
        delegate?.prepareUI()
    }
}
