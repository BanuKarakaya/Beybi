//
//  HomeViewController.swift
//  Beybi
//
//  Created by Banu on 13.09.2024.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        if let tabBar = self.tabBarController?.tabBar {
           
                tabBar.layer.shadowColor = UIColor.black.cgColor
                tabBar.layer.shadowOpacity = 0.3
                tabBar.layer.shadowOffset = CGSize(width: 0, height: -0.5 )
                tabBar.layer.shadowRadius = 1
                tabBar.layer.masksToBounds = false
            }
    }


}

