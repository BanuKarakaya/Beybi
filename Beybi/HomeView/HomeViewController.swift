//
//  HomeViewController.swift
//  Beybi
//
//  Created by Banu on 13.09.2024.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var homeCollectionView: UICollectionView!
  
    override func viewDidLoad() {
        super.viewDidLoad()
        homeCollectionView.delegate = self
        homeCollectionView.dataSource = self
        
        homeCollectionView.register(cellType: BabiesAgeCell.self)
        homeCollectionView.register(cellType: DailyMenuCell.self)
        homeCollectionView.register(cellType: BabiesFavCell.self)
        
        if let tabBar = self.tabBarController?.tabBar {
           
                tabBar.layer.shadowColor = UIColor.black.cgColor
                tabBar.layer.shadowOpacity = 0.3
                tabBar.layer.shadowOffset = CGSize(width: 0, height: -0.5 )
                tabBar.layer.shadowRadius = 1
                tabBar.layer.masksToBounds = false
        }
    }
}

extension HomeViewController: UICollectionViewDelegate {
    
}

extension HomeViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            let cell = collectionView.dequeCell(cellType: BabiesAgeCell.self, indexPath: indexPath)
            return cell
        } else if indexPath.section == 1 {
            let cell = collectionView.dequeCell(cellType: DailyMenuCell.self, indexPath: indexPath)
            return cell
        } else if indexPath.section == 2 {
            let cell = collectionView.dequeCell(cellType: BabiesAgeCell.self, indexPath: indexPath)
            return cell
        } else {
            let cell = collectionView.dequeCell(cellType: BabiesFavCell.self, indexPath: indexPath)
            return cell
        }
    }
}
extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch indexPath.section {
              case 0:
                  return CGSize(width: 380, height: 140)
              case 1:
                  return CGSize(width: 380, height: 240)
              case 2:
                  return CGSize(width: 380, height: 40)
              case 3:
                  return CGSize(width: 380, height: 240)
              default:
                  return CGSize(width: 100, height: 100)
              }
    }
}
