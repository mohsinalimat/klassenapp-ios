//
//  SecondViewController.swift
//  KlassenAppD
//
//  Created by Adrian Baumgart on 09.04.18.
//  Copyright © 2018 Adrian Baumgart. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth
import ExpandingMenu

class SecondViewController: UIViewController {
    let network: NetworkManager = NetworkManager.sharedInstance
    @IBOutlet weak var Arbeit1BtnOut: UIButton!
    @IBOutlet weak var Arbeit2BtnOut: UIButton!
    @IBOutlet weak var Arbeit3BtnOut: UIButton!
    @IBOutlet weak var Arbeit4BtnOut: UIButton!
    @IBOutlet weak var Arbeit5BtnOut: UIButton!
    @IBOutlet weak var backgroundTitleView: UIView!
    @IBOutlet weak var TitleBar: UIView!
    
    @IBOutlet weak var TestsLabel: UILabel!
    
    @IBAction func Arbeit1Btn(_ sender: Any)
    {
        self.performSegue(withIdentifier: "test1segue", sender: nil)
    }
    
    @IBAction func Arbeit2Btn(_ sender: Any)
    {
        self.performSegue(withIdentifier: "test2segue", sender: nil)
    }
    
    @IBAction func Arbeit3Btn(_ sender: Any)
    {
        self.performSegue(withIdentifier: "test3segue", sender: nil)
    }
    
    @IBAction func Arbeit4Btn(_ sender: Any)
    {
        self.performSegue(withIdentifier: "test4segue", sender: nil)
    }
    
