//
//  BabiesFavCell.swift
//  Beybi
//
//  Created by Banu on 18.09.2024.
//

import UIKit

class BabiesFavCell: UICollectionViewCell {

    @IBOutlet weak var babiesFavMiniCollection: UICollectionView!
    
    private lazy var viewModel: BabiesFavCellViewModelProtocol = BabiesFavCellViewModel(delegate: self)
    
    override func awakeFromNib() {
        super.awakeFromNib()
        viewModel.viewDidLoad()
    }
}

extension BabiesFavCell: UICollectionViewDelegate {
    
}

extension BabiesFavCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.numberOfItemsInSection()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeCell(cellType: BabiesFavMiniCell.self, indexPath: indexPath)
        return cell
    }
}

extension BabiesFavCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        .init(width: 175, height: 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 0, left: 5, bottom: 5, right: 8)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        viewModel.minimumLineSpacingForSectionAt()
    }
}

extension BabiesFavCell: BabiesFavCellViewModelDelegate {
    func prepareCollectionView() {
        babiesFavMiniCollection.delegate = self
        babiesFavMiniCollection.dataSource = self
        babiesFavMiniCollection.isScrollEnabled = false
        
        
        babiesFavMiniCollection.register(cellType: BabiesFavMiniCell.self)
    }
}
