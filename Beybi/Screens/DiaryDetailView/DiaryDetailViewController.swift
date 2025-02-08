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
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var photoCollectionView: UICollectionView!
    
    lazy var viewModel: DiaryDetailViewModelProtocol = DiaryDetailViewModel(delegate: self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.viewDidLoad()
        pageControl.layer.cornerRadius = 12
    }
}

extension DiaryDetailViewController: UICollectionViewDelegate {
    
}

extension DiaryDetailViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeCell(cellType: PhotoCell.self, indexPath: indexPath)
        return cell
    }
}
 
extension DiaryDetailViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        .init(width: self.photoCollectionView.frame.width, height: photoCollectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

extension DiaryDetailViewController: DiaryDetailViewModelDelegate {
    func prepareCollectionView() {
        photoCollectionView.delegate = self
        photoCollectionView.dataSource = self
        photoCollectionView.register(cellType: PhotoCell.self)
        photoCollectionView.isPagingEnabled = true
    }
    
    func NSToUIImage(image: Data) -> Image {
        UIImage(data: image as Data, scale: 1.0)!
    }
    
    func configure(selectedDiary: DemoEntity?) {
        diaryTitle.text = selectedDiary?.emotionalTitle
        diaryBodyText.text = selectedDiary?.emotionalText
        
//        if let emotionalImageData = selectedDiary?.emotionalImage {
//            diaryPhoto.image = NSToUIImage(image: emotionalImageData)
//        } else {
//            diaryPhoto.image = UIImage(named: "Barış")
//        }
    }
    
    func prepareUI() {
        diaryBodyText.numberOfLines = 0
        //diaryPhoto.layer.cornerRadius = 5
        scrollView.showsVerticalScrollIndicator = false
    }
}


