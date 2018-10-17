//
//  DetailController.swift
//  MyPlaces
//
//  Created by user145617 on 9/21/18.
//  Copyright © 2018 UOC. All rights reserved.
//

import UIKit

class DetailController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextViewDelegate, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    /*
     Protocols:
     
    UIViewController - Main conrtoller for the view
    UIPickerViewDelegate, UIPickerViewDataSource - Delegate and data source for the picker object
    UITextViewDelegate - Delegate tho show/hide keyboard on a text view
    UITextFieldDelegate - Delegate to show/hide the keyboard on a field
    UIImagePickerControllerDelegate, UINavigationControllerDelegate - Delegates for selecting an image
    
    */
    var place:Place? = nil
    var keyboardHeight:CGFloat!
    var activeField:UIView!
    var lastOffSet:CGPoint!
    
    
    let pickerElems1 = ["Generic", "Touristic"]
    
    @IBOutlet weak var descField: UITextView!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var constraintHeight: NSLayoutConstraint!
    @IBOutlet weak var imagePicked: UIImageView!
    @IBOutlet weak var typePicker: UIPickerView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var btnUpdate: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.constraintHeight.constant = 400
        
        typePicker.delegate = self
        typePicker.dataSource = self
        
        descField.delegate = self
        nameField.delegate = self

        // Soft keyboard control
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action:#selector(dismissKeyboard))
        
        view.addGestureRecognizer(tap)
        
        let notificationCenter = NotificationCenter.default
        
        notificationCenter.addObserver(self, selector: #selector(hideKeyboard), name:
            UIResponder.keyboardWillHideNotification, object: nil)
        
        notificationCenter.addObserver(self, selector: #selector(showKeyboard), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        
        // Do any additional setup after loading the view.
        descField.text = place?.Description
        nameField.text = place?.Name
        
        if (place == nil){
            btnUpdate.setTitle("New", for: UIControl.State.normal)
            typePicker.selectRow(0, inComponent: 0, animated: false)
        }
        else{
            typePicker.selectRow(place?.PlaceType.rawValue ?? 0, inComponent: 0, animated: false)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func closeDetail(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: - UIPickerViewDelegate
    // Methods to load the viewpicker with the desired values
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerElems1.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerElems1[row]
    }
    
    
    // We need to know exactly which field is the one that we are/were editing
    @objc func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        activeField = textView
        lastOffSet = self.scrollView.contentOffset
        return true
    }
    
    @objc func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
        if(activeField == textView){
            activeField?.resignFirstResponder()
            activeField = nil
        }
        return true
    }
    
    @objc func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        activeField = textField
        lastOffSet = self.scrollView.contentOffset
        return true
    }
    
    @objc func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if(activeField == textField){
            activeField?.resignFirstResponder()
            activeField = nil
        }
        return true
    }
    
    // Position ScrollView accordingly to the keyboard
    @objc func showKeyboard(notification: Notification){
        if (activeField != nil){
            let userInfo = notification.userInfo!
            let keyboardScreenEndFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
            let keyboardViewEndFrame = view.convert(keyboardScreenEndFrame, from: view.window)
            
            keyboardHeight = keyboardViewEndFrame.size.height
            
            let distanceToBottom = self.scrollView.frame.size.height - (activeField?.frame.origin.y)! - (activeField?.frame.size.height)!
            
            let collapseSpace = keyboardHeight - distanceToBottom
            
            if(collapseSpace > 0){
                self.scrollView.setContentOffset(CGPoint(x:self.lastOffSet.x, y: collapseSpace + 10), animated: false)
                
                self.constraintHeight.constant += self.keyboardHeight
                
            }
            else{
                keyboardHeight = nil
            }
        }
    }
    
    // Close keyboard when clicking outside the UITextView
    @objc func dismissKeyboard(){
        view.endEditing(true)
    }
    
    // When closing the keyboard re-position UIScriollView
    @objc func hideKeyboard(){
        if(keyboardHeight != nil){
            self.scrollView.contentOffset = CGPoint(x: self.lastOffSet.x, y: self.lastOffSet.y)
            self.constraintHeight.constant -= self.keyboardHeight
        }
        keyboardHeight = nil
    }
    
    
    
    // MARK: - UIImagePIckerControllerDelegate
    @IBAction func selectImage(_ sender: Any) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = false
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        view.endEditing(true)
        let image = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        imagePicked.contentMode = .scaleAspectFit
        imagePicked.image = image
        dismiss(animated: true, completion: nil)
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    

    @IBAction func btnUpdateClicked(_ sender: Any) {
        // If operation is NEW then create a new Place
        if (btnUpdate.titleLabel?.text ==  "New"){
            // get selected type
            let selectedType = typePicker.selectedRow(inComponent: 0)
            if (selectedType == 0){
                
            }
            
            // get selectd image
            var data:Data? = nil
            data = imagePicked.image?.jpegData(compressionQuality: 1.0)
            
            let name = nameField.text
            let notes = descField.text
            
            let userSel: PlaceType
            if (selectedType == 0){
                userSel = PlaceType.GenericPlace
            }
            else{
                userSel = PlaceType.TouristicPlace
            }
            
            let newPlace = Place.init(type: userSel , name: name ?? "", description: notes ?? "", image_in: data)
            
            let manager = ManagerPlaces.shared()
            manager.Append(newPlace)
            
        }
        else{
        // If operation is UPDATE then modify Places's Name an Description
            if (place != nil) {
                place?.Name = nameField.text ?? ""
                place?.Description = descField.text ?? ""
            }
        }
    }
    
}
