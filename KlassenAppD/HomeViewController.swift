//
//  HomeViewController.swift
//  KlassenAppD
//
//  Created by Adrian Baumgart on 19.03.19.
//  Copyright © 2019 Adrian Baumgart. All rights reserved.
//

import UIKit
import Firebase
import ExpandingMenu
import BLTNBoard
import WhatsNewKit
import Panels
import SAConfettiView
import EZAlertController
import NVActivityIndicatorView

class HomeViewController: UIViewController {
    lazy var panelManager = Panels(target: self)
    var timer: Timer!
    var disappearUpdate: Timer!
    var time1 = 0
    
    lazy var bulletinManager: BLTNItemManager = {
        let introPage = FirstViewController.bulletinNWUP()
        return BLTNItemManager(rootItem: introPage)
    }()
    //var loader: NVActivityIndicatorView;
    var loader : NVActivityIndicatorView!
    
    
    let TextSizeAttr = [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 14)]
    
    @IBOutlet weak var TitleBar: UIView!
    @IBOutlet weak var TestLabel: UILabel!
    @IBOutlet weak var HomeTitle: UILabel!
    @IBOutlet weak var HomeTitleBackground: UIView!
    @IBOutlet weak var HomeTV: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
    loader = NVActivityIndicatorView(frame: CGRect(x: self.view.center.x-25, y: self.view.center.y-25, width: 50, height: 50))
        //loader.type = .ballRotateChase
        loader.type = .ballPulseSync
        loader.color = UIColor.red
        view.addSubview(loader)
        loader.startAnimating()
        
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
        
        let item0 = ExpandingMenuItem(size: menuButtonSize, title: "Hausaufgaben", image: UIImage(named: "book")!, highlightedImage: UIImage(named: "book")!, backgroundImage: UIImage(named: "book"), backgroundHighlightedImage: UIImage(named: "book")) { () -> Void in
            if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "HomeWorkShortID") as? FirstViewController
            {
                self.present(vc, animated: true, completion: nil)
            }
            print("btn1")
        }
        let item1 = ExpandingMenuItem(size: menuButtonSize, title: "Arbeiten", image: UIImage(named: "ball_point_pen")!, highlightedImage: UIImage(named: "ball_point_pen")!, backgroundImage: UIImage(named: "ball_point_pen"), backgroundHighlightedImage: UIImage(named: "ball_point_pen")) { () -> Void in
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
            print("btn8")
        }
        
        
        if Auth.auth().currentUser != nil {
            menuButton.addMenuItems([item0, item1, item2, item3, item4, item5, item6, item9])
        }
        else {
            menuButton.addMenuItems([item0, item1, item2, item3, item4, item5, item6, item9])
        }


        if UserDefaults.standard.integer(forKey: "DarkmodeStatus") == 1 {
            view.backgroundColor = UIColor(red:0.05, green:0.05, blue:0.05, alpha:1.0)
            HomeTitleBackground.backgroundColor = UIColor(red:0.13, green:0.13, blue:0.13, alpha:1.0)
            HomeTitle.textColor = UIColor.white
            HomeTV.textColor = UIColor.white
            HomeTV.backgroundColor = UIColor(red:0.05, green:0.05, blue:0.05, alpha:1.0)
            UIApplication.shared.statusBarStyle = .lightContent
        }
        if UserDefaults.standard.integer(forKey: "DarkmodeStatus") == 0 {
            view.backgroundColor = UIColor.white
            HomeTitleBackground.backgroundColor = UIColor(red:0.97, green:0.97, blue:0.97, alpha:0.8)
            HomeTitle.textColor = UIColor.black
            HomeTV.textColor = UIColor.black
            HomeTV.backgroundColor = UIColor.white
            UIApplication.shared.statusBarStyle = .default
        }
        
        
        
        
        //            NSAttributedString.Key.foregroundColor: UIColor.white
    //    var titles = HomeViewController.Titles.self
        let TitleSizeAttr = [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 20)]
        HomeViewController.Titles.Habm = NSMutableAttributedString(string: "Hausaufgaben bis morgen: ", attributes: TitleSizeAttr)
       /* titles.HabmTime = NSMutableAttributedString(string: "HABM-Updatezeit", attributes: TitleSizeAttr)
        titles.News = NSMutableAttributedString(string: "Neuigkeiten", attributes: T##[NSAttributedString.Key : Any]?)*/
        var ref: DatabaseReference!
        
        ref = Database.database().reference()
        
        ref.child("standardData").child("birthday1EventStarted").observe(.value) { (birthdaysnap) in
            let BDSnap = birthdaysnap.value as? String
            if BDSnap == "1" {
                if UserDefaults.standard.integer(forKey: "FirstBD") != 1 {
                    let confettiView = SAConfettiView(frame: self.view.bounds)
                    //frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 116)
                    confettiView.type = .Confetti
                    self.view.addSubview(confettiView)
                    confettiView.startConfetti()
                    DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(4), execute: {
                        // Put your code which should be executed with a delay here
                        confettiView.stopConfetti()
                        confettiView.removeFromSuperview()
                        EZAlertController.alert("Hallo", message: "Entschuldigung für die Störung, aber bitte lies dir die nächsten Nachrichten durch.", acceptMessage: "Weiter") { () -> () in
                            EZAlertController.alert("Nachricht", message: "Diese Woche feiert die KlassenApp ihren ersten Geburtstag.", acceptMessage: "Weiter") { () -> () in
                                EZAlertController.alert("Nachricht", message: "Ich möchte mich bedanken, dass ihr die App seit einem Jahr verwendet.", acceptMessage: "Weiter") { () -> () in
                                    EZAlertController.alert("Nachricht", message: "Ohne euch würde die App nicht dort sein, wo sie jetzt steht.", acceptMessage: "Weiter") { () -> () in
                                        EZAlertController.alert("Nachricht", message: "Jetzt viel Spaß bei der Verwendung der App! Auf ein neues Jahr!")
                                    }
                                }
                            }
                        }
                    })
                    UserDefaults.standard.set(1, forKey: "FirstBD")
                }
                let confettiView2 = SAConfettiView(frame: self.HomeTitleBackground.bounds)
                //frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 116)
                confettiView2.type = .Confetti
                self.HomeTitleBackground.addSubview(confettiView2)
                confettiView2.startConfetti()
            }
        }
        
        ref.child("standardData").child("LDU").observeSingleEvent(of: .value) { (LDUSnap) in
            let LDUSNAP = LDUSnap.value as? String
            HomeViewController.HomeVar.LDU = LDUSNAP!
        }
        ref.child("homework").child("bismorgen").child("hausaufgaben").observeSingleEvent(of: .value) { (HABMINFOSNAP) in
            let HABMINFOLE = HABMINFOSNAP.value as? String
            HomeViewController.HomeVar.HabmText = HABMINFOLE!
        }
        ref.child("homework").child("bismorgen").child("updatetime").observeSingleEvent(of: .value) { (HABMLDUSNAP) in
            let HABMLDULE = HABMLDUSNAP.value as! String
            HomeViewController.HomeVar.HabmTime = HABMLDULE
        }
        ref.child("news").child("news1").observeSingleEvent(of: .value) { (News1Snap) in
            let NEWS1SNAP = News1Snap.value as? String
            HomeViewController.HomeVar.News1 = NEWS1SNAP!
        }
        ref.child("news").child("newsL").observeSingleEvent(of: .value) { (NewsLSnap) in
            let NEWSLSNAP = NewsLSnap.value as? String
            HomeViewController.HomeVar.NewsL = NEWSLSNAP!
        }
        ref.child("standardData").child("iosCurrentVer").child("versionnumber").observeSingleEvent(of: .value) { (NewestBuildDB) in
            let NEWESTBUILD = NewestBuildDB.value as? String
            HomeViewController.HomeVar.NewestVersion = NEWESTBUILD!
        }
        let dictionary = Bundle.main.infoDictionary!
        let versionCurrent = dictionary["CFBundleShortVersionString"] as! String
        
        if versionCurrent.compare(HomeViewController.HomeVar.NewestVersion, options: .numeric) == .orderedAscending {
            HomeViewController.HomeVar.NewVersionAvailable = "Neues Update verfügbar. Neuste Version: \(HomeViewController.HomeVar.NewestVersion)"
        }
        else {
            HomeViewController.HomeVar.NewVersionAvailable = "Kein neues Update"
        }
        
         let date = Date()
         let calendar = Calendar.current
         
         let currentday = calendar.component(.weekday, from: date)
         
         print(currentday)
        
        /* So = 1
         Mo = 2
         Di = 3
         Mi = 4
         Do = 5
         Fr = 6
         Sa = 7 */
        
        if currentday == 2 {
            ref.child("Speiseplan").child("monday").observeSingleEvent(of: .value) { (MondayFoodSnap) in
                let MondayFood = MondayFoodSnap.value as? String
                HomeViewController.HomeVar.essenHeute = MondayFood!
            }
        }
        else if currentday == 3 {
            ref.child("Speiseplan").child("Tuesday").observeSingleEvent(of: .value) { (TuesdayFoodSnap) in
                let TuesdayFood = TuesdayFoodSnap.value as? String
                HomeViewController.HomeVar.essenHeute = TuesdayFood!
            }
        }
        else if currentday == 4 {
            ref.child("Speiseplan").child("Wednesday").observeSingleEvent(of: .value) { (WednesdayFoodSnap) in
                let WednesdayFood = WednesdayFoodSnap.value as? String
                HomeViewController.HomeVar.essenHeute = WednesdayFood!
            }
        }
        else if currentday == 5 {
            ref.child("Speiseplan").child("Thursday").observeSingleEvent(of: .value) { (ThursdayFoodSnap) in
                let ThursdayFood = ThursdayFoodSnap.value as? String
                HomeViewController.HomeVar.essenHeute = ThursdayFood!
            }
        }
        else if currentday == 6 {
            ref.child("Speiseplan").child("Friday").observeSingleEvent(of: .value) { (FridayFoodSnap) in
                let FridayFood = FridayFoodSnap.value as? String
                HomeViewController.HomeVar.essenHeute = FridayFood!
            }
        }
        else if currentday == 7 || currentday == 1 {
            HomeViewController.HomeVar.essenHeute = "Kein Essen heute!"
        }
        
        ref.child("Speiseplan").child("Datum").observeSingleEvent(of: .value) { (FoodDateSnap) in
            let FoodDate = FoodDateSnap.value as? String
            HomeViewController.HomeVar.essenDate = FoodDate!
        }
        
        ref.child("arbeiten").child("nextEvent").observeSingleEvent(of: .value) { (Test1LabelSnap) in
            let TEST1LABELSNAP = Test1LabelSnap.value as? String
            HomeViewController.HomeVar.NextEvent = TEST1LABELSNAP!
            self.timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.setToTV), userInfo: nil, repeats: true)

        }
        
        // Do any additional setup after loading the view.
    }
    
    
    
    override func viewDidAppear(_ animated: Bool) {
        var ref: DatabaseReference!
        
        ref = Database.database().reference()
        ref.child("standardData").child("iosCurrentVer").child("versionnumber").observeSingleEvent(of: .value) { (NewestBuildDB) in
            let NEWESTBUILD = NewestBuildDB.value as? String
            HomeViewController.HomeVar.NewestVersion = NEWESTBUILD!
            let dictionary = Bundle.main.infoDictionary!
            let versionCurrent = dictionary["CFBundleShortVersionString"] as! String
            if versionCurrent.compare(NEWESTBUILD!, options: .numeric) == .orderedAscending {
                //HomeViewController.HomeVar.NewVersionAvailable = NSMutableAttributedString(string: "Neues Update verfügbar. Neuste Version: \(HomeViewController.HomeVar.NewestVersion)", attributes: self.TextSizeAttr)
                if HomeVar.UpdateReminderSession != "1" {
                    //bulletinManager = BLTNItemManager(rootItem: introPage)
                    let panel = UIStoryboard.instantiatePanel(identifier: "PanelMaterial")
                    var panelConfiguration = PanelConfiguration(size: .half)
                    panelConfiguration.animateEntry = true
                    self.disappearUpdate = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.removeUpdateMessage), userInfo: nil, repeats: true)
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        self.panelManager.show(panel: panel, config: panelConfiguration)
                    }
                }
            }
        }
        let attr = [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 20)]
        
        let string1 = "hi1"
        TestLabel.text = string1
        //sleep(5000)
        let string2 = NSMutableAttributedString(string: "hi2", attributes: attr)
        TestLabel.attributedText = string2
        
       // panelConfiguration.animateEntry = true
        let dictionary = Bundle.main.infoDictionary!
        let versionCurrent = dictionary["CFBundleShortVersionString"] as! String
        if UserDefaults.standard.string(forKey: "\(versionCurrent)") != "1" {
            if UserDefaults.standard.integer(forKey: "DarkmodeStatus") == 1 {
                HomeVar.WhatsNewConfig = WhatsNewViewController.Configuration(theme: .darkRed)
            }
            if UserDefaults.standard.integer(forKey: "DarkmodeStatus") == 0 {
                HomeVar.WhatsNewConfig = WhatsNewViewController.Configuration(theme: .whiteRed)
            }
            
            HomeVar.WhatsNewConfig.itemsView.contentMode = .center
            let whatsNew = WhatsNew(
                // The Title
                title: "Version \(versionCurrent)",
                // The features you want to showcase
                items: [
                    WhatsNew.Item(
                        title: "Stundenplan in der Datenbank",
                        subtitle: "Ab jetzt wird der Stundenplan durch die Datenbank aktualisiert.",
                        image: UIImage(named: "icons8-datenbank-export-30")
                    ),
                    WhatsNew.Item(
                        title: "Neue Ladeanimation",
                        subtitle: "Beim Herunterladen von Daten erscheint jetzt eine neue Ladeanimation.",
                        image: UIImage(named: "icons8-aktualisieren-30")
                    ),
                    WhatsNew.Item(
                        title: "Andere",
                        subtitle: "Es wurden noch einige Bugs behoben und kleinere Sachen verändert.",
                        image: UIImage(named: "more")
                    )

                ]
            )
            
            // Initialize WhatsNewViewController with WhatsNew
            let whatsNewViewController = WhatsNewViewController(
                whatsNew: whatsNew,
                configuration: HomeVar.WhatsNewConfig
            )
            
            // Present it
            self.present(whatsNewViewController, animated: true)
            UserDefaults.standard.set("1", forKey: "\(versionCurrent)")
        }
    }
    
    @objc func removeUpdateMessage() {
        if HomeVar.UpdateReminderSession == "1" {
            print("yes")
            panelManager.dismiss()
            disappearUpdate.invalidate()
        }
        else {
            print("no")
        }
    }

    @objc func setToTV() {
        if HomeVar.essenDate != "" && HomeVar.essenHeute != "" && HomeVar.HabmText != "" && HomeVar.HabmTime != "" && HomeVar.LDU != "" && HomeVar.News1 != "" && HomeVar.NewsL != "" && HomeVar.NextEvent != "" {
            let formattedString = NSMutableAttributedString()
            formattedString
                .bold("Hausaufgaben bis morgen:")
                .normal("\n\(HomeViewController.HomeVar.HabmText)\n\n")
                .bold("Neuigkeiten:")
                .normal("\n-Administratoren: \(HomeViewController.HomeVar.News1)\n\n-Lehrer: \(HomeViewController.HomeVar.NewsL)\n\n")
                .bold("Nächstes Event: ")
                .normal("\(HomeViewController.HomeVar.NextEvent)\n\n")
                .bold("Essen heute:")
                .normal("\n\(HomeViewController.HomeVar.essenHeute)\n\n")
                .bold("Update: ")
                .normal("\(HomeViewController.HomeVar.NewVersionAvailable)\n\n")
                .bold("HABM-Updatezeit: ")
                .normal("\(HomeViewController.HomeVar.HabmTime)\n")
                .bold("Speiseplanwoche: ")
                .normal("\(HomeViewController.HomeVar.essenDate)\n")
                .bold("LDU: ")
                .normal("\(HomeViewController.HomeVar.LDU)")
            HomeTV.attributedText = formattedString
            if UserDefaults.standard.integer(forKey: "DarkmodeStatus") == 1 {
                HomeTV.textColor = UIColor.white
                HomeTV.backgroundColor = UIColor(red:0.05, green:0.05, blue:0.05, alpha:1.0)
            }
            if UserDefaults.standard.integer(forKey: "DarkmodeStatus") == 0 {
                HomeTV.textColor = UIColor.black
                HomeTV.backgroundColor = UIColor.white
            }
            timer.invalidate()
            loader.stopAnimating()
        }
    }
    
    func randomString(length: Int) -> String {
        let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890"
        return String((0...length-1).map{_ in letters.randomElement()!})
    }
    
    static func bulletinNWUP() -> BLTNPageItem {
        var ref: DatabaseReference!
        
        ref = Database.database().reference()
        ref.child("standardData").child("iosCurrentVer").child("versionnumber").observeSingleEvent(of: .value) { (NewestBuildDB) in
            let NewestBuildDBLES = NewestBuildDB.value as! String
            HomeViewController.HomeVar.NewestVersion = NewestBuildDBLES
        }
       // let NewestBuildDBLE = HomeViewController.HomeVar.NewestVersion
        let nUABpage = BLTNPageItem(title: "Neues Update verfügbar")
        nUABpage.image = UIImage(named: "DownloadCloud")
        nUABpage.descriptionText = "Ein neues Update ist verfügbar. Schau im Updatecenter für mehr Informationen vorbei."
        nUABpage.actionButtonTitle = "Ok"
        nUABpage.actionHandler = { (item: BLTNActionItem) in
            HomeVar.UpdateReminderSession = "1"
            item.manager?.dismissBulletin()
        }
        nUABpage.dismissalHandler = { (item: BLTNItem) in
            HomeVar.UpdateReminderSession = "1"
        }
        return nUABpage
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    struct HomeVar {
        static var Full = NSMutableAttributedString()
        static var WhatsNewConfig = WhatsNewViewController.Configuration()
        static var essenHeute = ""
        static var essenDate = ""
        static var UpdateReminderSession = "0"
        static var HabmText = ""
        static var HabmTime = ""
        static var NextEvent = ""
        static var Finished = ""
        static var News1 = ""
        static var NewsL = ""
        static var NewestVersion = ""
        static var NewVersionAvailable = ""
        static var LDU = ""
    }
    struct Titles {
        static var Habm = NSMutableAttributedString()
        static var HabmTime = NSMutableAttributedString()
        static var News = NSMutableAttributedString()
        static var NewsAdmin = NSMutableAttributedString()
        static var NewsLehrer = NSMutableAttributedString()
        static var NextEvent = NSMutableAttributedString()
        static var Update = NSMutableAttributedString()
        static var LDU = NSMutableAttributedString()
    }

}

extension NSMutableAttributedString {
    @discardableResult func bold(_ text: String) -> NSMutableAttributedString {
        let attrs: [NSAttributedString.Key: Any] = [
            .font: UIFont(name: "Arial", size: 19)]
        let boldString = NSMutableAttributedString(string:text, attributes: attrs)
        append(boldString)
        
        return self
    }
    
    @discardableResult func normal(_ text: String) -> NSMutableAttributedString {
        let attrs2: [NSAttributedString.Key: Any] = [.font: UIFont(name: "Arial", size: 14)!]
        let normal = NSAttributedString(string: text, attributes: attrs2)
        append(normal)
        
        return self
    }
}
