//
//  SignUpViewController.swift
//  ParkoPolo
//
//  Created by Johnley Delgado on 04/12/2018.
//  Copyright © 2018 Johnley Delgado. All rights reserved.
//

import Foundation
import UIKit
import FirebaseAuth
import Firebase
class SignUpViewController: UIViewController , UITextFieldDelegate{
    let loading = Loading()
    
    //Basic Information
    
    @IBOutlet weak var txtFieldName: FloatingTF!
    @IBOutlet weak var txtFieldUsername: FloatingTF!
    @IBOutlet weak var txtFieldPassword: FloatingTF!
    @IBOutlet weak var txtFieldPhoneNumber: FloatingTF!
    @IBOutlet weak var txtFieldEmailAddress: FloatingTF!
    //TextField Car Profile
    @IBOutlet weak var txtFieldMake: UITextField!
    @IBOutlet weak var txtFieldModel: UITextField!
    @IBOutlet weak var txtFieldColor: UITextField!
    @IBOutlet weak var txtFieldSizeType: UITextField!
    @IBOutlet weak var txtFieldDescription: UITextField!
    @IBOutlet weak var txtDescription: UILabel!
    
    //Other
    @IBOutlet weak var txtFieldLicensePlate: FloatingTF!
    
    
    
    var numberTxtField = 1
    var myPickerView : UIPickerView!
    
    
    var makeList = ["1", "2", "3", "4", "5", "6", "7", "8"]
    var modelList = ["Chevy Sonic.", "Ford Fiesta.", "Honda Fit.", "Hyundai Accent.", "Kia Rio.", "Mazda2.", "Mitsubishi Mirage.", "Nissan Versa."]
    
    var colorList = ["Black", "Red", "White", "Green", "Purple"]
    var sizeList = ["Small", "Medium", "Large"]
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func SignupButton(_ sender: UIButton) {
        
        SignUpValidation()
        
    }
    
    func SignUpValidation(){
        let email = txtFieldEmailAddress.text!
        let name = txtFieldName.text!
        let password = txtFieldPassword.text!
        let username = txtFieldUsername.text!
        let PhoneNumber = txtFieldPhoneNumber.text!
        let MakeCar = txtFieldMake.text!
        let ModelCar = txtFieldModel.text!
        let ColorCar = txtFieldColor.text!
        let SizeTypeCar = txtFieldSizeType.text!
        let LicensePlate = txtFieldLicensePlate.text!
        let Description = txtFieldDescription.text!
        loading.showLoading(to_view: self.view)
        
            Auth.auth().createUser(withEmail: email, password: password){
                (user,error) in
                print(error)
                
                if error == nil{
                    self.loading.hideLoading(to_view: self.view)
                    let alert = UIAlertController(title: "Sign up", message: "Login Success", preferredStyle: .alert)
                    let okButton = UIAlertAction(title: "OK", style: .default){
                        (ok) in
                        let ref = Database.database().reference()
                        ref.child("user").child(Auth.auth().currentUser!.uid).setValue(["name":name,"username":username,"PhoneNumber":PhoneNumber,
                                                                                        "email":email,"MakeCar":MakeCar,"ModelCar":ModelCar,
                                                                                        "ColorCar":ColorCar,"SizeTypeCar":SizeTypeCar,"LicensePlate":LicensePlate,
                                                                                        "Description":Description])
                    }
                    
                    alert.addAction(okButton)
                    self.present(alert, animated: true, completion: nil)
                
                }
                else{
                    if let errorCode = AuthErrorCode(rawValue: (error?._code)!) {
                        self.loading.hideLoading(to_view: self.view)
                        let alert = UIAlertController(title: "Error", message: "\(errorCode.errorMessage)", preferredStyle: .alert)
                        let okButton = UIAlertAction(title: "OK", style: .default)
                        alert.addAction(okButton)
                        self.present(alert, animated: true, completion: nil)
                    }
                }
            }
 
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == txtFieldMake {
            self.pickUp(txtFieldMake)
            numberTxtField = 1
        }
        else if textField == txtFieldModel{
            self.pickUp(txtFieldModel)
            numberTxtField = 2
        }
        else if textField == txtFieldColor{
            self.pickUp(txtFieldColor)
            numberTxtField = 3
        }
        else if textField == txtFieldSizeType{
            self.pickUp(txtFieldSizeType)
            numberTxtField = 4
        }
        
        else if textField == txtFieldDescription{
             txtDescription.isHidden = true
        }
       
    }
    
    
    func pickUp(_ textField : UITextField){
        
        // UIPickerView
        self.myPickerView = UIPickerView(frame:CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 216))
        self.myPickerView.delegate = self
        self.myPickerView.dataSource = self
        self.myPickerView.backgroundColor = UIColor.white
        textField.inputView = self.myPickerView
        
        // ToolBar
        let toolBar = UIToolbar()
        toolBar.barStyle = .default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor(red: 92/255, green: 216/255, blue: 255/255, alpha: 1)
        toolBar.sizeToFit()
        
        // Adding Button ToolBar
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneClick))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelClick))
        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        textField.inputAccessoryView = toolBar
        
    }
    //MARK:- Button
    @objc func doneClick() {
        txtFieldMake.resignFirstResponder()
        txtFieldModel.resignFirstResponder()
        txtFieldColor.resignFirstResponder()
        txtFieldSizeType.resignFirstResponder()
    }
    @objc func cancelClick() {
        txtFieldMake.resignFirstResponder()
        txtFieldModel.resignFirstResponder()
        txtFieldColor.resignFirstResponder()
        txtFieldSizeType.resignFirstResponder()
    }
    
    
}

extension SignUpViewController: UIPickerViewDelegate, UIPickerViewDataSource{
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if numberTxtField == 1{
           return makeList.count
            
        }
        if numberTxtField == 2 {
            return modelList.count
            
        }
        if numberTxtField == 3 {
            return colorList.count
            
        }
        if numberTxtField == 4 {
            return sizeList.count
            
        }
        
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if numberTxtField == 1{
             return makeList[row]
            
        }
        if numberTxtField == 2 {
              return modelList[row]
            
        }
        if numberTxtField == 3 {
            return colorList[row]
            
        }
        if numberTxtField == 4 {
            return sizeList[row]
            
        }
     return ""
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if numberTxtField == 1{
            txtFieldMake.text = ""
            txtFieldMake.text = makeList[row]
            
        }
        if numberTxtField == 2 {
         txtFieldModel.text = modelList[row]
            
        }
        if numberTxtField == 3 {
            txtFieldColor.text = colorList[row]
            
        }
        if numberTxtField == 4 {
            txtFieldSizeType.text = sizeList[row]
            
        }
      
        
    }
}
extension AuthErrorCode {
    var errorMessage: String {
        switch self {
        case .emailAlreadyInUse:
            return "The email is already in use with another account"
        case .userNotFound:
            return "Account not found for the specified user. Please check and try again"
        case .userDisabled:
            return "Your account has been disabled. Please contact support."
        case .invalidEmail, .invalidSender, .invalidRecipientEmail:
            return "Please enter a valid email"
        case .networkError:
            return "Network error. Please try again."
        case .weakPassword:
            return "Your password is too weak. The password must be 6 characters long or more."
        case .wrongPassword:
            return "Your password is incorrect. Please try again or use 'Forgot password' to reset your password"
        default:
            return "Unknown error occurred"
        }
    }
}

