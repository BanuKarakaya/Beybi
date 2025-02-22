//
//  DiaryDetailViewController.swift
//  Beybi
//
//  Created by Banu on 26.12.2024.
//

import UIKit

final class DiaryDetailViewController: UIViewController {

    @IBOutlet weak var diaryTitle: UILabel!
    @IBOutlet weak var diaryBodyText: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var photoCollectionView: UICollectionView!
    @IBOutlet weak var diaryDate: UILabel!
    
    var diaryPhotos: [UIImage] = []
    
    lazy var viewModel: DiaryDetailViewModelProtocol = DiaryDetailViewModel(delegate: self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.viewDidLoad()
        pageControl.layer.cornerRadius = 12
        photoCollectionView.layer.cornerRadius = 10
        if diaryPhotos.count < 2 {
            pageControl.isHidden = true
        } else {
            pageControl.numberOfPages = diaryPhotos.count
        }
        photoCollectionView.showsHorizontalScrollIndicator = false
    }
}

extension DiaryDetailViewController: UICollectionViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageWidth = scrollView.frame.width
        let currentPage = Int((scrollView.contentOffset.x + pageWidth / 2) / pageWidth)
        pageControl.currentPage = currentPage
    }
}

extension DiaryDetailViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        diaryPhotos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeCell(cellType: PhotoCell.self, indexPath: indexPath)
        let photo = diaryPhotos[indexPath.item]
        let cellViewModel = PhotoCellViewModel(delegate: cell, image: photo)
        cell.viewModel = cellViewModel
        
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
    
    func imagesFromCoreData(object: Data?) -> [UIImage]? {
        var retVal = [UIImage]()

        guard let object = object else { return nil }
        if let dataArray = try? NSKeyedUnarchiver.unarchivedObject(ofClass: NSArray.self, from: object) {
            for data in dataArray {
                if let data = data as? Data, let image = UIImage(data: data) {
                    retVal.append(image)
                }
            }
        }
        
        return retVal
    }
    
    func configure(selectedDiary: DemoEntity?) {
        diaryTitle.text = selectedDiary?.emotionalTitle
        diaryBodyText.text = selectedDiary?.emotionalText
        diaryDate.text = selectedDiary?.emotionalDate
        
        if let emotionalImageData = selectedDiary?.emotionalImage {
            diaryPhotos = imagesFromCoreData(object: selectedDiary?.emotionalImage) ?? []
        }
    }
    
    func prepareUI() {
        diaryBodyText.numberOfLines = 0
        //diaryPhoto.layer.cornerRadius = 5
        scrollView.showsVerticalScrollIndicator = false
    }
}


