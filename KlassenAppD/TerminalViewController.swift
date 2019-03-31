//
//  TerminalViewController.swift
//  KlassenAppD
//
//  Created by Adrian Baumgart on 22.02.19.
//  Copyright © 2019 Adrian Baumgart. All rights reserved.
//

import UIKit
import Firebase

class TerminalViewController: UIViewController {

    @IBOutlet weak var TerminalWindow: UITextView!
    @IBOutlet weak var TerminalInput: UITextField!
    @IBAction func RunBtn(_ sender: Any)
    {
        TerminalInput.resignFirstResponder()
        if TerminalInput.text == "" {
            var TerText = TerminalWindow.text!
            TerminalWindow.text = "\(TerText)\nDas Feld darf nicht leer sein!\nKlassenApp:~ user$ "
        }
        else if TerminalInput.text == "help" {
            var TerText = TerminalWindow.text!
            TerminalWindow.text = "\(TerText)\nKlassenApp:~ user$ \(TerminalInput.text!)\nAlle Verfügbare Commands kann man hier finden: https://klassenappd.de/ios_commands.html\nKlassenApp:~ user$ "
        }
        else if TerminalInput.text == "exit" {
            var TerText = TerminalWindow.text!
            TerminalWindow.text = "\(TerText)\nKlassenApp:~ user$ \(TerminalInput.text!)"
            if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "settingsID") as? SettingsViewController
            {
                self.present(vc, animated: true, completion: nil)
            }
        }
        else if TerminalInput.text == "clear" {
            TerminalWindow.text = "KlassenApp:~ user$ "
        }
        else if TerminalInput.text == "toggle darkmode dark" {
            var TerText = TerminalWindow.text!
            UserDefaults.standard.set(1, forKey: "DarkmodeStatus")
            TerminalWindow.text = "\(TerText)\nKlassenApp:~ user$ \(TerminalInput.text!)\nDarkmode auf \"dark\" gestellt!\nKlassenApp:~ user$ "
        }
        else if TerminalInput.text == "toggle darkmode light" {
            var TerText = TerminalWindow.text!
            UserDefaults.standard.set(0, forKey: "DarkmodeStatus")
            TerminalWindow.text = "\(TerText)\nKlassenApp:~ user$ \(TerminalInput.text!)\nDarkmode auf \"light\" gestellt!\nKlassenApp:~ user$ "
        }
        else if TerminalInput.text == "update" {
            var TerText = TerminalWindow.text!
            TerminalWindow.text = "\(TerText)\nKlassenApp:~ user$ \(TerminalInput.text!)\nEine Verbindung zum Neuland wird aufgebaut und die neuste Version wird überprüft..."
            var ref: DatabaseReference!
            
            ref = Database.database().reference()
            
            ref.child("standardData").child("iosCurrentVer").child("versionnumber").observeSingleEvent(of: .value) { (UCNewUpdate) in
                let UCNewUpdateLE = UCNewUpdate.value as! String
                let dictionary = Bundle.main.infoDictionary!
                let versionCurrent = dictionary["CFBundleShortVersionString"] as! String
                
                if versionCurrent.compare(UCNewUpdateLE, options: .numeric) == .orderedAscending {
                    //Update verfügbar
                    var TerText = self.TerminalWindow.text!
                    self.TerminalWindow.text = "\(TerText)\nEin Update ist verfügbar, du wirst gleich auf die Website weitergeleitet..."
                    ref.child("standardData").child("iosCurrentVer").child("UpdateLink").observeSingleEvent(of: .value) { (linksnap) in
                        let linksnapLE = linksnap.value as! String
                        print(linksnapLE)
                        sleep(2)
                        UIApplication.shared.openURL(NSURL(string: linksnapLE)! as URL)
                    }
                    
                }
                if versionCurrent.compare(UCNewUpdateLE, options: .numeric) == .orderedDescending {
                    //Beta
                    var TerText = self.TerminalWindow.text!
                    self.TerminalWindow.text = "\(TerText)\nDu befindest dich in einer Betaversion, Updates funktionieren nicht!\nKlassenApp:~ user$ "
                }
                if versionCurrent == UCNewUpdateLE {
                    //Kein Update
                    var TerText = self.TerminalWindow.text!
                    self.TerminalWindow.text = "\(TerText)\nKein neues Update!\nKlassenApp:~ user$ "
                }
            }
        }
        
        TerminalInput.text = ""
        var stringLength:Int = self.TerminalWindow.text.characters.count
        self.TerminalWindow.scrollRangeToVisible(NSMakeRange(stringLength-1, 0))
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        /*NotificationCenter.default.addObserver(self, selector: #selector(TerminalViewController.keyboardWillShow), name: UIResponder.NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(TerminalViewController.keyboardWillHide), name: UIResponder.NSNotification.Name.UIKeyboardWillHide, object: nil)
        UIApplication.shared.statusBarStyle = .lightContent
        self.TerminalWindow.layoutManager.allowsNonContiguousLayout = false
        var stringLength:Int = self.TerminalWindow.text.characters.count
        self.TerminalWindow.scrollRangeToVisible(NSMakeRange(stringLength-1, 0))
        TerminalWindow.text = "KlassenApp Terminal V1.0\nDas ist nur ein Easter Egg. Einen wirklichen Sinn hat das Terminal nicht, jedoch werde ich regelmäßig Befehle hinzufügen! Manche Befehle sind sogar sinnvoll! :)\n\nFür Hilfe, schreibe \"help\"\n\nKlassenApp:~ user$ "
        // Do any additional setup after loading the view.*/
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
       /* if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0{
                let keyboardHeight = keyboardSize.height
                let heightbefore = view.frame.origin.y
                self.view.frame.origin.y -= keyboardHeight
                if view.frame.origin.y != heightbefore - keyboardHeight {
                    view.frame.origin.y -= keyboardHeight
                }
            }
        }*/
    }
    
 /*   @objc func keyboardWillHide(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y != 0{
                let keyboardHeight = keyboardSize.height
                self.view.frame.origin.y += keyboardHeight
                if view.frame.origin.y != 0 {
                    view.frame.origin.y = 0
                }
            }
        }
    }*/
    

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
    func textFieldShouldReturn(_ ChatMSGTF: UITextView) -> Bool {
        self.view.endEditing(true)
        return true
    }

}
