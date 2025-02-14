//
//  OnboardingViewController.swift
//  Beybi
//
//  Created by Banu on 23.11.2024.
//

import UIKit

final class OnboardingViewController: UIViewController {
    
    @IBOutlet private weak var onboardingButton: UIButton!
    private lazy var viewModel: OnboardingViewModelProtocol! = OnboardingViewModel(delegate: self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.viewDidLoad()
    }
    
    @IBAction func onboardingButtonTapped(_ sender: Any) {
        viewModel.navigateToHomeVC()
    }
}

extension OnboardingViewController: OnboardingViewModelDelegate {
    func navigateToHomeVC() {
         let onboarding2Controller = UIStoryboard(name: "OnboardingStoryboard", bundle: nil).instantiateViewController(withIdentifier: "Onboarding2ViewController")
         navigationController?.pushViewController(onboarding2Controller, animated: true)
    }
    
    func prepareUI() {
        onboardingButton.layer.cornerRadius = 16
    }
}
