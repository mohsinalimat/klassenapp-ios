//
//  FirstViewController.swift
//  KlassenAppD
//
//  Created by Adrian Baumgart on 09.04.18.
//  Copyright © 2018 Adrian Baumgart. All rights reserved.
//

import UIKit
import Firebase
import UserNotifications
import Fabric
import Crashlytics
import BLTNBoard
import AVKit
import FirebaseDatabase
import MarqueeLabel
import NotificationBannerSwift
import ExpandingMenu
import FirebaseMessaging
import AppCenterPush
import AppCenter


class FirstViewController: UIViewController {

    @IBOutlet weak var LDULabel: UILabel!
    lazy var bulletinManager: BLTNItemManager = {
        let introPage = FirstViewController.bulletinNWUP()
        return BLTNItemManager(rootItem: introPage)
    }()
    lazy var bulletinManagerChangelog: BLTNItemManager = {
        let ChangelogUpdate = FirstViewController.bulletinWelcomeNV()
        return BLTNItemManager(rootItem: ChangelogUpdate)
    }()
    lazy var bulletinManagerChangelog2: BLTNItemManager = {
        let ChangelogUpdate2 = FirstViewController.bulletinWelcomeNVSecond()
        return BLTNItemManager(rootItem: ChangelogUpdate2)
    }()
    lazy var bulletinManagerChangelogBeta: BLTNItemManager = {
        let ChangelogUpdateBeta = FirstViewController.bulletinWelcomeNVBeta()
        return BLTNItemManager(rootItem: ChangelogUpdateBeta)
    }()
    lazy var betaVersionAVBullet: BLTNItemManager = {
        let betaVB = FirstViewController.bulletinNWUPBeta()
        return BLTNItemManager(rootItem: betaVB)
    }()
    
     
    let network: NetworkManager = NetworkManager.sharedInstance
    @IBOutlet weak var Week1Out: UIButton!
    @IBOutlet weak var Week2Out: UIButton!
    @IBOutlet weak var Week3Out: UIButton!
    @IBOutlet weak var Week4Out: UIButton!
    @IBOutlet weak var HomeworkLabel: UILabel!
    @IBOutlet weak var backgroundTitleView: UIView!
    
    @IBAction func Week1Btn(_ sender: Any)
    {
        if UserDefaults.standard.string(forKey: "EDITOR") == "1" {
            self.performSegue(withIdentifier: "week1esegue", sender: nil)
        }
        else {
        self.performSegue(withIdentifier: "week1segue", sender: nil)
        }
    }
    @IBAction func Week2Btn(_ sender: Any)
    {
        if UserDefaults.standard.string(forKey: "EDITOR") == "1" {
            self.performSegue(withIdentifier: "week2esegue", sender: nil)
        }
        else {
            self.performSegue(withIdentifier: "week2segue", sender: nil)
        }
    }
    @IBAction func Week3Btn(_ sender: Any)
    {
        if UserDefaults.standard.string(forKey: "EDITOR") == "1" {
            self.performSegue(withIdentifier: "week3esegue", sender: nil)
        }
        else {
            self.performSegue(withIdentifier: "week3segue", sender: nil)
        }
    }
    @IBAction func Week4Btn(_ sender: Any)
    {
        if UserDefaults.standard.string(forKey: "EDITOR") == "1" {
            self.performSegue(withIdentifier: "week4esegue", sender: nil)
        }
        else {
            self.performSegue(withIdentifier: "week4segue", sender: nil)
        }
    }
    
    
    //UpdateView:
    @IBOutlet weak var NUView: UIView!
    @IBOutlet weak var NUTitle: UILabel!
    @IBOutlet weak var NUDes: UITextView!
    
    //Connectindicator:
    @IBOutlet weak var CIView: UIView!
    @IBOutlet weak var CILabel: UILabel!
    @IBOutlet weak var CIIndicator: UIActivityIndicatorView!
    @IBAction func ChatCodeButton(_ sender: Any)
    {
        if UserDefaults.standard.string(forKey: "cheat1") != "finished" {
        if FirstViewController.LastVC.Cheat1 < 4 {
            FirstViewController.LastVC.Cheat1 += 1
        }
        else {
            var Random = randomString(length: 10)
            Cheat1(title: "Gut gemacht!", message: "Du hast das 1. Easter Egg entdeckt! Eine Funktion wurde hinzugefügt! Return Code: \(Random)")
            UserDefaults.standard.set("enabled", forKey: "Terminal")
            UserDefaults.standard.set("finished", forKey: "cheat1")
        }
        }
    }
    
