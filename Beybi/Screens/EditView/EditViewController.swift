//
//  EditViewController.swift
//  Beybi
//
//  Created by Banu on 23.12.2024.
//

import UIKit
import CoreData

class EditViewController: UIViewController {

    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var diaryTextView: UITextView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var addPhotoButton: UIButton!
    @IBOutlet weak var diaryPhoto: UIImageView!
    @IBOutlet weak var placeHolderLabel: UILabel!
    
    private lazy var viewModel: EditViewModelProtocol! = EditViewModel(delegate: self)
    
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
                  image:diaryPhoto.image ?? UIImage(named: "adım")!)
        navigationController?.popViewController(animated: true)
        NotificationCenter.default.post(name: .saveButtonTapped, object: nil)
    }
    
    func saveDiary(title: String, text: String, image: UIImage) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let context = appDelegate.persistentContainer.viewContext
        
        let diary = DemoEntity(context: context)
        diary.emotionalText = text
        diary.emotionalTitle = title
        diary.emotionalImage = image.pngData()
        
        do {
                try context.save()
                print("Diary saved successfully!")
            } catch {
                print("Failed to save diary: \(error.localizedDescription)")
            }
    }
    
    @IBAction func addPhotoButtonTapped(_ sender: Any) {
        viewModel.addPhotoButtonTappedd()
    }
    
    func showAlert(_ title: String, _ message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Tamam", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}

extension EditViewController: UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let selectedImage = info[.originalImage] as? UIImage {
            diaryPhoto.image = selectedImage
        }
        picker.dismiss(animated: true, completion: nil)
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
        placeHolderLabel.isHidden = !textView.text.isEmpty
    }
}

extension EditViewController: EditViewModelDelegate {
    func openPhotoLibrary() {
        guard UIImagePickerController.isSourceTypeAvailable(.photoLibrary) else {
            showAlert("Gallery Unavailable", "The gallery is not accessible on this device.")
            return
        }
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
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
        self.present(picker, animated: true, completion: nil)
    }
    
    func addPhotoButtonTapped() {
        let alert = UIAlertController(title: "Select Photo", message: "Select an option", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Shoot with camera", style: .default, handler: { _ in
            self.viewModel.openCameraa()
        }))
        alert.addAction(UIAlertAction(title: "Choose from Photo Gallery", style: .default, handler: { _ in
            self.viewModel.openPhotoLibraryy()
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func prepareUI() {
        titleTextField.placeholder = "Please enter a title"
        titleTextField.delegate = self
        diaryTextView.delegate = self
        titleTextField.isUserInteractionEnabled = true
        diaryTextView.isScrollEnabled = false
        scrollView.showsVerticalScrollIndicator = false
        diaryPhoto.layer.cornerRadius = 8
        addPhotoButton.layer.cornerRadius = 32
        addPhotoButton.layer.masksToBounds = true
        scrollView.showsVerticalScrollIndicator = false
        self.tabBarController?.tabBar.isHidden = true
        let saveButton = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(saveButtonTapped))
        self.navigationItem.rightBarButtonItem = saveButton
        saveButton.tintColor = .purple
    }
}
