//
//  ViewMoreViewController.swift
//  Beybi
//
//  Created by Banu on 19.09.2024.
//

import UIKit

class ViewMoreViewController: UIViewController {

    @IBOutlet weak var viewMoreCollectionView: UICollectionView!
    
    private lazy var viewModel: ViewMoreViewModelProtocol = ViewMoreViewModel(delegate: self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.viewDidLoad()
    }
}

extension ViewMoreViewController: UICollectionViewDelegate {
    
}

extension ViewMoreViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.numberOfItemsInSection()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeCell(cellType: ViewMoreCell.self, indexPath: indexPath)
        return cell
    }
}

extension ViewMoreViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        .init(width: 370, height: 90)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        .init(top: 6.5, left: 6.5, bottom: 6.5, right: 6.5)
    }
}

extension ViewMoreViewController: ViewMoreViewModelDelegate {
    func prepareCollectionView() {
        viewMoreCollectionView.delegate = self
        viewMoreCollectionView.dataSource = self
        
        viewMoreCollectionView.register(cellType: ViewMoreCell.self)
    }
}
