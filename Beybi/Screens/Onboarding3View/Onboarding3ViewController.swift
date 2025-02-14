//
//  Onboarding3ViewController.swift
//  Beybi
//
//  Created by Banu on 14.02.2025.
//

import UIKit

class Onboarding3ViewController: UIViewController {
    
    @IBOutlet weak var onboarding3Button: UIButton!
    private lazy var viewModel: Onboarding3ViewModelProtocol! = Onboarding3ViewModel(delegate: self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.viewDidLoad()
    }
    
    @IBAction func navigateToHome(_ sender: Any) {
        viewModel.navigateToHomeVC()
    }
}

extension Onboarding3ViewController: Onboarding3ViewModelDelegate {
    func navigateToHomeVC() {
        if let tabBarController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "UITabBarController") as? UITabBarController {
            tabBarController.modalPresentationStyle = .fullScreen
            self.present(tabBarController, animated: true, completion: nil)
        }
    }
    
    func prepareUI() {
        onboarding3Button.layer.cornerRadius = 16
    }
}
