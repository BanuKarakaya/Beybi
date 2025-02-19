//
//  EditViewController.swift
//  Beybi
//
//  Created by Banu on 23.12.2024.
//

import UIKit
import CoreData

typealias Button = UIButton

class EditViewController: UIViewController {

    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var addPhotoButton: UIButton!
    @IBOutlet weak var diaryTextView: UITextView!
    @IBOutlet weak var diaryPhoto: UIImageView!
    @IBOutlet weak var placeHolder: UILabel!
    @IBOutlet weak var photoCollectionView: UICollectionView!
    var imageArray: [UIImage] = []
    
    var borderColor = UIColor(red: 174/255, green: 165/255, blue: 164/255, alpha: 0.25)
    var placeHolderColor = UIColor(red: 61/255, green: 40/255, blue: 32/255, alpha: 0.25)

    
    private lazy var viewModel: EditViewModelProtocol = EditViewModel(delegate: self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.viewDidLoad()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTapGesture(_:)))
        scrollView.addGestureRecognizer(tapGesture)
    }
    
    @objc private func handleTapGesture(_ gesture: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }
    
    @objc func saveButtonTapped() {
        saveDiary(title: titleTextField.text ?? "",
                  text: diaryTextView.text ?? "",
                  imageArray: imageArray ?? [] )
        navigationController?.popViewController(animated: true)
        NotificationCenter.default.post(name: .saveButtonTapped, object: nil)
    }
    
    func saveDiary(title: String, text: String, imageArray: [UIImage]) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let context = appDelegate.persistentContainer.viewContext
        let dataArray = NSMutableArray()
        
        let diary = DemoEntity(context: context)
        diary.emotionalText = text
        diary.emotionalTitle = title
        
        for i in 0 ..< imageArray.count {
            if let data = imageArray[i].pngData() {
                dataArray.add(data)
            }
        }
        diary.emotionalImage = try? NSKeyedArchiver.archivedData(withRootObject: dataArray, requiringSecureCoding: true)
        
        do {
            try context.save()
            print("Diary saved successfully!")
            } catch {
                print("Failed to save diary: \(error.localizedDescription)")
            }
    }
    
    
    @IBAction func addPhotoButtonTapped(_ sender: Any) {
        viewModel.addPhotoButtonTappedd(sender: sender as! Button)
    }
    
    func showAlert(_ title: String, _ message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Tamam", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}

extension EditViewController: UICollectionViewDelegate {
    
}

extension EditViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeCell(cellType: AddPhotoCell.self, indexPath: indexPath)
        let image = imageArray[indexPath.item]
        let cellViewModel = AddPhotoCellViewModel(delegate: cell, image: image)
        cell.viewModel = cellViewModel
        
        return cell
    }
}

extension EditViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        .init(width: 88, height: 88)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        .init(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 16
    }
}

extension EditViewController: UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        if let selectedImage = info[.originalImage] as? UIImage {
            imageArray.append(selectedImage)
            photoCollectionView.reloadData()
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}

extension EditViewController: UINavigationControllerDelegate {
    
}

extension EditViewController: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return true
    }
}

extension EditViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        placeHolder.isHidden = !textView.text.isEmpty
    }
}

extension EditViewController: EditViewModelDelegate {
    func prepareCollectionView() {
        photoCollectionView.dataSource = self
        photoCollectionView.delegate = self
        photoCollectionView.register(cellType: AddPhotoCell.self)
    }
    
    func openPhotoLibrary() {
        guard UIImagePickerController.isSourceTypeAvailable(.photoLibrary) else {
            showAlert("Gallery Unavailable", "The gallery is not accessible on this device.")
            return
        }
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        picker.allowsEditing = true
        
        if let popoverController = picker.popoverPresentationController {
            popoverController.sourceView = addPhotoButton
            popoverController.sourceRect = addPhotoButton.bounds
            popoverController.permittedArrowDirections = .any
        }
        
        self.present(picker, animated: true, completion: nil)
    }
    
    func openCamera() {
        guard UIImagePickerController.isSourceTypeAvailable(.camera) else {
            showAlert("Camera Unavailable", "This device does not have a camera.")
            return
        }
        
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .camera
        picker.allowsEditing = true
        
        if let popoverController = picker.popoverPresentationController {
            popoverController.sourceView = addPhotoButton
            popoverController.sourceRect = addPhotoButton.bounds
            popoverController.permittedArrowDirections = .any
        }
        
        self.present(picker, animated: true, completion: nil)
    }
    
    func addPhotoButtonTapped(sender: Button) {
        let alert = UIAlertController(title: "Select images for your emotional diary", message: "Select an option", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Shoot with camera", style: .default, handler: { _ in
            self.viewModel.openCameraa()
        }))
        alert.addAction(UIAlertAction(title: "Choose from Photo Gallery", style: .default, handler: { _ in
            self.viewModel.openPhotoLibraryy()
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        if let popoverController = alert.popoverPresentationController {
            popoverController.sourceView = sender
            popoverController.sourceRect = sender.bounds
        }
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func prepareUI() {
        titleTextField.placeholder = "Please enter a title"
        titleTextField.layer.cornerRadius = 12
        titleTextField.layer.borderWidth = 0.5
        titleTextField.clipsToBounds = true
        diaryTextView.layer.cornerRadius = 12
        diaryTextView.layer.borderWidth = 0.5
        diaryTextView.layer.borderColor = borderColor.cgColor
        titleTextField.layer.borderColor = borderColor.cgColor
        titleTextField.delegate = self
        diaryTextView.delegate = self
        titleTextField.isUserInteractionEnabled = true
        diaryTextView.isScrollEnabled = false
        scrollView.showsVerticalScrollIndicator = false
        diaryPhoto.layer.cornerRadius = 8
        scrollView.showsVerticalScrollIndicator = false
        self.tabBarController?.tabBar.isHidden = true
        let saveButton = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(saveButtonTapped))
        self.navigationItem.rightBarButtonItem = saveButton
        saveButton.tintColor = .purple
    }
}
