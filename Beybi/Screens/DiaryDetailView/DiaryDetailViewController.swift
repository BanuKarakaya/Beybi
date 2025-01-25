//
//  DiaryDetailViewController.swift
//  Beybi
//
//  Created by Banu on 26.12.2024.
//

import UIKit

final class DiaryDetailViewController: UIViewController {

    @IBOutlet weak var diaryPhoto: UIImageView!
    @IBOutlet weak var diaryTitle: UILabel!
    @IBOutlet weak var diaryBodyText: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!
    
    lazy var viewModel: DiaryDetailViewModelProtocol = DiaryDetailViewModel(delegate: self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.viewDidLoad()
    }
}

extension DiaryDetailViewController: DiaryDetailViewModelDelegate {
    
    func NSToUIImage(image: Data) -> Image {
        UIImage(data: image as Data, scale: 1.0)!
    }
    
    func configure(selectedDiary: DemoEntity?) {
        diaryTitle.text = selectedDiary?.emotionalTitle
        diaryBodyText.text = selectedDiary?.emotionalText
        
        if let emotionalImageData = selectedDiary?.emotionalImage {
            diaryPhoto.image = NSToUIImage(image: emotionalImageData)
        } else {
            diaryPhoto.image = UIImage(named: "Barış")
        }
    }
    
    func prepareUI() {
        diaryBodyText.numberOfLines = 0
        diaryPhoto.layer.cornerRadius = 5
        scrollView.showsVerticalScrollIndicator = false
    }
}
