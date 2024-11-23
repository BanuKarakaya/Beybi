//
//  OnboardingViewController.swift
//  Beybi
//
//  Created by Banu on 23.11.2024.
//

import UIKit

class OnboardingViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var onboardingButton: UIButton!
    @IBOutlet weak var descriptionLabel: UILabel!
    var darkBeybiColor = UIColor(red: 113/255.0, green: 27/255.0, blue: 41/255.0, alpha: 1)
    var viewModel: OnboardingViewModelProtocol! = OnboardingViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        viewModel.viewDidLoad()
    }
    
    @IBAction func onboardingButtonTapped(_ sender: Any) {
        viewModel.navigateToHomeVC()
    }
}

extension OnboardingViewController: OnboardingViewModelDelegate {
    func navigateToHomeVC() {
        if let navigationController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "navigationController") as? UINavigationController {
            navigationController.modalPresentationStyle = .fullScreen
            self.present(navigationController, animated: true, completion: nil)
        }
    }
    
    func prepareUI() {
        descriptionLabel.numberOfLines = 0
        titleLabel.numberOfLines = 0
        onboardingButton.backgroundColor = darkBeybiColor
        onboardingButton.layer.cornerRadius = 8
    }
}
