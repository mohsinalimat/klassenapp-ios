//
//  SettingsViewController.swift
//  KlassenAppD
//
//  Created by Adrian Baumgart on 10.04.18.
//  Copyright © 2018 Adrian Baumgart. All rights reserved.
//

import UIKit
import Firebase
import LocalAuthentication
import Crashlytics
import Fabric
import AVKit
import ExpandingMenu
import SPStorkController

class SettingsViewController: UIViewController {
    
    @IBOutlet weak var TItleBar: UIView!
    @IBOutlet weak var ChangeColorsBtn: UIButton!
    @IBOutlet weak var MailContactBtn: UIButton!
    @IBOutlet weak var AppInfoBtn: UIButton!
    @IBOutlet weak var ChangeAppIconBtn: UIButton!
    @IBOutlet weak var TouchIDSwitchOut: UISwitch!
    @IBOutlet weak var DarkmodeSwitchOut: UISwitch!
    @IBOutlet weak var BackBtnOut: UIButton!
    @IBOutlet weak var InformationForRequests: UIButton!
    
    @IBOutlet weak var AppVersionLabe: UILabel!
    @IBOutlet weak var backgroundTitleView: UIView!
    @IBOutlet weak var SiriShortcutLabel: UILabel!
    @IBOutlet weak var SiriShortcutReadHomework: UISwitch!
    @IBOutlet weak var ReadInfosBtnOut: UIButton!
    
