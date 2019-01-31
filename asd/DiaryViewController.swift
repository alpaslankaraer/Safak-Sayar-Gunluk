//
//  DetailDiaryViewController.swift
//  asd
//
//  Created by Alpaslan on 28.01.2019.
//  Copyright © 2019 Alpaslan. All rights reserved.
//

import UIKit
import os.log

class DiaryViewController: UIViewController, UITextViewDelegate, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    
    // MARK Properties
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var diaryTextArea: UITextView!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    
    
    var activityViewController: UIActivityViewController?
    
    @IBAction func shareButton(_ sender: UIBarButtonItem) {
        activityViewController = UIActivityViewController(activityItems: [titleTextField.text! as NSString, diaryTextArea.text! as NSString, photoImageView.image! as UIImage], applicationActivities: nil)
        
        present(activityViewController!, animated: true, completion: nil)
    }
    /*
     This value is either passed by `DiaryTableViewController` in `prepare(for:sender:)`
     or constructed as part of adding a new meal.
     */
    var diary: Diary?
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleTextField.delegate = self
        diaryTextArea.delegate = self
        
        
        // diaryTextArea'da fazla cümle yazılırsa imleç aşağı kayıyor böylece klavyenin altına girmemiş oluyor.
        NotificationCenter.default.addObserver(self, selector: #selector(DiaryViewController.updateTextView(notification:)), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(DiaryViewController.updateTextView(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        // Set up views if editing an existing Meal.
        if let diary = diary {
            navigationItem.title = diary.title
            titleTextField.text = diary.title
            photoImageView.image = diary.photo
            diaryTextArea.text = diary.detail
            
            
        }
        
        // Do any additional setup after loading the view.
        
        // Enable the Save button only if the text field has a valid Meal name.
        updateSaveButtonState()
        
        //getCurrentDateTime()
        //getSingle()
    }
//
//    func getCurrentDateTime () {
//        let formatter = DateFormatter()
//        formatter.dateStyle = .short
//        formatter.timeStyle = .medium
//        let str = formatter.string(from: Date())
//        dateLabel.text = str
//
//    }
//
//    func getSingle() {
//        let date = Date()
//        let calendar = Calendar.current
//        let year = calendar.component(.year, from: date)
//        let month = calendar.component(.month, from: date)
//        let day = calendar.component(.day, from: date)
//
//        dateLabel.text = "\(day).\(month).\(year)"
//        print("\(day).\(month).\(year)")
//
//    }
    
    
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        self.diaryTextArea.endEditing(true)
//    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        // Disable the Save button while editing.
        saveButton.isEnabled = false
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        updateSaveButtonState()
        navigationItem.title = titleTextField.text
    }
   
    // MARK: UITextViewDelegate
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        titleTextField.resignFirstResponder()
        return true
    }
    func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
        diaryTextArea.resignFirstResponder()
        return true
    }
    
    //MARK: UIImagePickerControllerDelegate
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        // Dismiss the picker if the user canceled.
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        //Dismiss the view controller
        //picker.dismiss(animated: true, completion: nil)
        
        //Get the picture we took
        guard let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {
            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }
        
        photoImageView.image = selectedImage
        
        picker.dismiss(animated: true, completion: nil)
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
        
        
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        var dateString = formatter.string(from: date as Date)
        
        diary = Diary(title: title, detail: diaryDetail, photo: photo, date: Date() as NSDate)
        
    }
    
    @IBAction func selectImageFromPhotoLibrary(_ sender: UITapGestureRecognizer) {
        
        // Hide the keyboard.
        titleTextField.resignFirstResponder()
        
        // UIImagePickerController is a view controller that lets a user pick media from their photo library.
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        
        let actionSheet = UIAlertController(title: "Fotoğraf Kaynağı", message: "Fotoğraf seçiniz", preferredStyle: .actionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "Kamera", style: .default, handler: { (action: UIAlertAction) in imagePickerController.sourceType = .camera
            self.present(imagePickerController, animated: true, completion: nil)
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Fotoğraflar", style: .default, handler: { (action: UIAlertAction) in imagePickerController.sourceType = .photoLibrary
            self.present(imagePickerController, animated: true, completion: nil)
        }))
        
        actionSheet.addAction(UIAlertAction(title: "İptal", style: .cancel, handler: nil))
        
        self.present(actionSheet, animated: true, completion: nil)
        
        
        // Make sure ViewController is notified when the user picks an image.
        imagePickerController.delegate = self
        //present(imagePickerController, animated: true, completion: nil)
    }
    
    // MARK: Private Methods
    private func updateSaveButtonState() {
        // Disable the Save button if the text field is empty.
        let text = titleTextField.text ?? ""
        let detail = diaryTextArea.text ?? ""
        saveButton.isEnabled = !text.isEmpty || !detail.isEmpty
        //saveButton.isEnabled = !detail.isEmpty
    }
    
    @objc func updateTextView(notification : Notification) {
        
        let userInfo = notification.userInfo!
        
        let keyboardEndFrameScreenCoordinates = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        
        if notification.name == UIResponder.keyboardWillHideNotification {
            diaryTextArea.contentInset = UIEdgeInsets.zero
        }else {
            diaryTextArea.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardEndFrameScreenCoordinates.height, right: 0)
            diaryTextArea.scrollIndicatorInsets = diaryTextArea.contentInset
        }
        
        diaryTextArea.scrollRangeToVisible(diaryTextArea.selectedRange)
    }
    
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    

    
}