    @IBAction func Arbeit5Btn(_ sender: Any)
    {
        self.performSegue(withIdentifier: "test5segue", sender: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if UserDefaults.standard.string(forKey: "ButtonColor") != nil && UserDefaults.standard.string(forKey: "ButtonColor") != "" {
            self.Arbeit1BtnOut.backgroundColor = UIColor(red: CGFloat(UserDefaults.standard.integer(forKey: "ButtonRed"))/255, green: CGFloat(UserDefaults.standard.integer(forKey: "ButtonGreen"))/255, blue: CGFloat(UserDefaults.standard.integer(forKey: "ButtonBlue"))/255, alpha: 1)
            
            self.Arbeit2BtnOut.backgroundColor = UIColor(red: CGFloat(UserDefaults.standard.integer(forKey: "ButtonRed"))/255, green: CGFloat(UserDefaults.standard.integer(forKey: "ButtonGreen"))/255, blue: CGFloat(UserDefaults.standard.integer(forKey: "ButtonBlue"))/255, alpha: 1)
            
            self.Arbeit3BtnOut.backgroundColor = UIColor(red: CGFloat(UserDefaults.standard.integer(forKey: "ButtonRed"))/255, green: CGFloat(UserDefaults.standard.integer(forKey: "ButtonGreen"))/255, blue: CGFloat(UserDefaults.standard.integer(forKey: "ButtonBlue"))/255, alpha: 1)
            
            self.Arbeit4BtnOut.backgroundColor = UIColor(red: CGFloat(UserDefaults.standard.integer(forKey: "ButtonRed"))/255, green: CGFloat(UserDefaults.standard.integer(forKey: "ButtonGreen"))/255, blue: CGFloat(UserDefaults.standard.integer(forKey: "ButtonBlue"))/255, alpha: 1)
            
            self.Arbeit5BtnOut.backgroundColor = UIColor(red: CGFloat(UserDefaults.standard.integer(forKey: "ButtonRed"))/255, green: CGFloat(UserDefaults.standard.integer(forKey: "ButtonGreen"))/255, blue: CGFloat(UserDefaults.standard.integer(forKey: "ButtonBlue"))/255, alpha: 1)
        }
        if UserDefaults.standard.string(forKey: "TitleBarColor") != nil && UserDefaults.standard.string(forKey: "TitleBarColor") != "" {
            self.TitleBar.backgroundColor = UIColor(red: CGFloat(UserDefaults.standard.integer(forKey: "TitleBarRed"))/255, green: CGFloat(UserDefaults.standard.integer(forKey: "TitleBarGreen"))/255, blue: CGFloat(UserDefaults.standard.integer(forKey: "TitleBarBlue"))/255, alpha: 1)
        }
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
        /*let item1 = ExpandingMenuItem(size: menuButtonSize, title: "Arbeiten", image: UIImage(named: "ball_point_pen")!, highlightedImage: UIImage(named: "ball_point_pen")!, backgroundImage: UIImage(named: "ball_point_pen"), backgroundHighlightedImage: UIImage(named: "ball_point_pen")) { () -> Void in
            // Do some action
            //self.performSegue(withIdentifier: "hw2arbeiten", sender: nil)
            if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TestsShortID") as? SecondViewController
            {
                self.present(vc, animated: true, completion: nil)
            }
            print("btn1")
        }*/
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
            print("btn8")
        }
        
        
        if Auth.auth().currentUser != nil {
            menuButton.addMenuItems([item00, item0, item2, item3, item4, item5, item6, item9])
        }
        else {
            menuButton.addMenuItems([item00, item0, item2, item3, item4, item5, item6, item9])
        }
        if UserDefaults.standard.integer(forKey: "DarkmodeStatus") == 1 {
            view.backgroundColor = UIColor(red:0.05, green:0.05, blue:0.05, alpha:1.0)
              backgroundTitleView.backgroundColor = UIColor(red:0.13, green:0.13, blue:0.13, alpha:1.0)
              TestsLabel.textColor = UIColor.white
            UIApplication.shared.statusBarStyle = .lightContent
        }
        if UserDefaults.standard.integer(forKey: "DarkmodeStatus") == 0 {
            view.backgroundColor = UIColor.white
             backgroundTitleView.backgroundColor = UIColor(red:0.97, green:0.97, blue:0.97, alpha:0.8)
            TestsLabel.textColor = UIColor.black
            UIApplication.shared.statusBarStyle = .default
        }
        // Do any additional setup after loading the view, typically from a nib.
        /*NetworkManager.isUnreachable { (_) in
            var UDT1 = UserDefaults.standard.string(forKey: "UDTEST1Btn")
            var UDT2 = UserDefaults.standard.string(forKey: "UDTEST2Btn")
            var UDT3 = UserDefaults.standard.string(forKey: "UDTEST3Btn")
            var UDT4 = UserDefaults.standard.string(forKey: "UDTEST4Btn")
            var UDT5 = UserDefaults.standard.string(forKey: "UDTEST5Btn")
            if UDT1 == nil {
                self.Arbeit1BtnOut.isEnabled = false
                self.Arbeit1BtnOut.setTitle("Keine Daten vorhanden", for: .normal)
            }
            else {
                if UDT1 == "-" {
                    self.Arbeit1BtnOut.isEnabled = false
                }
                if UDT1 != "-" {
                    self.Arbeit1BtnOut.isEnabled = true
                }
                self.Arbeit1BtnOut.setTitle("S: " + UDT1!, for: .normal)
            }
            if UDT2 == nil {
                self.Arbeit2BtnOut.isEnabled = false
                self.Arbeit2BtnOut.setTitle("Keine Daten vorhanden", for: .normal)
            }
            else {
                if UDT2 == "-" {
                    self.Arbeit2BtnOut.isEnabled = false
                }
                if UDT2 != "-" {
                    self.Arbeit2BtnOut.isEnabled = true
                }
                self.Arbeit2BtnOut.setTitle("S: " + UDT2!, for: .normal)
            }
            if UDT3 == nil {
                self.Arbeit3BtnOut.isEnabled = false
                self.Arbeit3BtnOut.setTitle("Keine Daten vorhanden", for: .normal)
            }
            else {
                if UDT3 == "-" {
                    self.Arbeit3BtnOut.isEnabled = false
                }
                if UDT3 != "-" {
                    self.Arbeit3BtnOut.isEnabled = true
                }
                self.Arbeit3BtnOut.setTitle("S: " + UDT3!, for: .normal)
            }
            if UDT4 == nil {
                self.Arbeit4BtnOut.isEnabled = false
                self.Arbeit4BtnOut.setTitle("Keine Daten vorhanden", for: .normal)
            }
            else {
                if UDT4 == "-" {
                    self.Arbeit4BtnOut.isEnabled = false
                }
                if UDT4 != "-" {
                    self.Arbeit4BtnOut.isEnabled = true
                }
                self.Arbeit4BtnOut.setTitle("S: " + UDT4!, for: .normal)
            }
            if UDT5 == nil {
                self.Arbeit5BtnOut.isEnabled = false
                self.Arbeit5BtnOut.setTitle("Keine Daten vorhanden", for: .normal)
            }
            else {
                if UDT5 == "-" {
                    self.Arbeit5BtnOut.isEnabled = false
                }
                if UDT5 != "-" {
                    self.Arbeit5BtnOut.isEnabled = true
                }
                self.Arbeit5BtnOut.setTitle("S: " + UDT5!, for: .normal)
            }
        }*/
        
       
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return UIStatusBarStyle(rawValue: UserDefaults.standard.integer(forKey: "DarkmodeStatus"))!
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewDidAppear(_ animated: Bool) {
       /* if UserDefaults.standard.integer(forKey: "Checker") != 1 && UserDefaults.standard.string(forKey: "TEALOGGER") != "tea" {
             self.performSegue(withIdentifier: "arbeitentologinsegue", sender: nil)
        }*/
        
        if UserDefaults.standard.integer(forKey: "Checker") != 1 && UserDefaults.standard.string(forKey: "TEALOGGER") != "tea" {
            if Auth.auth().currentUser == nil {
                do {
                    try Auth.auth().signOut()
                     self.performSegue(withIdentifier: "arbeitentologinsegue", sender: nil)
                } catch let signOutError as NSError {
                    print ("Error signing out: %@", signOutError)
                }
            }
            
            
        }
        
        if FirstViewController.LastVC.ShortDirect == "NextTest" {
            FirstViewController.LastVC.ShortDirect = "0"
            self.performSegue(withIdentifier: "test1segue", sender: nil)
        }
        var ref: DatabaseReference!
        
        ref = Database.database().reference()
        
        ref.child("arbeiten").child("Arbeit1").child("buttonname").observeSingleEvent(of: .value) { (Arbeit1ButtonSnap) in
            let Arbeit1ButtonName = Arbeit1ButtonSnap.value as? String
            UserDefaults.standard.set(Arbeit1ButtonName, forKey: "UDTEST1Btn")
            if Arbeit1ButtonName != "-" {
                self.Arbeit1BtnOut.isEnabled = true
                self.Arbeit1BtnOut.setTitle(Arbeit1ButtonName, for: .normal)
            }
            if Arbeit1ButtonName == "-" {
                self.Arbeit1BtnOut.isEnabled = false
                self.Arbeit1BtnOut.setTitle(Arbeit1ButtonName, for: .normal)
            }
        }
        ref.child("arbeiten").child("Arbeit2").child("buttonname").observeSingleEvent(of: .value) { (Arbeit2ButtonSnap) in
            let Arbeit2ButtonName = Arbeit2ButtonSnap.value as? String
            UserDefaults.standard.set(Arbeit2ButtonName, forKey: "UDTEST2Btn")
            if Arbeit2ButtonName != "-" {
                self.Arbeit2BtnOut.isEnabled = true
                self.Arbeit2BtnOut.setTitle(Arbeit2ButtonName, for: .normal)
            }
            if Arbeit2ButtonName == "-" {
                self.Arbeit2BtnOut.isEnabled = false
                self.Arbeit2BtnOut.setTitle(Arbeit2ButtonName, for: .normal)
            }
        }
        ref.child("arbeiten").child("Arbeit3").child("buttonname").observeSingleEvent(of: .value) { (Arbeit3ButtonSnap) in
            let Arbeit3ButtonName = Arbeit3ButtonSnap.value as? String
            UserDefaults.standard.set(Arbeit3ButtonName, forKey: "UDTEST3Btn")
            if Arbeit3ButtonName != "-" {
                self.Arbeit3BtnOut.isEnabled = true
                self.Arbeit3BtnOut.setTitle(Arbeit3ButtonName, for: .normal)
            }
            if Arbeit3ButtonName == "-" {
                self.Arbeit3BtnOut.isEnabled = false
                self.Arbeit3BtnOut.setTitle(Arbeit3ButtonName, for: .normal)
            }
        }
        ref.child("arbeiten").child("Arbeit4").child("buttonname").observeSingleEvent(of: .value) { (Arbeit4ButtonSnap) in
            let Arbeit4ButtonName = Arbeit4ButtonSnap.value as? String
            UserDefaults.standard.set(Arbeit4ButtonName, forKey: "UDTEST4Btn")
            if Arbeit4ButtonName != "-" {
                self.Arbeit4BtnOut.isEnabled = true
                self.Arbeit4BtnOut.setTitle(Arbeit4ButtonName, for: .normal)
            }
            if Arbeit4ButtonName == "-" {
                self.Arbeit4BtnOut.isEnabled = false
                self.Arbeit4BtnOut.setTitle(Arbeit4ButtonName, for: .normal)
            }
        }
        ref.child("arbeiten").child("Arbeit5").child("buttonname").observeSingleEvent(of: .value) { (Arbeit5ButtonSnap) in
            let Arbeit5ButtonName = Arbeit5ButtonSnap.value as? String
            UserDefaults.standard.set(Arbeit5ButtonName, forKey: "UDTEST5Btn")
            if Arbeit5ButtonName != "-" {
                self.Arbeit5BtnOut.isEnabled = true
                self.Arbeit5BtnOut.setTitle(Arbeit5ButtonName, for: .normal)
            }
            if Arbeit5ButtonName == "-" {
                self.Arbeit5BtnOut.isEnabled = false
                self.Arbeit5BtnOut.setTitle(Arbeit5ButtonName, for: .normal)
            }
        }
    }
}
