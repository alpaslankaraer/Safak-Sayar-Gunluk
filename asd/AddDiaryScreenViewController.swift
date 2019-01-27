//
//  AddDiaryScreenViewController.swift
//  asd
//
//  Created by Alpaslan on 27.01.2019.
//  Copyright © 2019 Alpaslan. All rights reserved.
//

import Foundation
import UIKit

class AddDiaryScreenViewController: UIViewController, UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.navigationController?.navigationBar.isHidden = true
        addTapGestures()
    }
    @IBOutlet weak var titleTextField: UITextField!
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var textArea: UITextView!
    @IBOutlet weak var addButton: UIButton!
    @IBAction func geriButtonPressed(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    func addTapGestures() {
        let imageTapped = UITapGestureRecognizer(target: self, action: #selector(tappedImage))
    imageView.addGestureRecognizer(imageTapped)
        
    }
    
    @objc func tappedImage(_ sender: UITapGestureRecognizer) {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = .camera
            imagePicker.allowsEditing = false
            self.present(imagePicker,animated: true, completion:  nil)
            
        }
    }
    @objc func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        //Dismiss the view controller
        picker.dismiss(animated: true, completion: nil)
        
        //Get the picture we took
        let image = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        
        imageView.image = image
        
        
        
    }
    
}
