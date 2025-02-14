//
//  Onboarding2ViewController.swift
//  Beybi
//
//  Created by Banu on 14.02.2025.
//

import UIKit

class Onboarding2ViewController: UIViewController {

    @IBOutlet weak var onboarding2Button: UIButton!
    private lazy var viewModel: Onboarding2ViewModelProtocol! = Onboarding2ViewModel(delegate: self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.viewDidLoad()
    }
    
    @IBAction func navigateToThird(_ sender: Any) {
        viewModel.navigateToHomeVC()
    }
}

extension Onboarding2ViewController: Onboarding2ViewModelDelegate {
    func navigateToHomeVC() {
         let onboarding3Controller = UIStoryboard(name: "OnboardingStoryboard", bundle: nil).instantiateViewController(withIdentifier: "Onboarding3ViewController")
         navigationController?.pushViewController(onboarding3Controller, animated: true)
    }
    
    func prepareUI() {
        onboarding2Button.layer.cornerRadius = 16
    }
}