    func randomString(length: Int) -> String {
        let letters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890!§$%&/()=?`´*'#+^°<>,;.:-_"
        return String((0...length-1).map{_ in letters.randomElement()!})
    }
    
    @IBAction func NUShowBtn(_ sender: Any)
    {
        LastVC.UpdateReminderSession = "1"
        UIView.animate(withDuration: 0.3/*Animation Duration second*/, animations: {
            self.NUView.alpha = 0
        }, completion:  {
            (value: Bool) in
            self.NUView.isHidden = true
        })
        self.performSegue(withIdentifier: "gotoupdatecenter", sender: nil)
    }
    
    @IBAction func NUNotNowBtn(_ sender: Any)
    {
        LastVC.UpdateReminderSession = "1"
        UIView.animate(withDuration: 0.3/*Animation Duration second*/, animations: {
            self.NUView.alpha = 0
        }, completion:  {
            (value: Bool) in
            self.NUView.isHidden = true
        })
    }
    //:EndUpdateView
    
    override func viewDidLoad() {
       // CIView.isHidden = true
        super.viewDidLoad()
        var hi = UIDevice.current.identifierForVendor?.uuidString
        print(hi)
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
        //homeID
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
        let item7 = ExpandingMenuItem(size: menuButtonSize, title: "Updatecenter", image: UIImage(named: "downloadsign")!, highlightedImage: UIImage(named: "downloadsign")!, backgroundImage: UIImage(named: "downloadsign"), backgroundHighlightedImage: UIImage(named: "downloadsign")) { () -> Void in
            // Do some action
            if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "updatecenterid") as? UpdateCenterViewController
            {
                self.present(vc, animated: true, completion: nil)
            }
            print("btn7")
        }
        let item8 = ExpandingMenuItem(size: menuButtonSize, title: "Chat", image: UIImage(named: "chat")!, highlightedImage: UIImage(named: "chat")!, backgroundImage: UIImage(named: "chat"), backgroundHighlightedImage: UIImage(named: "chat")) { () -> Void in
            if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "chatID") as? ChatViewController
            {
                self.present(vc, animated: true, completion: nil)
            }
            // Do some action
            print("btn8")
        }//rememberID
        let item9 = ExpandingMenuItem(size: menuButtonSize, title: "Liste", image: UIImage(named: "checked")!, highlightedImage: UIImage(named: "checked")!, backgroundImage: UIImage(named: "checked"), backgroundHighlightedImage: UIImage(named: "checked")) { () -> Void in
            if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "rememberID") as? RememberViewController
            {
                self.present(vc, animated: true, completion: nil)
            }
            // Do some action
            print("btn8")
        }
        
        
        if Auth.auth().currentUser != nil {
            menuButton.addMenuItems([item00, item1, item2, item3, item4, item5, item6, item7, item8, item9])
        }
        else {
            menuButton.addMenuItems([item00, item1, item2, item3, item4, item5, item6, item7, item9])
        }
        NUView.isHidden = true
        if UserDefaults.standard.integer(forKey: "DarkmodeStatus") == 1 {
            view.backgroundColor = UIColor(red:0.05, green:0.05, blue:0.05, alpha:1.0)
            backgroundTitleView.backgroundColor = UIColor(red:0.13, green:0.13, blue:0.13, alpha:1.0)
            HomeworkLabel.textColor = UIColor.white
            LDULabel.textColor = UIColor.white
            UIApplication.shared.statusBarStyle = .lightContent
        }
        if UserDefaults.standard.integer(forKey: "DarkmodeStatus") == 0 {
            view.backgroundColor = UIColor.white
            backgroundTitleView.backgroundColor = UIColor(red:0.97, green:0.97, blue:0.97, alpha:0.8)
            HomeworkLabel.textColor = UIColor.black
            LDULabel.textColor = UIColor.black
            UIApplication.shared.statusBarStyle = .default
        }
        
        // Do any additional setup after loading the view, typically from a nib.
       
        Fabric.sharedSDK().debug = true
        if LastVC.LastVCV == "hw" {
            LastVC.LastVCV = "0"
            self.tabBarController?.selectedIndex = 0
        }
        let ref: DatabaseReference = Database.database().reference()
       /* Week2Out.setTitle("S: \(Week2Label)", for: .normal)
        Week3Out.setTitle("S: \(Week3Label)", for: .normal)
        Week4Out.setTitle("S: \(Week4Label)", for: .normal)*/
        let token: [String: AnyObject] = [Messaging.messaging().fcmToken!: Messaging.messaging().fcmToken as AnyObject]
       // self.postToken(Token: token)
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
       return UIStatusBarStyle(rawValue: SettingsViewController.GLSEV.DarkmodeVar)!
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func push(_ push: MSPush!, didReceive pushNotification: MSPushNotification!) {
        let title: String = pushNotification.title ?? ""
        var message: String = pushNotification.message ?? ""
        var customData: String = ""
        for item in pushNotification.customData {
            customData =  ((customData.isEmpty) ? "" : "\(customData), ") + "\(item.key): \(item.value)"
        }
        if (UIApplication.shared.applicationState == .background) {
            NSLog("Notification received in background, title: \"\(title)\", message: \"\(message)\", custom data: \"\(customData)\"");
        } else {
            message =  message + ((customData.isEmpty) ? "" : "\n\(customData)")
            
            let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .cancel))
            
            // Show the alert controller.
            self.present(alertController, animated: true, completion: nil)
        }
    }
    func playTutorial() {
       /* if let SiriShortcutTUTO = Bundle.main.path(forResource: "KlassenApp3.0Video2", ofType: "mov") {
            let SiriShortcutVideo = AVPlayer(url: URL(fileURLWithPath: SiriShortcutTUTO))
            let SiriShortcutPlayer = AVPlayerViewController()
            SiriShortcutPlayer.player = SiriShortcutVideo
            
            present(SiriShortcutPlayer, animated: true, completion: {
                SiriShortcutVideo.play()
                UserDefaults.standard.set("alreadysaw", forKey: "Intro3.0")
            })
        }*/
    }
    override func viewDidAppear(_ animated: Bool) {
         FirstViewController.LastVC.Cheat1 = 0
        if let tabItems = tabBarController?.tabBar.items {
            // In this case we want to modify the badge number of the third tab:
            let tabItem = tabItems[4]
            tabItem.badgeValue = nil
        }
        
        /*if UserDefaults.standard.string(forKey: "PasscodeUpdate") != "true" {
            Cheat1(title: "Neues (wichtiges) Update!", message: "Der Login wurde verändert. Der Pincode lautet: 1907")
            UserDefaults.standard.set("true", forKey: "PasscodeUpdate")
        }*/
        
        var ref: DatabaseReference!
        
        ref = Database.database().reference()
        ref.child("standardData").child("LDU").observeSingleEvent(of: .value) { (LDUCSnap) in
            let LDUCLE = LDUCSnap.value as? String
            self.LDULabel.text = "Letztes Datenbankupdate: " + LDUCLE!
        }
        
        NUView.isHidden = true
        if UserDefaults.standard.integer(forKey: "Checker") != 1 && UserDefaults.standard.string(forKey: "TEALOGGER") != "tea" && UserDefaults.standard.string(forKey: "EDITOR") != "1" {
            if Auth.auth().currentUser == nil {
                do {
                    try Auth.auth().signOut()
                    self.performSegue(withIdentifier: "homeworktologinsegue", sender: nil)
                } catch let signOutError as NSError {
                    print ("Error signing out: %@", signOutError)
                }
            }
            
        }
        if LastVC.LastVCV == "test" {
            LastVC.LastVCV = "0"
            self.tabBarController?.selectedIndex = 1
        }
        if LastVC.LastVCV == "infos" {
            LastVC.LastVCV = "0"
            self.tabBarController?.selectedIndex = 4
        }
        if LastVC.LastVCV == "settings" {
            LastVC.LastVCV = "0"
            self.tabBarController?.selectedIndex = 4
        }
        if LastVC.LastVCV == "TimeTable" {
            LastVC.LastVCV = "0"
            self.tabBarController?.selectedIndex = 4
        }
        if LastVC.LastVCV == "AddNote" {
            LastVC.LastVCV = "0"
            self.tabBarController?.selectedIndex = 3
        }
        if LastVC.LastVCV == "UpdateCenter" {
            LastVC.LastVCV = "0"
            self.tabBarController?.selectedIndex = 4
        }
        
        if LastVC.ShortDirect == "hw1" {
            LastVC.ShortDirect = "0"
            self.performSegue(withIdentifier: "Week1Short", sender: nil)
        }
        if LastVC.ShortDirect == "NextTest" {
            self.performSegue(withIdentifier: "FirstTestShort", sender: nil)
        }
        if LastVC.ShortDirect == "TimeTableShort" {
            self.performSegue(withIdentifier: "hwtoTTshort", sender: nil)
        }
        var bundleID = Bundle.main.bundleIdentifier as! String
       /* if bundleID == "com.adrianbaumgart.KlassenAppDREA1234" {
       ref.child("standardData").child("iosCurrentVer").child("versionnumber").observeSingleEvent(of: .value) { (NewestBuildDB) in
            var NewestBuildDBLE = NewestBuildDB.value as? String
            let dictionary = Bundle.main.infoDictionary!
            let versionCurrent = dictionary["CFBundleShortVersionString"] as! String
            
            if versionCurrent.compare(NewestBuildDBLE!, options: .numeric) == .orderedAscending {
                if let tabItems = self.tabBarController?.tabBar.items {
                    let tabItem = tabItems[4]
                    tabItem.badgeValue = "1"
                }
                if LastVC.UpdateReminderSession != "1" {
                    var NewestBuildDBLES = NewestBuildDB.value as! String
                    LastVC.NEWUPDATEVERDB = NewestBuildDBLES
                    let introPage = FirstViewController.bulletinNWUP()
                    self.bulletinManager = BLTNItemManager(rootItem: introPage)
                    self.bulletinManager.showBulletin(above: self)
                    /*while LastVC.showUCC == "0" {
                        if LastVC.showUC == "1" {
                            LastVC.showUCC == "1"
                            self.performSegue(withIdentifier: "gotoupdatecenter", sender: nil)
                        }
                    }
                    
                //self.newUpdatealert(title: "Neues Update", message: "Es gibt eine neue Version der App (Version \(NewestBuildDBLES))")
                }*/
            }
        }
        }
        }
        if bundleID == "com.adrianbaumgart.KlassenAppDREA1234-beta" {
        ref.child("standardData").child("iosBetaVersion").observeSingleEvent(of: .value) { (BetaBuildDB) in
            var BetaBuildDBLE = BetaBuildDB.value as? String
            let dictionary = Bundle.main.infoDictionary!
            let versionCurrent = dictionary["CFBundleShortVersionString"] as! String
            
            if versionCurrent.compare(BetaBuildDBLE!, options: .numeric) == .orderedAscending {
                if LastVC.UpdateReminderSession != "1" {
                    var BetaBuildDBLES = BetaBuildDB.value as! String
                    LastVC.NEWUPDATEBETA = BetaBuildDBLES
                    let betaVB = FirstViewController.bulletinNWUPBeta()
                    self.betaVersionAVBullet = BLTNItemManager(rootItem: betaVB)
                    self.betaVersionAVBullet.showBulletin(above: self)
                
                    //self.newUpdatealert(title: "Neues Update", message: "Es gibt eine neue Version der App (Version \(NewestBuildDBLES))")
                }
            }
        }
        }*/
      /* if bundleID == "com.adrianbaumgart.KlassenAppDREA1234" {
        if UserDefaults.standard.string(forKey: "FirstLaunch2.0") != "1" {
            let ChangelogUpdate = FirstViewController.bulletinWelcomeNV()
            self.bulletinManagerChangelog = BLTNItemManager(rootItem: ChangelogUpdate)
            self.bulletinManagerChangelog.showBulletin(above: self)
        }
        }
        if bundleID == "com.adrianbaumgart.KlassenAppDREA1234-beta" {
            if UserDefaults.standard.string(forKey: "FirstLaunchBeta1.3.2") != "1" {
                let ChangelogUpdateBeta = FirstViewController.bulletinWelcomeNVBeta()
                self.bulletinManagerChangelogBeta = BLTNItemManager(rootItem: ChangelogUpdateBeta)
                self.bulletinManagerChangelogBeta.showBulletin(above: self)
            }
        }*/
    
        
      /*  let date = Date()
        let calendar = Calendar.current
        
        let currentday = calendar.component(.weekday, from: date)
        
        print(currentday) */
        
     /* So = 1
        Mo = 2
        Di = 3
        Mi = 4
        Do = 5
        Fr = 6
        Sa = 7 */
        
        
           
        
        
       // if LoginViewController.GlobalVariables.LoggedInChecker == "0" {
            //Perform Segue to Login
          //  self.performSegue(withIdentifier: "homeworktologinsegue", sender: nil)
        //}
        
        
        
      /*  ref.child("standardData").child("iosUpdateAv").observeSingleEvent(of: .value) { (NewUpdateSnap) in
            let NewUpdateLE = NewUpdateSnap.value as? Int
            if NewUpdateLE! > LastVC.CurrentVersion {
                self.newUpdatealert(title: "Neues Update", message: "Es ist ein neues Update verfügbar. Wir empfehlen es zu installieren.")
            }
        } */
        
        ref.child("homework").child("Week1").child("Datum").observeSingleEvent(of: .value) { (Week1DatumSnap) in
            let Week1DatumLE = Week1DatumSnap.value as? String
            UserDefaults.standard.set(Week1DatumLE, forKey: "UDW1Btn")
            self.Week1Out.setTitle(Week1DatumLE, for: .normal)
        }
        ref.child("homework").child("Week2").child("Datum").observeSingleEvent(of: .value) { (Week2DatumSnap) in
            let Week2DatumLE = Week2DatumSnap.value as? String
            UserDefaults.standard.set(Week2DatumLE, forKey: "UDW2Btn")
            self.Week2Out.setTitle(Week2DatumLE, for: .normal)
        }
        ref.child("homework").child("Week3").child("Datum").observeSingleEvent(of: .value) { (Week3DatumSnap) in
            let Week3DatumLE = Week3DatumSnap.value as? String
            UserDefaults.standard.set(Week3DatumLE, forKey: "UDW3Btn")
            self.Week3Out.setTitle(Week3DatumLE, for: .normal)
        }
        ref.child("homework").child("Week4").child("Datum").observeSingleEvent(of: .value) { (Week4DatumSnap) in
            let Week4DatumLE = Week4DatumSnap.value as? String
            UserDefaults.standard.set(Week4DatumLE, forKey: "UDW4Btn")
            self.Week4Out.setTitle(Week4DatumLE, for: .normal)
        }
        
        ref.child("warnings").child("dbchange").observeSingleEvent(of: .value) { (databasechange) in
            let databasechangeLE = databasechange.value as? String
            if databasechangeLE == "active" {
                let DatabaseUpdating = NotificationBanner(title: "Datennbankupdate", subtitle: "Die Datenbank wird momentan aktualisiert.", style: .warning)
                DatabaseUpdating.show()
            }
        }
        
        ref.child("warnings").child("custom").child("message_show").observeSingleEvent(of: .value) { (warningmessageappearance) in
            LastVC.warningmessageappearanceLE = (warningmessageappearance.value as? String)!
            let warn = warningmessageappearance.value as? String
            if warn == "yes" {
                ref.child("warnings").child("custom").child("title").observeSingleEvent(of: .value) { (warningmessageTitle) in
                    LastVC.warningmessageTitleLE = (warningmessageTitle.value as? String)!
                }
                ref.child("warnings").child("custom").child("type").observeSingleEvent(of: .value) { (warningmessageType) in
                    LastVC.warningmessageTypeLE = (warningmessageType.value as? String)!
                }
                ref.child("warnings").child("custom").child("message_short").observeSingleEvent(of: .value) { (warningmessageShort) in
                    LastVC.warningmessageShortLE = (warningmessageShort.value as? String)!
                }
                ref.child("warnings").child("custom").child("message_long").observeSingleEvent(of: .value) { (warningmessageLong) in
                    LastVC.warningmessageLongLE = (warningmessageLong.value as? String)!
                }
                ref.child("warnings").child("custom").child("message_long_info_true").observeSingleEvent(of: .value) { (warningmessageLongAppear) in
                    LastVC.warningmessageLongAppearLE = (warningmessageLongAppear.value as? String)!
                }
                
                if LastVC.warningmessageTypeLE == "success" {
                    let custombannersu = NotificationBanner(title: "\(LastVC.warningmessageTitleLE)", subtitle: "\(LastVC.warningmessageShortLE)", style: .success)
                    if LastVC.warningmessageLongAppearLE == "yes" {
                        custombannersu.onTap = {
                            self.performSegue(withIdentifier: "moreinfoswarnsegue", sender: nil)
                        }
                    }
                    custombannersu.show()
                }
                if LastVC.warningmessageTypeLE == "info" {
                    let custombannerin = NotificationBanner(title: "\(LastVC.warningmessageTitleLE)", subtitle: "\(LastVC.warningmessageShortLE)", style: .info)
                    if LastVC.warningmessageLongAppearLE == "yes" {
                        custombannerin.onTap = {
                            self.performSegue(withIdentifier: "moreinfoswarnsegue", sender: nil)
                        }
                    }
                    custombannerin.show()
                }
                if LastVC.warningmessageTypeLE == "warning" {
                    let custombannerwa = NotificationBanner(title: "\(LastVC.warningmessageTitleLE)", subtitle: "\(LastVC.warningmessageShortLE)", style: .warning)
                    if LastVC.warningmessageLongAppearLE == "yes" {
                        custombannerwa.onTap = {
                            self.performSegue(withIdentifier: "moreinfoswarnsegue", sender: nil)
                        }
                    }
                    custombannerwa.show()
                }
                if LastVC.warningmessageTypeLE == "danger" {
                    let custombannerda = NotificationBanner(title: "\(LastVC.warningmessageTitleLE)", subtitle: "\(LastVC.warningmessageShortLE)", style: .danger)
                    if LastVC.warningmessageLongAppearLE == "yes" {
                        custombannerda.onTap = {
                            self.performSegue(withIdentifier: "moreinfoswarnsegue", sender: nil)
                        }
                    }
                    custombannerda.show()
                }
                
            }
            
        }
      /*  if LastVC.warningmessageappearanceLE == "yes" {
            ref.child("warnings").child("custom").child("title").observeSingleEvent(of: .value) { (warningmessageTitle) in
                LastVC.warningmessageTitleLE = (warningmessageTitle.value as? String)!
            }
            ref.child("warnings").child("custom").child("type").observeSingleEvent(of: .value) { (warningmessageType) in
                LastVC.warningmessageTypeLE = (warningmessageType.value as? String)!
            }
            ref.child("warnings").child("custom").child("message_short").observeSingleEvent(of: .value) { (warningmessageShort) in
                LastVC.warningmessageShortLE = (warningmessageShort.value as? String)!
            }
            ref.child("warnings").child("custom").child("message_long").observeSingleEvent(of: .value) { (warningmessageLong) in
                LastVC.warningmessageLongLE = (warningmessageLong.value as? String)!
            }
            ref.child("warnings").child("custom").child("message_long_info_true").observeSingleEvent(of: .value) { (warningmessageLongAppear) in
                LastVC.warningmessageLongAppearLE = (warningmessageLongAppear.value as? String)!
            }
            
            if LastVC.warningmessageTypeLE == "success" {
                let custombannersu = NotificationBanner(title: "\(LastVC.warningmessageTitleLE)", subtitle: "\(LastVC.warningmessageShortLE)", style: .success)
                if LastVC.warningmessageLongAppearLE == "yes" {
                    custombannersu.onTap = {
                        self.performSegue(withIdentifier: "moreinfoswarnsegue", sender: nil)
                    }
                }
                custombannersu.show()
            }
            if LastVC.warningmessageTypeLE == "info" {
                let custombannerin = NotificationBanner(title: "\(LastVC.warningmessageTitleLE)", subtitle: "\(LastVC.warningmessageShortLE)", style: .info)
                if LastVC.warningmessageLongAppearLE == "yes" {
                    custombannerin.onTap = {
                        self.performSegue(withIdentifier: "moreinfoswarnsegue", sender: nil)
                    }
                }
                custombannerin.show()
            }
            if LastVC.warningmessageTypeLE == "warning" {
                let custombannerwa = NotificationBanner(title: "\(LastVC.warningmessageTitleLE)", subtitle: "\(LastVC.warningmessageShortLE)", style: .warning)
                if LastVC.warningmessageLongAppearLE == "yes" {
                    custombannerwa.onTap = {
                        self.performSegue(withIdentifier: "moreinfoswarnsegue", sender: nil)
                    }
                }
                custombannerwa.show()
            }
            if LastVC.warningmessageTypeLE == "danger" {
                let custombannerda = NotificationBanner(title: "\(LastVC.warningmessageTitleLE)", subtitle: "\(LastVC.warningmessageShortLE)", style: .danger)
                if LastVC.warningmessageLongAppearLE == "yes" {
                    custombannerda.onTap = {
                        self.performSegue(withIdentifier: "moreinfoswarnsegue", sender: nil)
                    }
                }
                custombannerda.show()
            }
            
        }*/
       /* while(true) {
            if LastVC.PLAYTUTO == "1" {
                playTutorial()
            }
        }*/
    }
    
    
    static func bulletinNWUP() -> BLTNPageItem {
        var ref: DatabaseReference!
        
        ref = Database.database().reference()
        ref.child("standardData").child("iosCurrentVer").child("versionnumber").observeSingleEvent(of: .value) { (NewestBuildDB) in
            var NewestBuildDBLES = NewestBuildDB.value as! String
            LastVC.NEWUPDATEVERDB = NewestBuildDBLES
        }
            let NewestBuildDBLE = LastVC.NEWUPDATEVERDB
            let nUABpage = BLTNPageItem(title: "Neues Update verfügbar")
            nUABpage.image = UIImage(named: "DownloadCloud")
            nUABpage.descriptionText = "Die Version \(NewestBuildDBLE) ist verfügbar. Schau im Updatecenter vorbei für mehr Informationen"
            nUABpage.actionButtonTitle = "Ok"
            nUABpage.actionHandler = { (item: BLTNActionItem) in
                LastVC.UpdateReminderSession = "1"
                item.manager?.dismissBulletin()
                //updatecenterid
                /*let mainStoryboardIpad : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let initialViewControlleripad : UIViewController = mainStoryboardIpad.instantiateViewController(withIdentifier: "updatecenterid") as UIViewController
                self.window = UIWindow(frame: UIScreen.main.bounds)
                self.window?.rootViewController = initialViewControlleripad
                self.window?.makeKeyAndVisible()*/
        }
        nUABpage.dismissalHandler = { (item: BLTNItem) in
             LastVC.UpdateReminderSession = "1"
        }
        return nUABpage
    }
    
    func showUC() {
        self.performSegue(withIdentifier: "gotoupdatecenter", sender: nil)
    }
    static func bulletinNWUPBeta() -> BLTNPageItem {
        var ref: DatabaseReference!
        
        ref = Database.database().reference()
        ref.child("standardData").child("iosBetaVersion").observeSingleEvent(of: .value) { (BetaBuildDB) in
            var BetaBuildDBLES = BetaBuildDB.value as! String
            LastVC.NEWUPDATEBETA = BetaBuildDBLES
        }
        let BetaBuildDBLE = LastVC.NEWUPDATEBETA
        let nUABetapage = BLTNPageItem(title: "Neues Betaupdate verfügbar")
        nUABetapage.image = UIImage(named: "DownloadCloud")
        nUABetapage.descriptionText = "Die Betaversion \(BetaBuildDBLE) ist verfügbar. Du kannst sie jetzt herunterladen oder diese Nachricht bis zum nächsten Neustart der App schließen."
        nUABetapage.actionButtonTitle = "Installieren"
        nUABetapage.alternativeButtonTitle = "Nicht jetzt"
        nUABetapage.isDismissable = false
        nUABetapage.actionHandler = { (item: BLTNActionItem) in
            UIApplication.shared.openURL(NSURL(string: "https://klassenappd-team.github.io/iosbeta.html")! as URL)
        }
        nUABetapage.alternativeHandler = { (item: BLTNItem) in
            LastVC.UpdateReminderSession = "1"
            item.manager?.dismissBulletin()
        }
        /*nUABetapage.dismissalHandler = { (item: BLTNItem) in
            LastVC.UpdateReminderSession = "1"
        }*/
        return nUABetapage
    }
    
    static func bulletinWelcomeNV() -> BLTNPageItem {
        let nVBpage = BLTNPageItem(title: "Version 2.0")
        nVBpage.descriptionText = "Neue Funktionen in Version 1.4:\n-Neue Funktion: Hausaufgaben bis morgen\n-Tab für Arbeiten & Termine umbennant"
        nVBpage.isDismissable = false
        nVBpage.actionButtonTitle = "Weiter"
        nVBpage.actionHandler = { (item: BLTNItem) in
            item.manager?.displayNextItem()
        }
        nVBpage.next = bulletinWelcomeNVThird()
        /*nVBpage.dismissalHandler = { (item: BLTNItem) in
            UserDefaults.standard.set("1", forKey: "FirstLaunch1.3.2")
        }*/
        return nVBpage
    }
    
    static func bulletinWelcomeNVSecond() -> BLTNPageItem {
        let nVB2page = BLTNPageItem(title: "Feedback")
        //nVB2page.image = UIImage(named: "siriIcon")
        nVB2page.descriptionText = "Die iOS App ist schon seit einigen Wochen verfügbar. Mich interessiert eure Meinung zur iOS App, weswegen ich einen kleinen Feedbackbogen erstellt habe. Ich bitte euch, diesen auszufüllen. Der Link ist auch jederzeit in den mehreren Optionen verfügbar."
        nVB2page.isDismissable = false
        nVB2page.actionButtonTitle = "Formular ausfüllen"
        nVB2page.alternativeButtonTitle = "Nicht jetzt"
        nVB2page.actionHandler = { (item: BLTNItem) in
            /*if let SiriShortcutTUTO = Bundle.main.path(forResource: "SiriShortcutTutorial", ofType: "mp4") {
                let SiriShortcutVideo = AVPlayer(url: URL(fileURLWithPath: SiriShortcutTUTO))
                let SiriShortcutPlayer = AVPlayerViewController()
                SiriShortcutPlayer.player = SiriShortcutVideo
                nVB2page.manager?.present(SiriShortcutPlayer, animated: true, completion: {
                    SiriShortcutVideo.play()
                    item.manager?.displayNextItem()
                })
            }*/
            UIApplication.shared.openURL(NSURL(string: "https://goo.gl/forms/8scxGoMvyGfk7Tha2")! as URL)
            item.manager?.displayNextItem()
        }
        nVB2page.alternativeHandler = { (item: BLTNItem) in
            item.manager?.displayNextItem()
        }
        nVB2page.next = bulletinWelcomeNVThird()
        return nVB2page
    }
    static func bulletinWelcomeNVThird() -> BLTNPageItem {
        let nVB3page = BLTNPageItem(title: "Fertig")
        nVB3page.image = UIImage(named: "Check")
        nVB3page.descriptionText = "Du kannst die App nun verwenden"
        nVB3page.actionButtonTitle = "Ok"
        nVB3page.actionHandler = { (item: BLTNItem) in
            UserDefaults.standard.set("1", forKey: "FirstLaunch2.0")
            item.manager?.dismissBulletin()
        }
        return nVB3page
    }
    static func bulletinWelcomeNVBeta() -> BLTNPageItem {
        let nVBetapage = BLTNPageItem(title: "Version 1.3.2 Beta")
        nVBetapage.descriptionText = "Neue Funktionen in Version 1.3.2 Beta:\nNichts. Noch hat die Beta alle Funktionen, die auch die offizielle App hat."
        nVBetapage.isDismissable = true
        nVBetapage.dismissalHandler = { (item: BLTNItem) in
            UserDefaults.standard.set("1", forKey: "FirstLaunchBeta1.3.3")
        }
        return nVBetapage
    }
    
        func newUpdatealert (title: String, message: String) {
        let nUA = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        
        nUA.addAction(UIAlertAction(title: "Installieren", style: UIAlertAction.Style.default, handler: { (nUAInstall) in
            UIApplication.shared.openURL(NSURL(string: "https://klassenappd-team.github.io/iosdownload.html")! as URL)
        }))
            nUA.addAction(UIAlertAction(title: "Dieses mal nicht mehr fragen", style: UIAlertAction.Style.default, handler: { (nUACanel2) in
                LastVC.UpdateReminderSession = "1"
                nUA.dismiss(animated: true, completion: nil)
            }))
        self.present(nUA, animated: true, completion: nil)
    }
    func Cheat1 (title: String, message: String) {
        let C1 = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        
        C1.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: { (nUACanel2) in
            C1.dismiss(animated: true, completion: nil)
        }))
        self.present(C1, animated: true, completion: nil)
    }
    
    struct LastVC {
       static var LastVCV = "0"
        static var ShortDirect = "0"
        static var UpdateReminderSession = "0"
        static var NEWUPDATEVERDB = "1"
        static var NEWUPDATEBETA = "1"
        static var PLAYTUTO = "0"
        static var warningmessageTitleLE = "0"
        static var warningmessageTypeLE = "0"
        static var warningmessageShortLE = "0"
        static var warningmessageLongLE = "0"
        static var warningmessageLongAppearLE = "0"
        static var warningmessageappearanceLE = "0"
        static var showUC = "0"
        static var showUCC = "0"
        static var Cheat1 = 0
    }

 }
