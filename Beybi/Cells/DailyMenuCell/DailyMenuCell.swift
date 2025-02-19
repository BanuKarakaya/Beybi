//
//  DailyMenuCell.swift
//  Beybi
//
//  Created by Banu on 15.09.2024.
//


import UIKit
import CommonModule

final class DailyMenuCell: UICollectionViewCell {

    @IBOutlet private weak var menuCollectionView: UICollectionView!
    @IBOutlet private weak var breakfastButton: UIButton!
    @IBOutlet private weak var lunchButton: UIButton!
    @IBOutlet private weak var dinnerButton: UIButton!
    @IBOutlet weak var mainView: UIView!

    var isBreakfastButtonTapped = false
    var isLunchButtonTapped = false
    var isDinnerButtonTapped = false
    var beybiColor = UIColor(red: 237/255, green: 136/255, blue: 74/255, alpha: 1.0)
    var beybiColor2 = UIColor(red: 255/255, green: 243/255, blue: 219/255, alpha: 1.0)
    var beybiWhite = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1.0)
    var borderColor = UIColor(red: 237/255, green: 136/255, blue: 74/255, alpha: 0.25)

    private lazy var viewModel: DailyMenuCellViewModelProtocol = DailyMenuCellViewModel(delegate: self)
    
    override func awakeFromNib() {
        super.awakeFromNib()
        viewModel.viewDidLoad()
    }
    
    @IBAction func breakfastButtonTapped(_ sender: Any) {
        isBreakfastButtonTapped = true
        isLunchButtonTapped = false
        isDinnerButtonTapped = false
        
        breakfastButton.backgroundColor = beybiColor
        breakfastButton.titleLabel?.tintColor = beybiWhite
        breakfastButton.layer.borderColor = borderColor.cgColor
        lunchButton.layer.borderWidth = 0.7
        lunchButton.layer.borderColor = borderColor.cgColor
        lunchButton.layer.cornerRadius = 8
        lunchButton.backgroundColor = beybiColor2
        lunchButton.titleLabel?.tintColor = beybiColor
        dinnerButton.layer.borderWidth = 0.7
        dinnerButton.layer.borderColor = borderColor.cgColor
        dinnerButton.layer.cornerRadius = 8
        dinnerButton.backgroundColor = beybiColor2
        dinnerButton.titleLabel?.tintColor = beybiColor
        
        reloadData()
    }
    
    @IBAction func lunchButtonTapped(_ sender: Any) {
        isBreakfastButtonTapped = false
        isLunchButtonTapped = true
        isDinnerButtonTapped = false
        
        lunchButton.backgroundColor = beybiColor
        lunchButton.titleLabel?.tintColor = beybiWhite
        lunchButton.layer.borderColor = borderColor.cgColor
        breakfastButton.layer.borderWidth = 0.7
        breakfastButton.layer.borderColor = borderColor.cgColor
        breakfastButton.layer.cornerRadius = 8
        breakfastButton.backgroundColor = beybiColor2
        breakfastButton.titleLabel?.tintColor = beybiColor
        dinnerButton.layer.borderWidth = 0.7
        dinnerButton.layer.borderColor = borderColor.cgColor
        dinnerButton.layer.cornerRadius = 8
        dinnerButton.backgroundColor = beybiColor2
        dinnerButton.titleLabel?.tintColor = beybiColor
        
        reloadData()
    }
    
    @IBAction func dinnerButtonTapped(_ sender: Any) {
        isBreakfastButtonTapped = false
        isLunchButtonTapped = false
        isDinnerButtonTapped = true
        
        dinnerButton.backgroundColor = beybiColor
        dinnerButton.titleLabel?.textColor = beybiWhite
        dinnerButton.layer.borderColor = borderColor.cgColor
        dinnerButton.titleLabel?.tintColor = beybiWhite
        breakfastButton.layer.borderWidth = 0.7
        breakfastButton.layer.borderColor = borderColor.cgColor
        breakfastButton.layer.cornerRadius = 8
        breakfastButton.backgroundColor = beybiColor2
        breakfastButton.titleLabel?.tintColor = beybiColor
        lunchButton.layer.borderWidth = 0.7
        lunchButton.layer.borderColor = borderColor.cgColor
        lunchButton.layer.cornerRadius = 8
        lunchButton.backgroundColor = beybiColor2
        lunchButton.titleLabel?.tintColor = beybiColor
        
        reloadData()
    }
}

extension DailyMenuCell: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.didSelectItemAt(index: indexPath.item, breakfastTapped: isBreakfastButtonTapped, lunchTapped: isLunchButtonTapped, dinnerTapped: isDinnerButtonTapped)
        viewModel.sendSelectedCell()
    }
}

extension DailyMenuCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.numberOfItemsInSection(breakfastTapped: isBreakfastButtonTapped, lunchTapped: isLunchButtonTapped, dinnerTapped: isDinnerButtonTapped)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeCell(cellType: FoodCell.self, indexPath: indexPath)
        if let food = viewModel.foodAtIndex(index: indexPath.item, breakfastTapped: isBreakfastButtonTapped, lunchTapped: isLunchButtonTapped, dinnerTapped: isDinnerButtonTapped) {
            let cellViewModel = FoodCellViewModel(delegate: cell, food: food)
            cell.viewModel = cellViewModel
        }
        return cell
    }
}

extension DailyMenuCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        .init(width: 220, height: 303)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 0 )
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 16
    }
}

extension DailyMenuCell: DailyMenuCellViewModelDelegate {
    func reloadData() {
        menuCollectionView.reloadData()
    }
    
    func prepareUI() {
        dinnerButton.layer.cornerRadius = 8
        lunchButton.layer.borderWidth = 0.7
        lunchButton.layer.borderColor = borderColor.cgColor
        lunchButton.layer.cornerRadius = 8
        breakfastButton.layer.borderWidth = 0.7
        breakfastButton.layer.borderColor = borderColor.cgColor
        breakfastButton.layer.cornerRadius = 8
    }
    
    func prepareCollectionView() {
        menuCollectionView.delegate = self
        menuCollectionView.dataSource = self
        menuCollectionView.showsHorizontalScrollIndicator = false
        
        menuCollectionView.register(cellType: FoodCell.self)
    }
 }
