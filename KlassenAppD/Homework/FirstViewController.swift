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
    
    @IBAction func Week1Btn(_ sender: Any) {
        let impactFeedbackgenerator = UIImpactFeedbackGenerator(style: .light)
        impactFeedbackgenerator.prepare()
        impactFeedbackgenerator.impactOccurred()
        HomeworkWeekViewController.HWWeekVC.selectedWeek = "Week1"
        let controller1 = HomeworkWeekViewController()
        let transitionDelegate = SPStorkTransitioningDelegate()
        controller1.transitioningDelegate = transitionDelegate
        controller1.modalPresentationStyle = .custom
        controller1.modalPresentationCapturesStatusBarAppearance = true
        self.present(controller1, animated: true, completion: nil)
    }
    
    @IBAction func Week2Btn(_ sender: Any) {
        let impactFeedbackgenerator = UIImpactFeedbackGenerator(style: .light)
        impactFeedbackgenerator.prepare()
        impactFeedbackgenerator.impactOccurred()
        HomeworkWeekViewController.HWWeekVC.selectedWeek = "Week2"
        let controller1 = HomeworkWeekViewController()
        let transitionDelegate = SPStorkTransitioningDelegate()
        controller1.transitioningDelegate = transitionDelegate
        controller1.modalPresentationStyle = .custom
        controller1.modalPresentationCapturesStatusBarAppearance = true
        self.present(controller1, animated: true, completion: nil)
    }
    
    @IBAction func Week3Btn(_ sender: Any) {
        let impactFeedbackgenerator = UIImpactFeedbackGenerator(style: .light)
        impactFeedbackgenerator.prepare()
        impactFeedbackgenerator.impactOccurred()
        HomeworkWeekViewController.HWWeekVC.selectedWeek = "Week3"
        let controller1 = HomeworkWeekViewController()
        let transitionDelegate = SPStorkTransitioningDelegate()
        controller1.transitioningDelegate = transitionDelegate
        controller1.modalPresentationStyle = .custom
        controller1.modalPresentationCapturesStatusBarAppearance = true
        self.present(controller1, animated: true, completion: nil)
    }
    
    @IBAction func Week4Btn(_ sender: Any) {
        let impactFeedbackgenerator = UIImpactFeedbackGenerator(style: .light)
        impactFeedbackgenerator.prepare()
        impactFeedbackgenerator.impactOccurred()
        HomeworkWeekViewController.HWWeekVC.selectedWeek = "Week4"
        let controller1 = HomeworkWeekViewController()
        let transitionDelegate = SPStorkTransitioningDelegate()
        controller1.transitioningDelegate = transitionDelegate
        controller1.modalPresentationStyle = .custom
        controller1.modalPresentationCapturesStatusBarAppearance = true
        self.present(controller1, animated: true, completion: nil)
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
                        let impactFeedbackgenerator = UIImpactFeedbackGenerator(style: .light)
                        impactFeedbackgenerator.prepare()
                        impactFeedbackgenerator.impactOccurred()
                        let controller1 = CreateHWRequest2ViewController()
                        let transitionDelegate = SPStorkTransitioningDelegate()
                        controller1.transitioningDelegate = transitionDelegate
                        controller1.modalPresentationStyle = .custom
                        controller1.modalPresentationCapturesStatusBarAppearance = true
                        self.present(controller1, animated: true, completion: nil)
                    }
                    else {
                        notificationFeedbackGenerator.notificationOccurred(.warning)
                        EZAlertController.alert("Nicht erlaubt", message: "Die Anfragen sind momentan gesperrt.")
                    }
                })
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.viewLoadSetup()
    }
    
    func viewLoadSetup() {
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
            self.Week1Out.backgroundColor = UIColor(red: CGFloat(UserDefaults.standard.integer(forKey: "ButtonRed")) / 255, green: CGFloat(UserDefaults.standard.integer(forKey: "ButtonGreen")) / 255, blue: CGFloat(UserDefaults.standard.integer(forKey: "ButtonBlue")) / 255, alpha: 1)
            
            self.Week2Out.backgroundColor = UIColor(red: CGFloat(UserDefaults.standard.integer(forKey: "ButtonRed")) / 255, green: CGFloat(UserDefaults.standard.integer(forKey: "ButtonGreen")) / 255, blue: CGFloat(UserDefaults.standard.integer(forKey: "ButtonBlue")) / 255, alpha: 1)
            
            self.Week3Out.backgroundColor = UIColor(red: CGFloat(UserDefaults.standard.integer(forKey: "ButtonRed")) / 255, green: CGFloat(UserDefaults.standard.integer(forKey: "ButtonGreen")) / 255, blue: CGFloat(UserDefaults.standard.integer(forKey: "ButtonBlue")) / 255, alpha: 1)
            
            self.Week4Out.backgroundColor = UIColor(red: CGFloat(UserDefaults.standard.integer(forKey: "ButtonRed")) / 255, green: CGFloat(UserDefaults.standard.integer(forKey: "ButtonGreen")) / 255, blue: CGFloat(UserDefaults.standard.integer(forKey: "ButtonBlue")) / 255, alpha: 1)
            
            self.RequestBtnOut.backgroundColor = UIColor(red: CGFloat(UserDefaults.standard.integer(forKey: "ButtonRed")) / 255, green: CGFloat(UserDefaults.standard.integer(forKey: "ButtonGreen")) / 255, blue: CGFloat(UserDefaults.standard.integer(forKey: "ButtonBlue")) / 255, alpha: 1)
        }
        if UserDefaults.standard.string(forKey: "TitleBarColor") != nil, UserDefaults.standard.string(forKey: "TitleBarColor") != "" {
            self.TitleBarOut.backgroundColor = UIColor(red: CGFloat(UserDefaults.standard.integer(forKey: "TitleBarRed")) / 255, green: CGFloat(UserDefaults.standard.integer(forKey: "TitleBarGreen")) / 255, blue: CGFloat(UserDefaults.standard.integer(forKey: "TitleBarBlue")) / 255, alpha: 1)
        }
        
        if UserDefaults.standard.integer(forKey: "DarkmodeStatus") == 1 {
            view.backgroundColor = UIColor(red: 0.05, green: 0.05, blue: 0.05, alpha: 1.0)
            self.backgroundTitleView.backgroundColor = UIColor(red: 0.13, green: 0.13, blue: 0.13, alpha: 1.0)
            self.HomeworkLabel.textColor = UIColor.white
            self.setNeedsStatusBarAppearanceUpdate()
        }
        if UserDefaults.standard.integer(forKey: "DarkmodeStatus") == 0 {
            view.backgroundColor = UIColor.white
            self.backgroundTitleView.backgroundColor = UIColor(red: 0.95, green: 0.95, blue: 0.95, alpha: 1.0)
            self.HomeworkLabel.textColor = UIColor.black
            self.setNeedsStatusBarAppearanceUpdate()
        }
        
        Fabric.sharedSDK().debug = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
        
        ref.child("homework").child("Week1").child("Datum").observe(.value) { Week1DatumSnap in
            let Week1DatumLE = Week1DatumSnap.value as? String
            self.loader.stopAnimating()
            UserDefaults.standard.set(Week1DatumLE, forKey: "UDW1Btn")
            self.Week1Out.setTitle(Week1DatumLE, for: .normal)
        }
        ref.child("homework").child("Week2").child("Datum").observe(.value) { Week2DatumSnap in
            let Week2DatumLE = Week2DatumSnap.value as? String
            UserDefaults.standard.set(Week2DatumLE, forKey: "UDW2Btn")
            self.Week2Out.setTitle(Week2DatumLE, for: .normal)
        }
        ref.child("homework").child("Week3").child("Datum").observe(.value) { Week3DatumSnap in
            let Week3DatumLE = Week3DatumSnap.value as? String
            UserDefaults.standard.set(Week3DatumLE, forKey: "UDW3Btn")
            self.Week3Out.setTitle(Week3DatumLE, for: .normal)
        }
        ref.child("homework").child("Week4").child("Datum").observe(.value) { Week4DatumSnap in
            let Week4DatumLE = Week4DatumSnap.value as? String
            UserDefaults.standard.set(Week4DatumLE, forKey: "UDW4Btn")
            self.Week4Out.setTitle(Week4DatumLE, for: .normal)
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
    
    func randomString(length: Int) -> String {
        let letters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890!§$%&/()=?`´*'#+^°<>,;.:-_"
        return String((0...length - 1).map { _ in letters.randomElement()! })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
