//
//  ViewMoreViewController.swift
//  Beybi
//
//  Created by Banu on 19.09.2024.
//

import UIKit

class ViewMoreViewController: UIViewController {

    @IBOutlet weak var viewMoreCollectionView: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewMoreCollectionView.delegate = self
        viewMoreCollectionView.dataSource = self
        
        viewMoreCollectionView.register(cellType: CollectionViewCell.self)
    }
}

extension ViewMoreViewController: UICollectionViewDelegate {
    
}

extension ViewMoreViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        15
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeCell(cellType: CollectionViewCell.self, indexPath: indexPath)
        return cell
    }
    
    
}
