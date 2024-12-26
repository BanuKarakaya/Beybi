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
    
    private lazy var viewModel: DiaryDetailViewModelProtocol! = DiaryDetailViewModel(delegate: self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.viewDidLoad()
    }
}

extension DiaryDetailViewController: DiaryDetailViewModelDelegate {
    func prepareUI() {
        diaryBodyText.numberOfLines = 0
    }
}
