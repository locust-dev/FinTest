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
    
    var delegate: CreateInfoDelegate!
    private let imagePicker = UIImagePickerController()
    private var loadedImage: UIImage?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadImageButton.imageView?.contentMode = .scaleAspectFit
        
        
    }
    
    

    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
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

extension CreateInfoViewController {
   


}


extension CreateInfoViewController {
   
    
}
