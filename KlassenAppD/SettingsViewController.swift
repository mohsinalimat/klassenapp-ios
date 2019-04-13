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

class SettingsViewController: UIViewController {
    
    @IBOutlet weak var TouchIDSwitchOut: UISwitch!
    @IBOutlet weak var DarkmodeSwitchOut: UISwitch!
    @IBOutlet weak var BackBtnOut: UIButton!
    
    @IBOutlet weak var AppVersionLabe: UILabel!
    @IBOutlet weak var backgroundTitleView: UIView!
    @IBOutlet weak var SiriShortcutLabel: UILabel!
    @IBOutlet weak var SiriShortcutReadHomework: UISwitch!
    @IBOutlet weak var ReadInfosBtnOut: UIButton!
    
    
    //Labels for Darkmode
    @IBAction func ElternzettelChatBtn(_ sender: Any)
    {
        UIApplication.shared.openURL(NSURL(string: "https://klassenappd-team.github.io/files/ElternzettelChat.pdf")! as URL)
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
            UIApplication.shared.statusBarStyle = .lightContent
            UserDefaults.standard.set(1, forKey: "DarkmodeStatus")
        }
        if (sender.isOn != true) {
            view.backgroundColor = UIColor.white
            backgroundTitleView.backgroundColor = UIColor(red:0.97, green:0.97, blue:0.97, alpha:0.8)
            SettingsLabel.textColor = UIColor.black
            TouchIDLabel.textColor = UIColor.black
            AppVersionLabe.textColor = UIColor.black
            SiriShortcutLabel.textColor = UIColor.black
            //TouchID2Label.textColor = UIColor.black
            DarkmodeLabel.textColor = UIColor.black
            UIApplication.shared.statusBarStyle = .default
            UserDefaults.standard.set(0, forKey: "DarkmodeStatus")
            
        }
    }
    @IBAction func MailContactBtn(_ sender: Any)
    {
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(URL(string: "mailto:mail@klassenappd.de")!)
        } else {
            UIApplication.shared.openURL(URL(string: "https://google.de")!)
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
    

    override func viewDidLoad() {
        super.viewDidLoad()
        let menuButtonSize: CGSize = CGSize(width: 64.0, height: 50.0)
        print(self.view.frame.height)
        let menuButton = ExpandingMenuButton(frame: CGRect(origin: CGPoint.zero, size: menuButtonSize), image: UIImage(named: "menulines")!, rotatedImage: UIImage(named: "menulines")!)
        menuButton.foldingAnimations = .all
        menuButton.menuItemMargin = 1
        if UserDefaults.standard.integer(forKey: "DarkmodeStatus") == 1 {
            menuButton.bottomViewColor = UIColor.darkGray
        }
        else if UserDefaults.standard.integer(forKey: "DarkmodeStatus") != 1 {
            menuButton.bottomViewColor = UIColor.darkGray
        }
        menuButton.center = CGPoint(x: self.view.bounds.width - 32.0, y: self.view.bounds.height - 30.0)
        view.addSubview(menuButton)
        //HomeWorkShortID
        let item00 = ExpandingMenuItem(size: menuButtonSize, title: "Home", image: UIImage(named: "homeicon")!, highlightedImage: UIImage(named: "homeicon")!, backgroundImage: UIImage(named: "homeicon"), backgroundHighlightedImage: UIImage(named: "homeicon")) { () -> Void in
            // Do some action
            //self.performSegue(withIdentifier: "hw2arbeiten", sender: nil)
            if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "homeID") as? HomeViewController
            {
                self.present(vc, animated: true, completion: nil)
            }
            print("btn1")
        }
        let item0 = ExpandingMenuItem(size: menuButtonSize, title: "Hausaufgaben", image: UIImage(named: "book")!, highlightedImage: UIImage(named: "book")!, backgroundImage: UIImage(named: "book"), backgroundHighlightedImage: UIImage(named: "book")) { () -> Void in
            // Do some action
            //self.performSegue(withIdentifier: "hw2arbeiten", sender: nil)
            if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "HomeWorkShortID") as? FirstViewController
            {
                self.present(vc, animated: true, completion: nil)
            }
            print("btn1")
        }
        let item1 = ExpandingMenuItem(size: menuButtonSize, title: "Arbeiten", image: UIImage(named: "ball_point_pen")!, highlightedImage: UIImage(named: "ball_point_pen")!, backgroundImage: UIImage(named: "ball_point_pen"), backgroundHighlightedImage: UIImage(named: "ball_point_pen")) { () -> Void in
            // Do some action
            //self.performSegue(withIdentifier: "hw2arbeiten", sender: nil)
            if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TestsShortID") as? SecondViewController
            {
                self.present(vc, animated: true, completion: nil)
            }
            print("btn1")
        }
        let item2 = ExpandingMenuItem(size: menuButtonSize, title: "Hausaufgaben bis morgen", image: UIImage(named: "clock")!, highlightedImage: UIImage(named: "clock")!, backgroundImage: UIImage(named: "clock"), backgroundHighlightedImage: UIImage(named: "clock")) { () -> Void in
            // Do some action
            if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "habmID") as? HABMViewController
            {
                self.present(vc, animated: true, completion: nil)
            }
            print("btn2")
        }
        let item3 = ExpandingMenuItem(size: menuButtonSize, title: "Neuigkeiten", image: UIImage(named: "news")!, highlightedImage: UIImage(named: "news")!, backgroundImage: UIImage(named: "news"), backgroundHighlightedImage: UIImage(named: "news")) { () -> Void in
            // Do some action
            if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "newsID") as? NewsViewController
            {
                self.present(vc, animated: true, completion: nil)
            }
            print("btn3")
        }
        let item4 = ExpandingMenuItem(size: menuButtonSize, title: "Einstellungen", image: UIImage(named: "settings")!, highlightedImage: UIImage(named: "settings")!, backgroundImage: UIImage(named: "settings"), backgroundHighlightedImage: UIImage(named: "settings")) { () -> Void in
            // Do some action
            if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "settingsID") as? SettingsViewController
            {
                self.present(vc, animated: true, completion: nil)
            }
            print("btn4")
        }
        let item5 = ExpandingMenuItem(size: menuButtonSize, title: "Speiseplan", image: UIImage(named: "icons8-restaurant-filled-50")!, highlightedImage: UIImage(named: "icons8-restaurant-filled-50")!, backgroundImage: UIImage(named: "icons8-restaurant-filled-50"), backgroundHighlightedImage: UIImage(named: "icons8-restaurant-filled-50")) { () -> Void in
            // Do some action
            if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "FOODID") as? FoodViewController
            {
                self.present(vc, animated: true, completion: nil)
            }
            print("btn5")
        }
        let item6 = ExpandingMenuItem(size: menuButtonSize, title: "Stundenplan", image: UIImage(named: "icon_menu")!, highlightedImage: UIImage(named: "icon_menu")!, backgroundImage: UIImage(named: "icon_menu"), backgroundHighlightedImage: UIImage(named: "icon_menu")) { () -> Void in
            // Do some action
            if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "planID") as? TimeTableViewController
            {
                self.present(vc, animated: true, completion: nil)
            }
            print("btn6")
        }
        let item9 = ExpandingMenuItem(size: menuButtonSize, title: "Liste", image: UIImage(named: "checked")!, highlightedImage: UIImage(named: "checked")!, backgroundImage: UIImage(named: "checked"), backgroundHighlightedImage: UIImage(named: "checked")) { () -> Void in
            if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "rememberID") as? RememberViewController
            {
                self.present(vc, animated: true, completion: nil)
            }
            // Do some action
            print("btn9")
        }
        
        
        if Auth.auth().currentUser != nil {
            menuButton.addMenuItems([item00, item0, item1, item2, item3, item5, item6, item9])
        }
        else if UserDefaults.standard.string(forKey: "Terminal") == "enabled" {
            menuButton.addMenuItems([item00, item0, item1, item2, item3, item5, item6, item9])
        }
        else {
            menuButton.addMenuItems([item00, item0, item1, item2, item3, item5, item6, item9])
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
            GLSEV.DarkmodeVar = 1
            UIApplication.shared.statusBarStyle = .lightContent
            
            DarkmodeSwitchOut.setOn(true, animated: false)
        }
        if UserDefaults.standard.integer(forKey: "DarkmodeStatus") == 0 {
            view.backgroundColor = UIColor.white
            backgroundTitleView.backgroundColor = UIColor(red:0.97, green:0.97, blue:0.97, alpha:0.8)
            SettingsLabel.textColor = UIColor.black
            TouchIDLabel.textColor = UIColor.black
            SiriShortcutLabel.textColor = UIColor.black
            DarkmodeLabel.textColor = UIColor.black
            AppVersionLabe.textColor = UIColor.black
            GLSEV.DarkmodeVar = 0
            UIApplication.shared.statusBarStyle = .default
            
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
