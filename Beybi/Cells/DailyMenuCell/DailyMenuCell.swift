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
    @IBOutlet private weak var breakfastButtonLabel: UILabel!
    @IBOutlet private weak var lunchButtonLabel: UILabel!
    @IBOutlet private weak var dinnerButtonLabel: UILabel!
    var isBreakfastButtonTapped = false
    var isLunchButtonTapped = false
    var isDinnerButtonTapped = false
    var beybiColor = UIColor(red: 162/255.0, green: 10/255.0, blue: 30/255.0, alpha: 0.9)


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
        breakfastButtonLabel.textColor = .white
        breakfastButton.layer.borderColor = beybiColor.cgColor
        lunchButton.layer.borderWidth = 0.5
        lunchButton.layer.borderColor = UIColor.systemGray2.cgColor
        lunchButton.layer.cornerRadius = 6
        lunchButton.backgroundColor = .systemGray6
        lunchButtonLabel.textColor = .black
        dinnerButton.layer.borderWidth = 0.5
        dinnerButton.layer.borderColor = UIColor.systemGray2.cgColor
        dinnerButton.layer.cornerRadius = 6
        dinnerButton.backgroundColor = .systemGray6
        dinnerButtonLabel.textColor = .black
        reloadData()
    }
    
    @IBAction func lunchButtonTapped(_ sender: Any) {
        isBreakfastButtonTapped = false
        isLunchButtonTapped = true
        isDinnerButtonTapped = false
        
        lunchButton.backgroundColor = beybiColor
        lunchButtonLabel.textColor = .white
        lunchButton.layer.borderColor = beybiColor.cgColor
        breakfastButton.layer.borderWidth = 0.5
        breakfastButton.layer.borderColor = UIColor.systemGray2.cgColor
        breakfastButton.layer.cornerRadius = 6
        breakfastButton.backgroundColor = .systemGray6
        breakfastButtonLabel.textColor = .black
        dinnerButton.layer.borderWidth = 0.5
        dinnerButton.layer.borderColor = UIColor.systemGray2.cgColor
        dinnerButton.layer.cornerRadius = 6
        dinnerButton.backgroundColor = .systemGray6
        dinnerButtonLabel.textColor = .black
        reloadData()
    }
    
    @IBAction func dinnerButtonTapped(_ sender: Any) {
        isBreakfastButtonTapped = false
        isLunchButtonTapped = false
        isDinnerButtonTapped = true
        
        dinnerButton.backgroundColor = beybiColor
        dinnerButtonLabel.textColor = .white
        dinnerButton.layer.borderColor = beybiColor.cgColor
        breakfastButton.layer.borderWidth = 0.5
        breakfastButton.layer.borderColor = UIColor.systemGray2.cgColor
        breakfastButton.layer.cornerRadius = 6
        breakfastButton.backgroundColor = .systemGray6
        breakfastButtonLabel.textColor = .black
        lunchButton.layer.borderWidth = 0.5
        lunchButton.layer.borderColor = UIColor.systemGray2.cgColor
        lunchButton.layer.cornerRadius = 6
        lunchButton.backgroundColor = .systemGray6
        lunchButtonLabel.textColor = .black
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
        .init(width: (menuCollectionView.frame.width - 20) / 3, height: 170)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 2, left: 6, bottom: 12, right: 10 )
    }
}

extension DailyMenuCell: DailyMenuCellViewModelDelegate {
    func reloadData() {
        menuCollectionView.reloadData()
    }
    
    func prepareUI() {
        dinnerButton.layer.cornerRadius = 6
        lunchButton.layer.borderWidth = 0.5
        lunchButton.layer.borderColor = UIColor.systemGray2.cgColor
        lunchButton.layer.cornerRadius = 6
        breakfastButton.layer.borderWidth = 0.5
        breakfastButton.layer.borderColor = UIColor.systemGray2.cgColor
        breakfastButton.layer.cornerRadius = 6
    }
    
    func prepareCollectionView() {
        menuCollectionView.delegate = self
        menuCollectionView.dataSource = self
        menuCollectionView.showsHorizontalScrollIndicator = false
        
        menuCollectionView.register(cellType: FoodCell.self)
    }
}
