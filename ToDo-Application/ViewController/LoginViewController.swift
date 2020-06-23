//
//  LoginViewController.swift
//  ToDo-Application
//
//  Created by macbook on 6/21/20.
//  Copyright © 2020 Decagon. All rights reserved.
//


import LocalAuthentication
import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailField: UITextField!
    
    @IBOutlet weak var passwordField: UITextField!
    
    @IBOutlet weak var loginButton: UIButton!
    
    @IBOutlet weak var biometricLogin: UIButton!
    
     var timer = Timer()
    override func viewDidLoad() {
           super.viewDidLoad()
         self.view.addBackground()
        passwordField.backgroundColor = .clear
        emailField.backgroundColor = .clear
        
        guard let passwordImage = UIImage(named: "eyeiconclose") else{
            fatalError("Password image not found")
        
        }
        timer = Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(self.doStuff), userInfo: nil, repeats: true)
             let resetTimer = UITapGestureRecognizer(target: self, action: #selector(self.resetTimer));
             self.view.isUserInteractionEnabled = true
             self.view.addGestureRecognizer(resetTimer)
        //password textfield rightImage
            passwordField.addRightImageToTextField(using: passwordImage)
        
    }
    
    @IBAction func biometricUnlock(_ sender: Any) {
       authenticationWithTouchID()
    }
    
    
    @IBAction func login(_ sender: Any) {
        let email = emailField.text
        let password = passwordField.text
        if(email == "test@gmail.com" && password == "password"){
            // move to the next page
            self.performSegue(withIdentifier: "loginSuccessful", sender: self)
        }
    }
    
    
    func showAlertController(_ message: String) {
        let alertController = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
    
    @objc func doStuff() {
        // perform any action you wish to
      //  print("User inactive for more than 5 seconds .")
        timer.invalidate()
     }
     @objc func resetTimer() {
        timer.invalidate()
        timer = Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(self.doStuff), userInfo: nil, repeats: true)
     }

}


//MARK: - Login Extension
extension LoginViewController {
    
    func authenticationWithTouchID() {
        let localAuthenticationContext = LAContext()
        localAuthenticationContext.localizedFallbackTitle = "Use Passcode"

        var authError: NSError?
        let reasonString = "To access the secure data"

        if localAuthenticationContext.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &authError) {
            
            localAuthenticationContext.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reasonString) { success, evaluateError in
                
                if success {
                
                    //TODO: User authenticated successfully, take appropriate action
                    DispatchQueue.main.async {
                        self.performSegue(withIdentifier: "loginSuccessful", sender: self)
                    }
                        
                } else {
                    //TODO: User did not authenticate successfully, look at error and take appropriate action
                    guard let error = evaluateError else {
                        return
                    }
                    
                    print(self.evaluateAuthenticationPolicyMessageForLA(errorCode: error._code))
                    
                    //TODO: If you have choosen the 'Fallback authentication mechanism selected' (LAError.userFallback). Handle gracefully
                    
                }
            }
        } else {
            
            guard let error = authError else {
                return
            }
            //TODO: Show appropriate alert if biometry/TouchID/FaceID is lockout or not enrolled
            print(self.evaluateAuthenticationPolicyMessageForLA(errorCode: error.code))
        }
    }
    
    func evaluatePolicyFailErrorMessageForLA(errorCode: Int) -> String {
        var message = ""
        if #available(iOS 11.0, macOS 10.13, *) {
            switch errorCode {
                case LAError.biometryNotAvailable.rawValue:
                    message = "Authentication could not start because the device does not support biometric authentication."
                showAlertController(message)
                
                
                case LAError.biometryLockout.rawValue:
                    message = "Authentication could not continue because the user has been locked out of biometric authentication, due to failing authentication too many times."
                showAlertController(message)
                case LAError.biometryNotEnrolled.rawValue:
                    message = "Authentication could not start because the user has not enrolled in biometric authentication."
                showAlertController(message)
                default:
                    message = "Did not find error code on LAError object"
                showAlertController(message)
            }
        } else {
            switch errorCode {
                case LAError.touchIDLockout.rawValue:
                    message = "Too many failed attempts."
                showAlertController(message)
                
                case LAError.touchIDNotAvailable.rawValue:
                    message = "TouchID is not available on the device"
                showAlertController(message)
                
                case LAError.touchIDNotEnrolled.rawValue:
                    message = "TouchID is not enrolled on the device"
                showAlertController(message)
                
                default:
                    message = "Did not find error code on LAError object"
                showAlertController(message)
            }
        }
        
        return message;
    }
    
    func evaluateAuthenticationPolicyMessageForLA(errorCode: Int) -> String {
        
        var message = ""
        
        switch errorCode {
            
        case LAError.authenticationFailed.rawValue:
            message = "The user failed to provide valid credentials"
            
        case LAError.appCancel.rawValue:
            message = "Authentication was cancelled by application"
            
        case LAError.invalidContext.rawValue:
            message = "The context is invalid"
            
        case LAError.notInteractive.rawValue:
            message = "Not interactive"
            
        case LAError.passcodeNotSet.rawValue:
            message = "Passcode is not set on the device"
            
        case LAError.systemCancel.rawValue:
            message = "Authentication was cancelled by the system"
            
        case LAError.userCancel.rawValue:
            message = "The user did cancel"
            
        case LAError.userFallback.rawValue:
            message = "The user chose to use the fallback"

        default:
            message = evaluatePolicyFailErrorMessageForLA(errorCode: errorCode)
        }
        
        return message
    }
}

//MARK: - UITextField


extension UITextField {
    func addRightImageToTextField(using image:UIImage){
         let rightImageView = UIImageView()
         
         rightImageView.heightAnchor.constraint(equalToConstant: CGFloat(20)).isActive = true
         rightImageView.widthAnchor.constraint(equalToConstant: CGFloat(20)).isActive = true
         
         rightImageView.image = image
         self.rightView = rightImageView
         self.rightViewMode = .always
         self.initiateTapGesture(imageView: rightImageView)
     }
    
    func initiateTapGesture(imageView : UIImageView){
          let singleTap = UITapGestureRecognizer(target: self, action: #selector(self.tapDetected))
          imageView.isUserInteractionEnabled = true
          imageView.addGestureRecognizer(singleTap)
       }
      
      @objc func tapDetected(){
          print("Yup")
          self.isSecureTextEntry = !self.isSecureTextEntry
          if self.isSecureTextEntry {
              guard let passwordImage = UIImage(named: "eyeiconclose") else{
                  fatalError("Password image not found")
              }
              self.addRightImageToTextField(using: passwordImage)
          }else{
              guard let passwordImage = UIImage(named: "eyeiconopen") else{
                  fatalError("Password image not found")
              }
              self.addRightImageToTextField(using: passwordImage)
          }
          
      }
}