    @IBAction func InformationForRequestsAction(_ sender: Any)
    {
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(URL(string: "https://github.com/AdriBoy21/klassenapp-ios/wiki/Hausaufgabenanfragen-(de)")!)
        } else {
            UIApplication.shared.openURL(URL(string: "https://github.com/AdriBoy21/klassenapp-ios/wiki/Hausaufgabenanfragen-(de)")!)
        }
    }
    
    //Labels for Darkmode
    @IBAction func ElternzettelChatBtn(_ sender: Any)
    {
       // UIApplication.shared.openURL(NSURL(string: "https://klassenappd-team.github.io/files/ElternzettelChat.pdf")! as URL)
    }
    
    @IBOutlet weak var SettingsLabel: UILabel!
    @IBOutlet weak var TouchIDLabel: UILabel!
    @IBOutlet weak var DarkmodeLabel: UILabel!

    @IBAction func SWITCHNAVIGATION(_ sender: Any)
    {
    }
    @IBAction func ReadInfosBtn(_ sender: Any)
    {
        self.performSegue(withIdentifier: "showinfos", sender: nil)
    }
    @IBAction func TouchIDSwitch(_ sender: UISwitch)
    {
        if (sender.isOn != true) {
            UserDefaults.standard.set(0, forKey: "TouchIDVerification")
        }
        if (sender.isOn == true) {
            let context:LAContext = LAContext()
            if #available(iOS 10.0, *) {
                context.localizedCancelTitle = "Abbrechen"
            } else {
                // Fallback on earlier versions
            }
            if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: nil) {
               /* context.evaluatePolicy(LAPolicy.deviceOwnerAuthenticationWithBiometrics, localizedReason: "Bitte verifiziere, dass du TouchID/FaceID für diese App verwenden willst") { (TouchIDSuccess, TouchIDError) in
                    if TouchIDSuccess {
                        UserDefaults.standard.set(1, forKey: "TouchIDVerification")
                    }
                    else {
                        self.createAlert(title: "Fehler", message: "Ein Fehler ist aufgetreten")
                    }
                }*/
                UserDefaults.standard.set(1, forKey: "TouchIDVerification")
            }
            else {
                self.createAlert(title: "Fehler", message: "TouchID/FaceID ist auf diesem Gerät nicht verfügbar")
            }
        }
    }
    //backsettings
    
    @IBAction func LogOutBtn(_ sender: Any)
    {
      //  LoginViewController.GlobalVariables.LoggedInChecker = "0"
       if Auth.auth().currentUser != nil {
            do {
                try Auth.auth().signOut()
            } catch let signOutError as NSError {
                print ("Error signing out: %@", signOutError)
            }
        }
        UserDefaults.standard.set(0, forKey: "Checker")
        UserDefaults.standard.set("0", forKey: "TEALOGGER")
        UserDefaults.standard.set("0", forKey: "EDITOR")
        self.performSegue(withIdentifier: "logoutsegue", sender: nil)
    }
    
    @IBAction func PlaySiriShortcut(_ sender: Any)
    {
        playTutorial()
    }
    func playTutorial() {
        if let SiriShortcutTUTO = Bundle.main.path(forResource: "SiriShortcutTutorial", ofType: "mp4") {
            let SiriShortcutVideo = AVPlayer(url: URL(fileURLWithPath: SiriShortcutTUTO))
            let SiriShortcutPlayer = AVPlayerViewController()
            SiriShortcutPlayer.player = SiriShortcutVideo
            
            present(SiriShortcutPlayer, animated: true, completion: {
                SiriShortcutVideo.play()
            })
        }
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
    
    @IBAction func DarkmodeSwitch(_ sender: UISwitch)
    {
        if (sender.isOn == true) {
            view.backgroundColor = UIColor(red:0.05, green:0.05, blue:0.05, alpha:1.0)
            backgroundTitleView.backgroundColor = UIColor(red:0.13, green:0.13, blue:0.13, alpha:1.0)
            SettingsLabel.textColor = UIColor.white
            TouchIDLabel.textColor = UIColor.white
            SiriShortcutLabel.textColor = UIColor.white
            AppVersionLabe.textColor = UIColor.white
            //TouchID2Label.textColor = UIColor.white
            DarkmodeLabel.textColor = UIColor.white
           // UIApplication.shared.statusBarStyle = .lightContent
            UserDefaults.standard.set(1, forKey: "DarkmodeStatus")
            self.setNeedsStatusBarAppearanceUpdate()
            self.tabBarController!.tabBar.barTintColor = .black
            tabBarController!.tabBar.tintColor = UIColor(red:1.00, green:0.58, blue:0.00, alpha:1.0)
            
        }
        if (sender.isOn != true) {
            view.backgroundColor = UIColor.white
            backgroundTitleView.backgroundColor = UIColor(red:0.95, green:0.95, blue:0.95, alpha:1.0)
            SettingsLabel.textColor = UIColor.black
            TouchIDLabel.textColor = UIColor.black
            AppVersionLabe.textColor = UIColor.black
            SiriShortcutLabel.textColor = UIColor.black
            //TouchID2Label.textColor = UIColor.black
            DarkmodeLabel.textColor = UIColor.black
          //  UIApplication.shared.statusBarStyle = .default
            UserDefaults.standard.set(0, forKey: "DarkmodeStatus")
            self.setNeedsStatusBarAppearanceUpdate()
            self.tabBarController!.tabBar.barTintColor = .white
           tabBarController!.tabBar.tintColor = UIColor(red:0.00, green:0.48, blue:1.00, alpha:1.0)
            
        }
    }
    @IBAction func MailContactBtn(_ sender: Any)
    {
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(URL(string: "mailto:mail@klassenappd.de")!)
        } else {
            UIApplication.shared.openURL(URL(string: "mailto:mail@klassenappd.de")!)
        }
     /*   print("testMail")
        let email = "mail@klassenappd.de"
        if let url = URL(string: "mailto:\(email)") {
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(url)
            } else {
                UIApplication.shared.openURL(url)
            }
        }*/
        //UIApplication.shared.openURL(NSURL(string: "mailto:mail@klassenappd.de")! as URL)
        /*if #available(iOS 10.0, *) {
            UIApplication.shared.open(URL(string: "https://klassenappd-team.github.io/")!, options: convertToUIApplicationOpenExternalURLOptionsKeyDictionary([:]), completionHandler: nil)
        } else {
            // Fallback on earlier versions
            self.createAlert2(title: "Fehler", message: "Diese Funktion ist nicht kompatibel")
        }*/
    }
    
    @IBAction func BackBtn(_ sender: Any)
    {
        FirstViewController.LastVC.LastVCV = "settings"
        self.performSegue(withIdentifier: "backsettings", sender: nil)
    }
    
    @IBAction func SiriShortcutReadHomework(_ sender: UISwitch)
    {
        if (sender.isOn == true) {
            UserDefaults.standard.set("YES", forKey: "ReadSiriShortcutHomework")
        }
        if (sender.isOn != true) {
            UserDefaults.standard.set("NO", forKey: "ReadSiriShortcutHomework")
        }
    }
    
    @IBAction func AppInformationsAction(_ sender: Any)
    {
        let controller1 = AppInfosViewController()
        let transitionDelegate = SPStorkTransitioningDelegate()
        controller1.transitioningDelegate = transitionDelegate
        controller1.modalPresentationStyle = .custom
        controller1.modalPresentationCapturesStatusBarAppearance = true
        self.present(controller1, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if UserDefaults.standard.string(forKey: "ButtonColor") != nil && UserDefaults.standard.string(forKey: "ButtonColor") != "" {
            self.ReadInfosBtnOut.backgroundColor = UIColor(red: CGFloat(UserDefaults.standard.integer(forKey: "ButtonRed"))/255, green: CGFloat(UserDefaults.standard.integer(forKey: "ButtonGreen"))/255, blue: CGFloat(UserDefaults.standard.integer(forKey: "ButtonBlue"))/255, alpha: 1)
            
            self.ChangeColorsBtn.backgroundColor = UIColor(red: CGFloat(UserDefaults.standard.integer(forKey: "ButtonRed"))/255, green: CGFloat(UserDefaults.standard.integer(forKey: "ButtonGreen"))/255, blue: CGFloat(UserDefaults.standard.integer(forKey: "ButtonBlue"))/255, alpha: 1)
            
            self.ChangeAppIconBtn.backgroundColor = UIColor(red: CGFloat(UserDefaults.standard.integer(forKey: "ButtonRed"))/255, green: CGFloat(UserDefaults.standard.integer(forKey: "ButtonGreen"))/255, blue: CGFloat(UserDefaults.standard.integer(forKey: "ButtonBlue"))/255, alpha: 1)
            
            self.AppInfoBtn.backgroundColor = UIColor(red: CGFloat(UserDefaults.standard.integer(forKey: "ButtonRed"))/255, green: CGFloat(UserDefaults.standard.integer(forKey: "ButtonGreen"))/255, blue: CGFloat(UserDefaults.standard.integer(forKey: "ButtonBlue"))/255, alpha: 1)
            
            self.MailContactBtn.backgroundColor = UIColor(red: CGFloat(UserDefaults.standard.integer(forKey: "ButtonRed"))/255, green: CGFloat(UserDefaults.standard.integer(forKey: "ButtonGreen"))/255, blue: CGFloat(UserDefaults.standard.integer(forKey: "ButtonBlue"))/255, alpha: 1)
            
            self.InformationForRequests.backgroundColor = UIColor(red: CGFloat(UserDefaults.standard.integer(forKey: "ButtonRed"))/255, green: CGFloat(UserDefaults.standard.integer(forKey: "ButtonGreen"))/255, blue: CGFloat(UserDefaults.standard.integer(forKey: "ButtonBlue"))/255, alpha: 1)
        }
        if UserDefaults.standard.string(forKey: "TitleBarColor") != nil && UserDefaults.standard.string(forKey: "TitleBarColor") != "" {
            self.TItleBar.backgroundColor = UIColor(red: CGFloat(UserDefaults.standard.integer(forKey: "TitleBarRed"))/255, green: CGFloat(UserDefaults.standard.integer(forKey: "TitleBarGreen"))/255, blue: CGFloat(UserDefaults.standard.integer(forKey: "TitleBarBlue"))/255, alpha: 1)
        }
        
        if UserDefaults.standard.integer(forKey: "DarkmodeStatus") == 1 {
            view.backgroundColor = UIColor(red:0.05, green:0.05, blue:0.05, alpha:1.0)
            backgroundTitleView.backgroundColor = UIColor(red:0.13, green:0.13, blue:0.13, alpha:1.0)
            SettingsLabel.textColor = UIColor.white
            TouchIDLabel.textColor = UIColor.white
            SiriShortcutLabel.textColor = UIColor.white
            DarkmodeLabel.textColor = UIColor.white
            AppVersionLabe.textColor = UIColor.white
            // TouchIDLabel.textColor = UIColor.white
            self.setNeedsStatusBarAppearanceUpdate()
            GLSEV.DarkmodeVar = 1
            //UIApplication.shared.statusBarStyle = .lightContent
            
            DarkmodeSwitchOut.setOn(true, animated: false)
        }
        if UserDefaults.standard.integer(forKey: "DarkmodeStatus") == 0 {
            view.backgroundColor = UIColor.white
            backgroundTitleView.backgroundColor = UIColor(red:0.95, green:0.95, blue:0.95, alpha:1.0)
            SettingsLabel.textColor = UIColor.black
            TouchIDLabel.textColor = UIColor.black
            SiriShortcutLabel.textColor = UIColor.black
            DarkmodeLabel.textColor = UIColor.black
            AppVersionLabe.textColor = UIColor.black
            GLSEV.DarkmodeVar = 0
            self.setNeedsStatusBarAppearanceUpdate()
           // UIApplication.shared.statusBarStyle = .default
            
            DarkmodeSwitchOut.setOn(false, animated: false)
        }
        if UserDefaults.standard.integer(forKey: "TouchIDVerification") == 1 {
            TouchIDSwitchOut.setOn(true, animated: false)
        }
        
        if UserDefaults.standard.string(forKey: "ReadSiriShortcutHomework") != "NO" {
            SiriShortcutReadHomework.setOn(true, animated: false)
        }
        if UserDefaults.standard.string(forKey: "ReadSiriShortcutHomework") == "NO" {
            SiriShortcutReadHomework.setOn(false, animated: false)
        }
    }
    
    /*override var preferredStatusBarStyle: UIStatusBarStyle {
        return UIStatusBarStyle(rawValue: GLSEV.DarkmodeVar)!
    }*/
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
       // if LoginViewController.GlobalVariables.LoggedInChecker == "0" {
            //Perform Segue to Login
         //   self.performSegue(withIdentifier: "logoutsegue", sender: nil)
        //}
        
       /* if UserDefaults.standard.integer(forKey: "Checker") != 1 && UserDefaults.standard.string(forKey: "TEALOGGER") != "tea" {
            self.performSegue(withIdentifier: "logoutsegue", sender: nil)
        }*/
   /*     if UserDefaults.standard.integer(forKey: "Checker") != 1 && UserDefaults.standard.string(forKey: "TEALOGGER") != "tea" {
            if Auth.auth().currentUser == nil {
                do {
                    try Auth.auth().signOut()
                    self.performSegue(withIdentifier: "logoutsegue", sender: nil)
                } catch let signOutError as NSError {
                    print ("Error signing out: %@", signOutError)
                }
            }
        }*/
       /* if UserDefaults.standard.string(forKey: "TEALOGGER") == "tea" {
            BackBtnOut.isEnabled = false
        }
        if UserDefaults.standard.integer(forKey: "Checker") == 1 {
            BackBtnOut.isEnabled = true
        }*/
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    func createAlert (title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { (alertButtonClicked) in
            self.TouchIDSwitchOut.setOn(false, animated: true)
            alert.dismiss(animated: true, completion: nil)
        }))
        self.present(alert, animated: true, completion: nil)
    }
    func createAlert2 (title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { (alertButtonClicked) in
            alert.dismiss(animated: true, completion: nil)
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    struct GLSEV {
        static var DarkmodeVar = 0
    }
 
}



// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertToUIApplicationOpenExternalURLOptionsKeyDictionary(_ input: [String: Any]) -> [UIApplication.OpenExternalURLOptionsKey: Any] {
	return Dictionary(uniqueKeysWithValues: input.map { key, value in (UIApplication.OpenExternalURLOptionsKey(rawValue: key), value)})
}
