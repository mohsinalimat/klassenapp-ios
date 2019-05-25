//
//  LoginViewController.swift
//  KlassenAppD
//
//  Created by Adrian Baumgart on 09.04.18.
//  Copyright © 2018 Adrian Baumgart. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth
import LocalAuthentication
import UserNotifications
import Fabric
import Crashlytics
import RevealingSplashView
import PinCodeTextField

class LoginViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var TitleBar: UIView!
    @IBOutlet weak var ErrorOutputLabel: UILabel!
    @IBOutlet weak var LoginTouchIDOut: UIButton!
    @IBOutlet weak var LoginadressTextField: UITextField!
    @IBOutlet weak var PasswordTextField: UITextField!
    
    @IBOutlet weak var LoginLabel: UILabel!
    @IBOutlet weak var UsernameLabel: UILabel!
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var backgroundTitleView: UIView!
    @IBOutlet weak var LoginBtnOut: UIButton!
    
   
    @IBOutlet weak var PassCodeInput: PinCodeTextField!
    @IBAction func LoginBtn(_ sender: Any)
    {
        var ref: DatabaseReference!
        
        ref = Database.database().reference()
        ref.child("standardData").child("iOS-Passcode").observeSingleEvent(of: .value) { (passcode) in
            let pass = passcode.value as? String
            if self.PassCodeInput.text == pass {
                UserDefaults.standard.set(1, forKey: "Checker")
                self.performSegue(withIdentifier: "logintotb", sender: nil)
            }
            else {
                self.ErrorOutputLabel.text = "Der Pincode ist falsch"
                self.PassCodeInput.text = ""
            }
        }
}
    
    
    
    @IBAction func LoginTouchID(_ sender: Any)
    {
        if UserDefaults.standard.integer(forKey: "TouchIDVerification") != 1 {
            LoginTouchIDOut.isEnabled = false
        }
        if UserDefaults.standard.integer(forKey: "TouchIDVerification") == 1 {
            LoginTouchIDOut.isEnabled = true
            let context:LAContext = LAContext()
            if #available(iOS 10.0, *) {
                context.localizedCancelTitle = "Benutzername/Passwort eingeben"
            } else {
            }
            if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: nil) {
                context.evaluatePolicy(LAPolicy.deviceOwnerAuthenticationWithBiometrics, localizedReason: "Bitte verwende TouchID/FaceID, um dich anzumelden") { (TouchIDLoginSuccess, TouchIDLoginError) in
                    if TouchIDLoginSuccess {
                        UserDefaults.standard.set(1, forKey: "Checker")
                            self.performSegue(withIdentifier: "loginsegue", sender: nil)
                        
                    }
                    else {
                        self.createAlert(title: "Fehler", message: "Ein Fehler ist aufgetreten")
                    }
                }
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        if UserDefaults.standard.string(forKey: "ButtonColor") != nil && UserDefaults.standard.string(forKey: "ButtonColor") != "" {
            self.LoginBtnOut.backgroundColor = UIColor(red: CGFloat(UserDefaults.standard.integer(forKey: "ButtonRed"))/255, green: CGFloat(UserDefaults.standard.integer(forKey: "ButtonGreen"))/255, blue: CGFloat(UserDefaults.standard.integer(forKey: "ButtonBlue"))/255, alpha: 1)
        }
        if UserDefaults.standard.string(forKey: "TitleBarColor") != nil && UserDefaults.standard.string(forKey: "TitleBarColor") != "" {
            self.TitleBar.backgroundColor = UIColor(red: CGFloat(UserDefaults.standard.integer(forKey: "TitleBarRed"))/255, green: CGFloat(UserDefaults.standard.integer(forKey: "TitleBarGreen"))/255, blue: CGFloat(UserDefaults.standard.integer(forKey: "TitleBarBlue"))/255, alpha: 1)
        }
        PassCodeInput.keyboardType = UIKeyboardType.numberPad
        if UserDefaults.standard.integer(forKey: "DarkmodeStatus") == 1 {
            view.backgroundColor = UIColor(red:0.05, green:0.05, blue:0.05, alpha:1.0)
            backgroundTitleView.backgroundColor = UIColor(red:0.13, green:0.13, blue:0.13, alpha:1.0)
            LoginLabel.textColor = UIColor.white
            ErrorOutputLabel.textColor = UIColor.white
            UsernameLabel.textColor = UIColor.white
            passwordLabel.textColor = UIColor.white
            LoginadressTextField.backgroundColor = UIColor(red:1.00, green:1.00, blue:1.00, alpha:0.1)
            LoginadressTextField.attributedPlaceholder = NSAttributedString(string: "Benutzername", attributes: [NSAttributedString.Key.foregroundColor:  UIColor(red:0.97, green:0.97, blue:0.97, alpha:0.5)])
            LoginadressTextField.textColor = UIColor.white
            LoginadressTextField.keyboardAppearance = UIKeyboardAppearance.dark
            PasswordTextField.backgroundColor = UIColor(red:1.00, green:1.00, blue:1.00, alpha:0.1)
            PasswordTextField.attributedPlaceholder = NSAttributedString(string: "Passwort", attributes: [NSAttributedString.Key.foregroundColor:  UIColor(red:0.97, green:0.97, blue:0.97, alpha:0.5)])
            PasswordTextField.textColor = UIColor.white
            PasswordTextField.keyboardAppearance = UIKeyboardAppearance.dark
            self.setNeedsStatusBarAppearanceUpdate()
        }
        if UserDefaults.standard.integer(forKey: "DarkmodeStatus") == 0 {
            view.backgroundColor = UIColor.white
            backgroundTitleView.backgroundColor = UIColor(red:0.95, green:0.95, blue:0.95, alpha:1.0)
            LoginLabel.textColor = UIColor.black
            ErrorOutputLabel.textColor = UIColor.black
            UsernameLabel.textColor = UIColor.black
            passwordLabel.textColor = UIColor.black
            LoginadressTextField.backgroundColor = UIColor.white
            LoginadressTextField.attributedPlaceholder = NSAttributedString(string: "Benutzername", attributes: [NSAttributedString.Key.foregroundColor:  UIColor.lightGray])
            LoginadressTextField.textColor = UIColor.black
            LoginadressTextField.keyboardAppearance = UIKeyboardAppearance.light
            PasswordTextField.backgroundColor = UIColor.white
            PasswordTextField.attributedPlaceholder = NSAttributedString(string: "Passwort", attributes: [NSAttributedString.Key.foregroundColor:  UIColor.lightGray])
            PasswordTextField.textColor = UIColor.black
            PasswordTextField.keyboardAppearance = UIKeyboardAppearance.light
            self.setNeedsStatusBarAppearanceUpdate()
        }
        if UserDefaults.standard.integer(forKey: "TouchIDVerification") != 1 {
            LoginTouchIDOut.isEnabled = false
        }
        if UserDefaults.standard.integer(forKey: "TouchIDVerification") == 1 {
            LoginTouchIDOut.isEnabled = true
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        var style: UIStatusBarStyle!
        if UserDefaults.standard.integer(forKey: "DarkmodeStatus") == 1 {
            style = .lightContent
        }
        else if UserDefaults.standard.integer(forKey: "DarkmodeStatus") == 0 {
            style = .default
        }
        return style
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
    }
    
    func createAlert (title: String, message:String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { (alertButtonClicked) in
            alert.dismiss(animated: true, completion: nil)
        }))
        self.present(alert, animated: true, completion: nil)
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}
