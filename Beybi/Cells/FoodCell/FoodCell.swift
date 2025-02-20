//
//  FoodCell.swift
//  Beybi
//
//  Created by Banu on 15.09.2024.
//

import UIKit
import Food

final class FoodCell: UICollectionViewCell {
    
    @IBOutlet weak var foodName: UILabel!
    @IBOutlet private weak var foodImage: UIImageView!
    @IBOutlet weak var favView: UIView!
    @IBOutlet weak var heartImage: UIImageView!
    @IBOutlet weak var mealIDLabel: UILabel!
    @IBOutlet weak var ingredientsCountLabel: UILabel!
    @IBOutlet weak var cookingTimeLabel: UILabel!
    @IBOutlet weak var calLabel: UILabel!
    
    var viewModel: FoodCellViewModelProtocol! {
        didSet {
            viewModel.load()
            viewModel.viewDidLoad()
        }
    }
    
    @IBAction func addFavoritesButtonTapped(_ sender: Any) {
        if heartImage.image == .init(systemName: "heart") {
            heartImage.image = .init(systemName: "heart.fill")
            heartImage.tintColor = .orange
            if let mealId = mealIDLabel.text {
                NetworkManager.shared.addToFavorites(mealId: mealId) { success in
                    if success {
                        print("Favorilere başarıyla eklendi!")
                    } else {
                        print("Favorilere eklenirken bir hata oluştu.")
                    }
                }
            }
        } else {
            heartImage.image = .init(systemName: "heart")
            heartImage.tintColor = .systemGray4
            if let mealId = mealIDLabel.text {
                NetworkManager.shared.removeToFavorites(mealId: mealId) { success in
                    if success {
                        print("Favorilerden başarıyla çıkarıldı!")
                    } else {
                        print("Favorilerden çıkarılamadı.")
                    }
                }
            }
        }
    }
}

extension FoodCell: FoodCellViewModelDelegate {
    func prepareBannerImage(with urlString: String?) {
        if let imageUrlString = urlString, let url = URL(string:imageUrlString){
            foodImage.sd_setImage(with: url)
        }
    }
    
    func configureCell(food: Food?) {
        foodName.text = food?.name
        calLabel.text = food?.cal
        mealIDLabel.text = food?.mealId
        ingredientsCountLabel.text = "\(food?.ingredients.count ?? 0) ingredients"
        cookingTimeLabel.text = "\(food?.cookingTime ?? "-") min"
        if food?.isFav == true {
            heartImage.image = .init(systemName: "heart.fill")
            heartImage.tintColor = .orange
        } else {
            heartImage.image = .init(systemName: "heart")
            heartImage.tintColor = .systemGray4
        }
        prepareBannerImage(with: food?.imageUrl)
    }
    
    func setUI() {
        self.layer.cornerRadius = 10
        foodImage.layer.cornerRadius = 10
        favView.layer.cornerRadius = 12
        mealIDLabel.isHidden = true
    }
}
