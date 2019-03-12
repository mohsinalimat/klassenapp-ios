//
//  OnlineLoginViewController.swift
//  KlassenAppD
//
//  Created by Adrian Baumgart on 14.09.18.
//  Copyright © 2018 Adrian Baumgart. All rights reserved.
//

import UIKit
import FirebaseAuth
//import ChatCamp
//import PusherChatkit

class OnlineLoginViewController: UIViewController {

    @IBOutlet weak var OnlineErrorOutput: UILabel!
    @IBOutlet weak var OnlineUsernameTextField: UITextField!
    @IBOutlet weak var OnlinePasswordTextField: UITextField!
    @IBOutlet weak var backgroundTitleView: UIView!
    @IBOutlet weak var LoginLabel: UILabel!
    @IBOutlet weak var UsernameLabel: UILabel!
    @IBOutlet weak var passwordLabel: UILabel!
    
    @IBAction func OnlineLoginBtn(_ sender: Any)
    {
        
      if OnlineUsernameTextField.text != "" && OnlinePasswordTextField.text != "" {
            var fullusername = OnlineUsernameTextField.text! + "@klassenapponline.fire"
            Auth.auth().signIn(withEmail: fullusername, password: OnlinePasswordTextField.text!) { (online, onlinerror) in
                if onlinerror != nil {
                    // ERROR
                    self.OnlineErrorOutput.text = onlinerror?.localizedDescription
                }
                else {
                    // FINISH
                    if Auth.auth().currentUser?.displayName == nil {
                        self.noDisplayName(title: "Name für Konto", message: "Dein Onlinekonto scheint noch keinen Namen zu haben. Bitte gib einen ein, den andere Benutzer z.B. im Chat sehen können")
                    }
                    else {
                        
                        self.performSegue(withIdentifier: "loginonlinesegue", sender: nil)
                    }
                }
            }
        }
        else {
            OnlineErrorOutput.text = "Bitte gib die Daten ein"
        }
         //self.performSegue(withIdentifier: "onlineloginsegue", sender: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if UserDefaults.standard.integer(forKey: "DarkmodeStatus") == 1 {
            view.backgroundColor = UIColor(red:0.05, green:0.05, blue:0.05, alpha:1.0)
            backgroundTitleView.backgroundColor = UIColor(red:0.13, green:0.13, blue:0.13, alpha:1.0)
            LoginLabel.textColor = UIColor.white
            OnlineErrorOutput.textColor = UIColor.white
            UsernameLabel.textColor = UIColor.white
            passwordLabel.textColor = UIColor.white
            OnlineUsernameTextField.backgroundColor = UIColor(red:1.00, green:1.00, blue:1.00, alpha:0.1)
            OnlineUsernameTextField.attributedPlaceholder = NSAttributedString(string: "Benutzername", attributes: [NSAttributedString.Key.foregroundColor:  UIColor(red:0.97, green:0.97, blue:0.97, alpha:0.5)])
            OnlineUsernameTextField.textColor = UIColor.white
            OnlineUsernameTextField.keyboardAppearance = UIKeyboardAppearance.dark
            OnlinePasswordTextField.backgroundColor = UIColor(red:1.00, green:1.00, blue:1.00, alpha:0.1)
            OnlinePasswordTextField.attributedPlaceholder = NSAttributedString(string: "Passwort", attributes: [NSAttributedString.Key.foregroundColor:  UIColor(red:0.97, green:0.97, blue:0.97, alpha:0.5)])
            OnlinePasswordTextField.textColor = UIColor.white
            OnlinePasswordTextField.keyboardAppearance = UIKeyboardAppearance.dark
            UIApplication.shared.statusBarStyle = .lightContent
        }
        if UserDefaults.standard.integer(forKey: "DarkmodeStatus") == 0 {
            view.backgroundColor = UIColor.white
            backgroundTitleView.backgroundColor = UIColor(red:0.97, green:0.97, blue:0.97, alpha:0.8)
            LoginLabel.textColor = UIColor.black
            OnlineErrorOutput.textColor = UIColor.black
            UsernameLabel.textColor = UIColor.black
            passwordLabel.textColor = UIColor.black
            OnlineUsernameTextField.backgroundColor = UIColor.white
            OnlineUsernameTextField.attributedPlaceholder = NSAttributedString(string: "Benutzername", attributes: [NSAttributedString.Key.foregroundColor:  UIColor.lightGray])
            OnlineUsernameTextField.textColor = UIColor.black
            OnlineUsernameTextField.keyboardAppearance = UIKeyboardAppearance.light
            OnlineUsernameTextField.backgroundColor = UIColor.white
            OnlinePasswordTextField.attributedPlaceholder = NSAttributedString(string: "Passwort", attributes: [NSAttributedString.Key.foregroundColor:  UIColor.lightGray])
            OnlinePasswordTextField.textColor = UIColor.black
            OnlinePasswordTextField.keyboardAppearance = UIKeyboardAppearance.light
            UIApplication.shared.statusBarStyle = .default
        }
        // Do any additional setup after loading the view.
    }
    
    /*func newUpdatealert (title: String, message: String) {
     let nUA = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
     
     nUA.addAction(UIAlertAction(title: "Installieren", style: UIAlertAction.Style.default, handler: { (nUAInstall) in
     UIApplication.shared.openURL(NSURL(string: "https://klassenappd-team.github.io/iosdownload.html")! as URL)
     }))
     nUA.addAction(UIAlertAction(title: "Dieses mal nicht mehr fragen", style: UIAlertAction.Style.default, handler: { (nUACanel2) in
     LastVC.UpdateReminderSession = "1"
     nUA.dismiss(animated: true, completion: nil)
     }))
     self.present(nUA, animated: true, completion: nil)
     }*/
    
  func noDisplayName (title: String, message: String) {
        let nDN = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        
        nDN.addTextField { (textSend) in
        }
        nDN.addAction(UIAlertAction(title: "Senden", style: UIAlertAction.Style.default, handler: { (nDNSend) in
            let textSender = nDN.textFields![0]
            if textSender.text == "" {
                self.OnlineErrorOutput.text = "Gib einen Namen ein"
                nDN.dismiss(animated: true, completion: nil)
            }
            else {
                let changer = Auth.auth().currentUser?.createProfileChangeRequest()
                changer?.displayName = textSender.text
                changer?.commitChanges(completion: { (commiterror) in
                    if commiterror != nil {
                        textSender.text = ""
                        nDN.title = "Fehler bei der Übertragung"
                    }
                    else {
                        nDN.dismiss(animated: true, completion: nil)
                         self.performSegue(withIdentifier: "loginonlinesegue", sender: nil)
                        print("\(Auth.auth().currentUser?.displayName) + \(Auth.auth().currentUser?.email) + \(Auth.auth().currentUser?.uid)")
                        //self.performSegue(withIdentifier: "onlineloginsegue", sender: nil)
                    }
                })
            }
        }))
        self.present(nDN, animated: true, completion: nil)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
}

//extension ViewController: PCChatManagerDelegate {}
