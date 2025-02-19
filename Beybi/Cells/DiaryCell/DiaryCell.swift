//
//  DiaryCell.swift
//  Beybi
//
//  Created by Banu on 23.12.2024.
//

import UIKit

typealias Image = UIImage

class DiaryCell: UICollectionViewCell {
    
    @IBOutlet weak var diaryTitle: UILabel!
    @IBOutlet weak var diaryPhoto: UIImageView!
    @IBOutlet weak var deleteView: UIView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var diaryDate: UILabel!
    @IBOutlet weak var diaryText: UILabel!
    
    var diaryPhotos: [UIImage?] = []
    
    var viewModel: DiaryCellViewModelProtocol! {
        didSet {
            viewModel.awakeFromNib()
            viewModel.load()
            
            let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture(_:)))
            containerView.addGestureRecognizer(panGesture)
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTapGesture(_:)))
            deleteView.addGestureRecognizer(tapGesture)
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        resetToOriginalState()
    }
    
    @objc private func handlePanGesture(_ gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: self)
        
        switch gesture.state {
        case .changed:
            if translation.x < 0 {
                containerView.frame.origin.x = containerView.frame.origin.x + translation.x / 4
                print("Latif")
                print("originx\(containerView.frame.origin.x)")
                print("translation.x\(translation.x)")
            } else {
                    resetToOriginalState()
            }
        case .ended:
            if containerView.frame.origin.x < -90 {
                UIView.animate(withDuration: 0.6) {
                    self.containerView.frame.origin.x = -90
                    self.layoutIfNeeded()
                    print("Banu")
                }
                NotificationCenter.default.post(name: .cellDidSwipe, object: self)
            } else {
                if containerView.frame.origin.x < -45 {
                    UIView.animate(withDuration: 0.6) {
                        self.containerView.frame.origin.x = -90
                        self.layoutIfNeeded()
                    }
                    NotificationCenter.default.post(name: .cellDidSwipe, object: self)
                } else {
                    resetToOriginalState()
                }
            }
        default:
            break
        }
    }
    @objc private func handleTapGesture(_ gesture: UITapGestureRecognizer) {
        NotificationCenter.default.post(name: .cellDidDelete, object: self)    }
    
    func resetToOriginalState() {
        UIView.animate(withDuration: 0.6) {
            self.containerView.frame.origin.x = 0
            self.layoutIfNeeded()
        }
    }
}

extension DiaryCell: DiaryCellViewModelDelegate {
    
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
    
    func configureDiaryCell(diary: DemoEntity) {
        diaryTitle.text = diary.emotionalTitle
        diaryText.text = diary.emotionalText
        
        if let emotionalImageData = diary.emotionalImage  {
            diaryPhotos = imagesFromCoreData(object: emotionalImageData) ?? []
            if diaryPhotos.count > 0, let photo = diaryPhotos[0] {
                diaryPhoto.image = photo
            } else {
                diaryPhoto.image = UIImage(named: "Barış")
            }
        }
    }
    
    func prepareUI() {
        self.layer.cornerRadius = 16
        diaryText.numberOfLines = 0
        diaryPhoto.layer.cornerRadius = 10
        self.layer.borderWidth = 0.5
        self.layer.borderColor = UIColor(red: 174/255.0, green: 165/255.0, blue: 164/255.0, alpha: 0.25).cgColor
    }
}
