//
//  FirstViewController.swift
//  KlassenAppD
//
//  Created by Adrian Baumgart on 09.04.18.
//  Copyright © 2018 Adrian Baumgart. All rights reserved.
//

import AVKit
import Crashlytics
import EZAlertController
import Fabric
import Firebase
import FirebaseDatabase
import FirebaseMessaging
import NVActivityIndicatorView
import SPStorkController
import UIKit
import UserNotifications

class FirstViewController: UIViewController {
    var loader: NVActivityIndicatorView!
    
    @IBOutlet var Week1Out: UIButton!
    @IBOutlet var Week2Out: UIButton!
    @IBOutlet var Week3Out: UIButton!
    @IBOutlet var Week4Out: UIButton!
    @IBOutlet var RequestBtnOut: UIButton!
    @IBOutlet var HomeworkLabel: UILabel!
    @IBOutlet var backgroundTitleView: UIView!
    @IBOutlet var TitleBarOut: UIView!
    
    var style = Appearances()
    
    var buttons: [UIButton] = [UIButton]()
    var buttonValues: [ButtonValue] = []
    
    @IBAction func Week1Btn(_ sender: Any) {
        self.presentStorkView(weekName: "Week1", controller: HomeworkWeekViewController())
    }
    
    @IBAction func Week2Btn(_ sender: Any) {
        self.presentStorkView(weekName: "Week2", controller: HomeworkWeekViewController())
    }
    
    @IBAction func Week3Btn(_ sender: Any) {
        self.presentStorkView(weekName: "Week3", controller: HomeworkWeekViewController())
    }
    
    @IBAction func Week4Btn(_ sender: Any) {
        self.presentStorkView(weekName: "Week4", controller: HomeworkWeekViewController())
    }
    
    @IBAction func HomeworkRequest(_ sender: Any) {
        let notificationFeedbackGenerator = UINotificationFeedbackGenerator()
        notificationFeedbackGenerator.prepare()
        var ref: DatabaseReference!
        
        ref = Database.database().reference()
        ref.child("standardData").child("iosCurrentVer").child("versionnumber").observeSingleEvent(of: .value) { NewestBuildDB in
            let NEWESTBUILD = NewestBuildDB.value as? String
            HomeViewController.HomeVar.NewestVersion = NEWESTBUILD!
            let dictionary = Bundle.main.infoDictionary!
            let versionCurrent = dictionary["CFBundleShortVersionString"] as! String
            if versionCurrent.compare(NEWESTBUILD!, options: .numeric) == .orderedAscending {
                notificationFeedbackGenerator.notificationOccurred(.warning)
                EZAlertController.alert("Alte Version", message: "Die Version ist veraltet. Aus Sicherheisgründen ist die Funktion nicht verfügbar. Bitte lade die neuste Version herunter. (https://ios.klassenappd.de)")
            }
            else {
                ref.child("standardData").child("requestsAllowed").observeSingleEvent(of: .value, with: { EditAllowed in
                    let Eall = EditAllowed.value as? String
                    if Eall == "1" {
                        self.presentStorkView(weekName: "-", controller: CreateHWRequest2ViewController())
                    }
                    else {
                        notificationFeedbackGenerator.notificationOccurred(.warning)
                        EZAlertController.alert("Nicht erlaubt", message: "Die Anfragen sind momentan gesperrt.")
                    }
                })
            }
        }
    }
    
