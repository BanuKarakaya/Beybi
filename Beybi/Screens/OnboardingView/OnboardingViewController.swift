//
//  OnboardingViewController.swift
//  Beybi
//
//  Created by Banu on 23.11.2024.
//

import UIKit

final class OnboardingViewController: UIViewController {
    
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var onboardingButton: UIButton!
    @IBOutlet private weak var descriptionLabel: UILabel!
    var darkBeybiColor = UIColor(red: 113/255.0, green: 27/255.0, blue: 41/255.0, alpha: 1)
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
        descriptionLabel.numberOfLines = 0
        titleLabel.numberOfLines = 0
        onboardingButton.backgroundColor = darkBeybiColor
        onboardingButton.layer.cornerRadius = 8
    }
}
