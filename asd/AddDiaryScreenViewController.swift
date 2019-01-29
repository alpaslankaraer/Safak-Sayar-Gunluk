//
//  AddDiaryScreenViewController.swift
//  asd
//
//  Created by Alpaslan on 27.01.2019.
//  Copyright © 2019 Alpaslan. All rights reserved.
//

import Foundation
import UIKit
import os.log

class AddDiaryScreenViewController: UIViewController, UITextViewDelegate, UITextFieldDelegate, UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.navigationController?.navigationBar.isHidden = true
        addTapGestures()
        titleTextField.delegate = self
        diaryTextArea.delegate = self
        
        
        // Set up views if editing an existing Meal.
        if let diary = diary {
            navigationItem.title = diary.title
            titleTextField.text = diary.title
            photoImageView.image = diary.photo
            diaryTextArea.text = diary.detail
            
            let currentDateTime = Date().timeIntervalSinceNow
            dateLabel.text = String(currentDateTime)
            //dateLabel.text = diary.date.addingTimeInterval
        }
        
        // Do any additional setup after loading the view.
        
        // Enable the Save button only if the text field has a valid Meal name.
        updateSaveButtonState()
    }
    
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var diaryTextArea: UITextView!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    
    var diary: Diary?
     
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        // Disable the Save button while editing.
        saveButton.isEnabled = false
    }
//
//    func textViewDidEndEditing(_ textView: UITextView) {
//        //        titleTextField.text = textView.text
//        //        diaryTextArea.text = textView.text
//        updateSaveButtonState()
//        navigationItem.title = titleTextField.text
//    }
//
    // MARK: UITextViewDelegate
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        titleTextField.resignFirstResponder()
        return true
    }
    
    
    //MARK: UIImagePickerControllerDelegate
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        // Dismiss the picker if the user canceled.
        dismiss(animated: true, completion: nil)
    }
    
    func addTapGestures() {
        let imageTapped = UITapGestureRecognizer(target: self, action: #selector(tappedImage))
    photoImageView.addGestureRecognizer(imageTapped)
        
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
        
        photoImageView.image = image
    }
    
    // MARK: Navigation
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        // Depending on style of presentation (modal or push presentation), this view controller needs to be dismissed in two different ways.
        let isPresentingInAddMealMode = presentingViewController is UINavigationController
        if isPresentingInAddMealMode {
            dismiss(animated: true, completion: nil)
        }
        else if let owningNavigationController = navigationController{
            owningNavigationController.popViewController(animated: true)
        }
        else {
            fatalError("The MealViewController is not inside a navigation controller.")
        }
        //dismiss(animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        // Configure the destination view controller only when the save button is pressed.
        guard let button = sender as? UIBarButtonItem, button === saveButton else {
            os_log("The save button was not pressed, cancelling", log: OSLog.default, type: .debug)
            return
        }
        
        let title = titleTextField.text ?? ""
        let diaryDetail = diaryTextArea.text ?? ""
        let photo = photoImageView.image
        let date = dateLabel
        
        diary = Diary(title: title, detail: diaryDetail, photo: photo, date: date as! NSDate)
        
    }
    
    
    
    // MARK: Private Methods
    private func updateSaveButtonState() {
        // Disable the Save button if the text field is empty.
        let text = titleTextField.text ?? ""
        let detail = diaryTextArea.text ?? ""
        saveButton.isEnabled = !text.isEmpty
        saveButton.isEnabled = !detail.isEmpty
    }
    
}
