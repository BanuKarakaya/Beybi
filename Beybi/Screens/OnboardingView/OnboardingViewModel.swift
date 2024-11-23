//
//  OnboardingViewModel.swift
//  Beybi
//
//  Created by Banu on 23.11.2024.
//

import Foundation

protocol OnboardingViewModelProtocol {
    var delegate: OnboardingViewModelDelegate? { get set }
    
    func viewDidLoad()
    func navigateToHomeVC()
}

protocol OnboardingViewModelDelegate: AnyObject {
    func prepareUI()
    func navigateToHomeVC()
}

class OnboardingViewModel {
    weak var delegate: OnboardingViewModelDelegate?
}

extension OnboardingViewModel: OnboardingViewModelProtocol {
    func navigateToHomeVC() {
        delegate?.navigateToHomeVC()
    }
    
    func viewDidLoad() {
        delegate?.prepareUI()
    }
}
