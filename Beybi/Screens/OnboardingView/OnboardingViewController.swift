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
        if let tabBarController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "UITabBarController") as? UITabBarController {
            tabBarController.modalPresentationStyle = .fullScreen
            self.present(tabBarController, animated: true, completion: nil)
        }
    }
    
    func prepareUI() {
        onboardingButton.layer.cornerRadius = 16
    }
}
