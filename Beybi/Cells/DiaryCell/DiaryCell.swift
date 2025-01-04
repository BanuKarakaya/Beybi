//
//  DiaryCell.swift
//  Beybi
//
//  Created by Banu on 23.12.2024.
//

import UIKit

typealias Image = UIImage

protocol DiaryCellDelegate: AnyObject {
    func deleteButtonTapped(in cell: DiaryCell)
}

class DiaryCell: UICollectionViewCell {

    @IBOutlet weak var diaryTitle: UILabel!
    @IBOutlet weak var diaryPhoto: UIImageView!
    weak var delegate: DiaryCellDelegate?
  
    var viewModel: DiaryCellViewModelProtocol! {
        didSet {
            viewModel.awakeFromNib()
            viewModel.load()
        }
    }
    
    @IBAction func deleteButton(_ sender: Any) {
        delegate?.deleteButtonTapped(in: self)
    }
}

extension DiaryCell: DiaryCellViewModelDelegate {
    func NSToUIImage(image: Data) -> Image {
        UIImage(data: image as Data, scale: 1.0)!
    }
    
    func configureDiaryCell(diary: DemoEntity) {
        diaryTitle.text = diary.emotionalTitle
        
        if let emotionalImageData = diary.emotionalImage  {
            diaryPhoto.image = NSToUIImage(image: emotionalImageData)
        } else {
            diaryPhoto.image = UIImage(named: "banuş")
        }
        
    }
    
    func prepareUI() {
        self.layer.cornerRadius = 10
    }
}
