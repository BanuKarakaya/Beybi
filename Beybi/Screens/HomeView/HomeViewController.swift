//
//  HomeViewController.swift
//  Beybi
//
//  Created by Banu on 13.09.2024.
//

import UIKit
import FirebaseFirestore
import FirebaseStorage

class HomeViewController: UIViewController {

    @IBOutlet weak var homeCollectionView: UICollectionView!
    private lazy var viewModel: HomeViewModelProtocol = HomeViewModel(delegate: self)
    let firestore = Firestore.firestore()
   
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.viewDidLoad()
        readrecipe()
        
        NotificationCenter.default.addObserver(self, selector: #selector(navigateToDetail(_:)), name: .favSliderCellTapped, object: nil)
    }
    
    @objc func navigateToDetail(_ notification: NSNotification) {
        if let dict = notification.userInfo as NSDictionary? {
            if let selectedCell = dict["selectedCell"] as? Food {
                let detailVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "FoodDetailPageViewController") as! FoodDetailPageViewController
                let detailVM = FoodDetailPageViewModel(delegate: detailVC)
                detailVM.selectedFood = selectedCell
                detailVC.viewModel = detailVM
                navigationController?.pushViewController(detailVC, animated: true)
            }
        }
    }
    
    func readrecipe() {
        firestore.collection("soups").getDocuments { (querySnapshot, error) in
            if let error = error {
                print("Hata: \(error.localizedDescription)")
            } else {
                for document in querySnapshot!.documents {
                    let data = document.data()
                    let name = data["name"] as? String ?? "İsim yok"
                    let cookingTime = data["cooking time"] as? String ?? "Süre yok"
                    let recipe = data["recipe"] as? String ?? "Tarif yok"
                    
                    print("Çorba Adı: \(name)")
                    print("Pişirme Süresi: \(cookingTime)")
                    print("Tarif: \(recipe)")
                }
            }
        }
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
            let cell = collectionView.dequeCell(cellType: EnjoyYourMealCell.self, indexPath: indexPath)
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
            return CGSize(width: homeCollectionView.frame.width - 13, height: 50)
              case 1:
                  return CGSize(width: 380, height: 240)
              case 2:
                  return CGSize(width: homeCollectionView.frame.width - 13, height: 120)
              case 3:
                  return CGSize(width: 380, height: 255)
              default:
                  return CGSize(width: 100, height: 100)
              }
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
        homeCollectionView.register(cellType: EnjoyYourMealCell.self)
    }
}