    func presentStorkView(weekName: String, controller: UIViewController) {
        let impactFeedbackgenerator = UIImpactFeedbackGenerator(style: .light)
        impactFeedbackgenerator.prepare()
        impactFeedbackgenerator.impactOccurred()
        if weekName != "-" {
            HomeworkWeekViewController.HWWeekVC.selectedWeek = weekName
        }
        let controller1 = controller
        let transitionDelegate = SPStorkTransitioningDelegate()
        controller1.transitioningDelegate = transitionDelegate
        controller1.modalPresentationStyle = .custom
        controller1.modalPresentationCapturesStatusBarAppearance = true
        self.present(controller1, animated: true, completion: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.viewLoadSetup()
    }
    
    func setArrays() {
        self.buttons = [self.Week1Out, self.Week2Out, self.Week3Out, self.Week4Out, self.RequestBtnOut]
        self.buttonValues = [ButtonValue(child: "Week1", button: Week1Out), ButtonValue(child: "Week2", button: Week2Out), ButtonValue(child: "Week3", button: Week3Out), ButtonValue(child: "Week4", button: Week4Out)]
    }
    
    func viewLoadSetup() {
        self.setArrays()
        self.loader = NVActivityIndicatorView(frame: CGRect(x: self.view.center.x - 25, y: self.view.center.y - 25, width: 50, height: 50))
        self.loader.type = .ballPulseSync
        self.loader.color = UIColor.red
        view.addSubview(self.loader)
        if self.Week1Out.titleLabel?.text == "Download..." {
            self.loader.startAnimating()
        }
        else {
            self.loader.stopAnimating()
        }
        if UserDefaults.standard.string(forKey: "ButtonColor") != nil, UserDefaults.standard.string(forKey: "ButtonColor") != "" {
            for button in self.buttons {
                button.backgroundColor = UIColor(red: CGFloat(UserDefaults.standard.integer(forKey: "ButtonRed")) / 255, green: CGFloat(UserDefaults.standard.integer(forKey: "ButtonGreen")) / 255, blue: CGFloat(UserDefaults.standard.integer(forKey: "ButtonBlue")) / 255, alpha: 1)
            }
        }
        if UserDefaults.standard.string(forKey: "TitleBarColor") != nil, UserDefaults.standard.string(forKey: "TitleBarColor") != "" {
            self.TitleBarOut.backgroundColor = UIColor(red: CGFloat(UserDefaults.standard.integer(forKey: "TitleBarRed")) / 255, green: CGFloat(UserDefaults.standard.integer(forKey: "TitleBarGreen")) / 255, blue: CGFloat(UserDefaults.standard.integer(forKey: "TitleBarBlue")) / 255, alpha: 1)
        }
        
        changeAppearance()
        
        Fabric.sharedSDK().debug = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func changeAppearance() {
           if UserDefaults.standard.integer(forKey: "ManualAppearance") == 0 {
               if #available(iOS 13.0, *) {
                   if traitCollection.userInterfaceStyle == .dark {
                       view.backgroundColor = self.style.darkBackground
                       self.backgroundTitleView.backgroundColor = self.style.darkTitleBackground
                       self.HomeworkLabel.textColor = self.style.darkText
                       self.tabBarController!.tabBar.barTintColor = self.style.darkBarTintColor
                       self.tabBarController!.tabBar.tintColor = self.style.darkTintColor
                       setNeedsStatusBarAppearanceUpdate()
                   }
                   else if traitCollection.userInterfaceStyle == .light || traitCollection.userInterfaceStyle == .unspecified {
                       view.backgroundColor = self.style.lightBackground
                       self.backgroundTitleView.backgroundColor = self.style.lightTitleBackground
                       self.HomeworkLabel.textColor = self.style.lightText
                       self.tabBarController!.tabBar.barTintColor = self.style.lightBarTintColor
                       self.tabBarController!.tabBar.tintColor = self.style.lightTintColor
                       setNeedsStatusBarAppearanceUpdate()
                   }
               }
           }
           else {
               if UserDefaults.standard.integer(forKey: "DarkmodeStatus") == 1 {
                   view.backgroundColor = self.style.darkBackground
                   self.backgroundTitleView.backgroundColor = self.style.darkTitleBackground
                   self.HomeworkLabel.textColor = self.style.darkText
                   self.tabBarController!.tabBar.barTintColor = self.style.darkBarTintColor
                   self.tabBarController!.tabBar.tintColor = self.style.darkTintColor
                   setNeedsStatusBarAppearanceUpdate()
               }
               else if UserDefaults.standard.integer(forKey: "DarkmodeStatus") == 0 {
                   view.backgroundColor = self.style.lightBackground
                   self.backgroundTitleView.backgroundColor = self.style.lightTitleBackground
                   self.HomeworkLabel.textColor = self.style.lightText
                   self.tabBarController!.tabBar.barTintColor = self.style.lightBarTintColor
                   self.tabBarController!.tabBar.tintColor = self.style.lightTintColor
                   setNeedsStatusBarAppearanceUpdate()
               }
           }
       }
       
       override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
           super.traitCollectionDidChange(previousTraitCollection)
           
           if #available(iOS 12.0, *) {
               
               if UserDefaults.standard.integer(forKey: "ManualAppearance") == 0 {
                       self.changeAppearance()
                   self.setNeedsStatusBarAppearanceUpdate()
               }
               
           } else {
               // Fallback on earlier versions
           }
           
           
       }
       
       override var preferredStatusBarStyle: UIStatusBarStyle {
           var style: UIStatusBarStyle!
       if UserDefaults.standard.integer(forKey: "ManualAppearance") == 0 {
           if #available(iOS 13.0, *) {
               if traitCollection.userInterfaceStyle == .dark {
               style = .lightContent
           }
           else if traitCollection.userInterfaceStyle == .light || traitCollection.userInterfaceStyle == .unspecified {
                   style = .darkContent
           }
           }
       }
       else {
           if #available(iOS 13.0, *) {
               if UserDefaults.standard.integer(forKey: "DarkmodeStatus") == 1 {
                          style = .lightContent
                      }
                      else if UserDefaults.standard.integer(forKey: "DarkmodeStatus") == 0 {
                              style = .darkContent
                      }
           }
           else {
               if UserDefaults.standard.integer(forKey: "DarkmodeStatus") == 1 {
                   style = .lightContent
               }
               else if UserDefaults.standard.integer(forKey: "DarkmodeStatus") == 0 {
                       style = .default
               }
           }
       }
           return style
       }
    
    override func viewDidAppear(_ animated: Bool) {
        if let tabItems = tabBarController?.tabBar.items {
            let tabItem = tabItems[4]
            tabItem.badgeValue = nil
        }
        
        var ref: DatabaseReference!
        
        ref = Database.database().reference()
        if UserDefaults.standard.integer(forKey: "Checker") != 1, UserDefaults.standard.string(forKey: "TEALOGGER") != "tea", UserDefaults.standard.string(forKey: "EDITOR") != "1" {
            if Auth.auth().currentUser == nil {
                do {
                    try Auth.auth().signOut()
                    self.performSegue(withIdentifier: "homeworktologinsegue", sender: nil)
                }
                catch let signOutError as NSError {
                    print("Error signing out: %@", signOutError)
                }
            }
        }
        
        for value in self.buttonValues {
            ref.child("homework").child(value.child).child("Datum").observe(.value) { WeekDatumSnap in
                let datumSnap = WeekDatumSnap.value as? String
                self.loader.stopAnimating()
                value.button.setTitle(datumSnap, for: .normal)
            }
        }
    }
    
   /* override var preferredStatusBarStyle: UIStatusBarStyle {
        var style: UIStatusBarStyle!
        if UserDefaults.standard.integer(forKey: "DarkmodeStatus") == 1 {
            style = .lightContent
        }
        else if UserDefaults.standard.integer(forKey: "DarkmodeStatus") == 0 {
            style = .default
        }
        return style
    }*/
    
    func randomString(length: Int) -> String {
        let letters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890!§$%&/()=?`´*'#+^°<>,;.:-_"
        return String((0...length - 1).map { _ in letters.randomElement()! })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    struct ButtonValue {
        var child: String!
        var button: UIButton!
    }
}
