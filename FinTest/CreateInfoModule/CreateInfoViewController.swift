//
//  CreateCellViewController.swift
//  FinTest
//
//  Created by Илья Тюрин on 25.07.2021.
//

import UIKit

class CreateInfoViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate {
    
    @IBOutlet weak var loadImageButton: UIButton!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var contentView: UIStackView!
    
    var delegate: CreateInfoDelegate!
    private let imagePicker = UIImagePickerController()
    private var loadedImage: UIImage?
    private var activeField: UIView?

    override func viewDidLoad() {
        super.viewDidLoad()
        loadImageButton.imageView?.contentMode = .scaleAspectFit
        addGestureTap()
        addObservers()
    }
    
    @IBAction func applyButtonPressed(_ sender: Any) {
        guard let title = textField.text,
              let subtitile = textView.text,
              !title.isEmpty,
              !subtitile.isEmpty else {
            showAlertForText(title: "Warning", message: "Please fill all fields")
            return
        }
        
        let image = createImageForInfo()
        DispatchQueue.global().async {
            let imageData = image.pngData()
            let infoData = InfoData(mainTitle: title, subtitle: subtitile, image: imageData)
            DispatchQueue.main.async {
                self.delegate.newInfoAdded(info: infoData)
            }
        }
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func loadImagePressed(_ sender: Any) {
        if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum){
            imagePicker.delegate = self
            imagePicker.sourceType = .savedPhotosAlbum
            imagePicker.allowsEditing = false
            present(imagePicker, animated: true, completion: nil)
        }
    }
    
}

// MARK: - Private methods
extension CreateInfoViewController {
    private func showAlertForText(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default)
        alert.addAction(okAction)
        present(alert, animated: true)
    }
    
    private func insertDefaultImage() {
        loadedImage = UIImage(named: "first")
    }
    
    private func createImageForInfo() -> UIImage {
        if let image = loadedImage {
            return image
        } else {
            return UIImage(named: "first")!
        }
    }
}

// MARK:- ImagePicker Delegate
extension CreateInfoViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        self.dismiss(animated: true)
        guard let image = info[.originalImage] as? UIImage else {
            fatalError()
        }
        loadImageButton.setImage(image, for: .normal)
        loadedImage = image
    }
}

// MARK:- Move Up View Configure
extension CreateInfoViewController {
    private func addGestureTap() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(backgroundTap))
        contentView.addGestureRecognizer(tapGestureRecognizer)
    }
    
    private func addObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc private func keyboardWillShow(notification: NSNotification) {
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
        else { return }
        
        var shouldMoveViewUp = false
        
        if let active = activeField {
            let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: keyboardSize.height, right: 0.0)
            let bottomOfField = active.convert(active.bounds, to: view).maxY
            let topOfKeyboard = view.frame.height - keyboardSize.height
            
            if bottomOfField > topOfKeyboard {
                shouldMoveViewUp = true
                scrollView.contentInset = contentInsets
                scrollView.scrollIndicatorInsets = contentInsets
            }
        }
        
        if shouldMoveViewUp {
            self.view.frame.origin.y = -100
        }
    }

    @objc private func keyboardWillHide(notification: NSNotification) {
        let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: 0.0)
        scrollView.contentInset = contentInsets
        scrollView.scrollIndicatorInsets = contentInsets
        view.frame.origin.y = 0
    }
    
    @objc private func backgroundTap(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
        activeField = nil
    }
    
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        activeField = textView
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        activeField = textField
    }
    
}

