//
//  HomeViewController.swift
//  Beybi
//
//  Created by Banu on 13.09.2024.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var homeCollectionView: UICollectionView!
    
    private lazy var viewModel: HomeViewModelProtocol = HomeViewModel(delegate: self)
  
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.viewDidLoad()
    }
}

extension HomeViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        viewModel.numberOfSections()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.numberOfItemsInSection()
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
        viewModel.sizeForItemAt(section: indexPath.section)
    }
}

extension HomeViewController: HomeViewModelDelegate {
    func prepareUI() {
        if let tabBar = self.tabBarController?.tabBar {
           
                tabBar.layer.shadowColor = UIColor.black.cgColor
                tabBar.layer.shadowOpacity = 0.3
                tabBar.layer.shadowOffset = CGSize(width: 0, height: -0.5 )
                tabBar.layer.shadowRadius = 1
                tabBar.layer.masksToBounds = false
        }
    }
    
    func prepareCollectionView() {
        homeCollectionView.delegate = self
        homeCollectionView.dataSource = self
        
        homeCollectionView.register(cellType: BabiesAgeCell.self)
        homeCollectionView.register(cellType: DailyMenuCell.self)
        homeCollectionView.register(cellType: BabiesFavCell.self)
    }
}
