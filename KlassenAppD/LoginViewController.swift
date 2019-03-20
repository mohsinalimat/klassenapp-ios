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
//import ChatCamp

class LoginViewController: UIViewController, UITextFieldDelegate {

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
            var pass = passcode.value as? String
            if self.PassCodeInput.text == pass {
                UserDefaults.standard.set(1, forKey: "Checker")
                //self.performSegue(withIdentifier: "loginsegue", sender: nil)
                self.performSegue(withIdentifier: "logintohome", sender: nil)
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
                // Fallback on earlier versions
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
            UIApplication.shared.statusBarStyle = .lightContent
        }
        if UserDefaults.standard.integer(forKey: "DarkmodeStatus") == 0 {
            view.backgroundColor = UIColor.white
            backgroundTitleView.backgroundColor = UIColor(red:0.97, green:0.97, blue:0.97, alpha:0.8)
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
            UIApplication.shared.statusBarStyle = .default
        }
        if UserDefaults.standard.integer(forKey: "TouchIDVerification") != 1 {
            LoginTouchIDOut.isEnabled = false
        }
        if UserDefaults.standard.integer(forKey: "TouchIDVerification") == 1 {
            LoginTouchIDOut.isEnabled = true
        }
        // Do any additional setup after loading the view.
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return UIStatusBarStyle(rawValue: UserDefaults.standard.integer(forKey: "DarkmodeStatus"))!
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        var ref: DatabaseReference!
        
        ref = Database.database().reference()
        
        if UserDefaults.standard.string(forKey: "WelcomeTour") != "done" {
            self.performSegue(withIdentifier: "startwelcomeTourSegue", sender: nil)
        }
       /* if UserDefaults.standard.string(forKey: "ReadInfos") != "1" {
            self.performSegue(withIdentifier: "havetoreadinfos", sender: nil)
        }*/
        if UserDefaults.standard.integer(forKey: "Checker") == 1 {
             //self.performSegue(withIdentifier: "loginsegue", sender: nil)
            self.performSegue(withIdentifier: "logintohome", sender: nil)
        }
        else {
        }
        
        if UserDefaults.standard.string(forKey: "TEALOGGER") == "tea" {
            self.performSegue(withIdentifier: "logintotea", sender: nil)
        }
        
        if UserDefaults.standard.string(forKey: "EDITOR") == "1" {
            //self.performSegue(withIdentifier: "loginsegue", sender: nil)
            self.performSegue(withIdentifier: "logintohome", sender: nil)
        }
        
        if Auth.auth().currentUser != nil {
            //self.performSegue(withIdentifier: "loginsegue", sender: nil)
            self.performSegue(withIdentifier: "logintohome", sender: nil)
        }
    }
    
    func createAlert (title: String, message:String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { (alertButtonClicked) in
            alert.dismiss(animated: true, completion: nil)
        }))
        self.present(alert, animated: true, completion: nil)
    }
    func alertforteacher (title: String, message:String) {
        let alertTea = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        
        alertTea.addAction(UIAlertAction(title: "Schüleransicht (alle Funktionen)", style: UIAlertAction.Style.default, handler: { (TeaTouchSuS) in
            UserDefaults.standard.set(1, forKey: "Checker")
                self.performSegue(withIdentifier: "loginsegue", sender: nil)
            
        }))
        alertTea.addAction(UIAlertAction(title: "Lehreransicht (News: Bearbeitungsmodus)", style: UIAlertAction.Style.default, handler: { (TeaTouchTea) in
            UserDefaults.standard.set("tea", forKey: "TEALOGGER")
                self.performSegue(withIdentifier: "logintotea", sender: nil)
            
            
        }))
        alertTea.addAction(UIAlertAction(title: "Abbrechen", style: UIAlertAction.Style.default, handler: { (TeaTouchDismiss) in
            alertTea.dismiss(animated: true, completion: nil)
        }))
        self.present(alertTea, animated: true, completion: nil)
    }
    func ThxAlert (title: String, message:String) {
        let THA = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        
        THA.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { (alertButtonClickedThx) in
            THA.dismiss(animated: true, completion: nil)
        }))
        self.present(THA, animated: true, completion: nil)
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}
