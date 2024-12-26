//
//  EditViewController.swift
//  Beybi
//
//  Created by Banu on 23.12.2024.
//

import UIKit
import CoreData

class EditViewController: UIViewController {

    @IBOutlet weak var diaryPhoto: UIImageView!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var diaryTextView: UITextView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var placeHolderLabel: UILabel!
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        titleTextField.placeholder = "Please enter a title"
        titleTextField.delegate = self
        diaryTextView.delegate = self
        titleTextField.isUserInteractionEnabled = true
        diaryTextView.isScrollEnabled = false
        scrollView.showsVerticalScrollIndicator = false
        diaryTextView.layer.borderWidth = 0.3
        diaryTextView.layer.borderColor = UIColor.systemGray4.cgColor
        diaryTextView.layer.cornerRadius = 8
        diaryPhoto.layer.cornerRadius = 8
    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        saveDiary(title: titleTextField.text ?? "", text: diaryTextView.text ?? "")
        navigationController?.popViewController(animated: true)
        NotificationCenter.default.post(name: .saveButtonTapped, object: nil)
    }
    
    func saveDiary(title: String, text: String) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let context = appDelegate.persistentContainer.viewContext
        
        let diary = DemoEntity(context: context)
        diary.emotionalText = text
        diary.emotionalTitle = title
        
        do {
                try context.save()
                print("Diary saved successfully!")
            } catch {
                print("Failed to save diary: \(error.localizedDescription)")
            }
    }
    
   
    
    @IBAction func addPhotoButtonTapped(_ sender: Any) {
        let alert = UIAlertController(title: "Fotoğraf Seç", message: "Bir seçenek belirleyin", preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "Kamera ile Çek", style: .default, handler: { _ in
            self.openCamera()
        }))
        
        alert.addAction(UIAlertAction(title: "Fotoğraf Galerisinden Seç", style: .default, handler: { _ in
            self.openPhotoLibrary()
        }))
        
        alert.addAction(UIAlertAction(title: "İptal", style: .cancel, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func openCamera() {
            guard UIImagePickerController.isSourceTypeAvailable(.camera) else {
                showAlert("Kamera Kullanılamıyor", "Bu cihazda kamera bulunmuyor.")
                return
            }
            
            let picker = UIImagePickerController()
            picker.delegate = self
            picker.sourceType = .camera
            self.present(picker, animated: true, completion: nil)
        }
    
    func openPhotoLibrary() {
            guard UIImagePickerController.isSourceTypeAvailable(.photoLibrary) else {
                showAlert("Galeri Kullanılamıyor", "Bu cihazda galeriye erişilemiyor.")
                return
            }
            
            let picker = UIImagePickerController()
            picker.delegate = self
            picker.sourceType = .photoLibrary
        self.present(picker, animated: true, completion: nil)
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
