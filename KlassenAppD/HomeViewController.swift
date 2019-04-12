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

class HomeViewController: UIViewController {
    
    var timer: Timer!
    
    lazy var bulletinManager: BLTNItemManager = {
        let introPage = FirstViewController.bulletinNWUP()
        return BLTNItemManager(rootItem: introPage)
    }()

    let TextSizeAttr = [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 14)]
    
    @IBOutlet weak var TestLabel: UILabel!
    @IBOutlet weak var HomeTitle: UILabel!
    @IBOutlet weak var HomeTitleBackground: UIView!
    @IBOutlet weak var HomeTV: UITextView!
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
        let item9 = ExpandingMenuItem(size: menuButtonSize, title: "Liste", image: UIImage(named: "checked")!, highlightedImage: UIImage(named: "checked")!, backgroundImage: UIImage(named: "checked"), backgroundHighlightedImage: UIImage(named: "checked")) { () -> Void in
            if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "rememberID") as? RememberViewController
            {
                self.present(vc, animated: true, completion: nil)
            }
            // Do some action
            print("btn8")
        }
        
        
        if Auth.auth().currentUser != nil {
            menuButton.addMenuItems([item0, item1, item2, item3, item4, item5, item6, item7, item9])
        }
        else {
            menuButton.addMenuItems([item0, item1, item2, item3, item4, item5, item6, item7, item9])
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
        var titles = HomeViewController.Titles.self
        let TitleSizeAttr = [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 20)]
        HomeViewController.Titles.Habm = NSMutableAttributedString(string: "Hausaufgaben bis morgen: ", attributes: TitleSizeAttr)
       /* titles.HabmTime = NSMutableAttributedString(string: "HABM-Updatezeit", attributes: TitleSizeAttr)
        titles.News = NSMutableAttributedString(string: "Neuigkeiten", attributes: <#T##[NSAttributedString.Key : Any]?#>)*/
        var ref: DatabaseReference!
        
        ref = Database.database().reference()
        
        ref.child("standardData").child("LDU").observeSingleEvent(of: .value) { (LDUSnap) in
            let LDUSNAP = LDUSnap.value as? String
            HomeViewController.HomeVar.LDU = LDUSNAP!
          //  HomeViewController.HomeVar.LDU = NSMutableAttributedString(string: LDUSNAP!, attributes: self.TextSizeAttr)
        }
        ref.child("homework").child("bismorgen").child("hausaufgaben").observeSingleEvent(of: .value) { (HABMINFOSNAP) in
            let HABMINFOLE = HABMINFOSNAP.value as? String
            HomeViewController.HomeVar.HabmText = HABMINFOLE!
           // HomeViewController.HomeVar.HabmText = NSMutableAttributedString(string: HABMINFOLE!, attributes: self.TitleSizeAttr)
        }
        ref.child("homework").child("bismorgen").child("updatetime").observeSingleEvent(of: .value) { (HABMLDUSNAP) in
            let HABMLDULE = HABMLDUSNAP.value as! String
            HomeViewController.HomeVar.HabmTime = HABMLDULE
            //HomeViewController.HomeVar.HabmTime = NSMutableAttributedString(string: HABMLDULE, attributes: self.TextSizeAttr)
        }
        ref.child("news").child("news1").observeSingleEvent(of: .value) { (News1Snap) in
            let NEWS1SNAP = News1Snap.value as? String
            HomeViewController.HomeVar.News1 = NEWS1SNAP!
            //HomeViewController.HomeVar.News1 = NSMutableAttributedString(string: NEWS1SNAP!, attributes: self.TextSizeAttr)
        }
        ref.child("news").child("newsL").observeSingleEvent(of: .value) { (NewsLSnap) in
            let NEWSLSNAP = NewsLSnap.value as? String
            HomeViewController.HomeVar.NewsL = NEWSLSNAP!
            //HomeViewController.HomeVar.NewsL = NSMutableAttributedString(string: NEWSLSNAP!, attributes: self.TextSizeAttr)
        }
        ref.child("standardData").child("iosCurrentVer").child("versionnumber").observeSingleEvent(of: .value) { (NewestBuildDB) in
            let NEWESTBUILD = NewestBuildDB.value as? String
            HomeViewController.HomeVar.NewestVersion = NEWESTBUILD!
        }
        let dictionary = Bundle.main.infoDictionary!
        let versionCurrent = dictionary["CFBundleShortVersionString"] as! String
        
        if versionCurrent.compare(HomeViewController.HomeVar.NewestVersion, options: .numeric) == .orderedAscending {
            HomeViewController.HomeVar.NewVersionAvailable = "Neues Update verfügbar. Neuste Version: \(HomeViewController.HomeVar.NewestVersion)"
            //HomeViewController.HomeVar.NewVersionAvailable = NSMutableAttributedString(string: "Neues Update verfügbar. Neuste Version: \(HomeViewController.HomeVar.NewestVersion)", attributes: self.TextSizeAttr)
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
        
        ref.child("arbeiten").child("Arbeit1").child("label").observeSingleEvent(of: .value) { (Test1LabelSnap) in
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
                    self.bulletinManager.showBulletin(above: self)
                }
            }
        }
        let attr = [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 50)]
        let string1 = "hi1"
        TestLabel.text = string1
        //sleep(5000)
        let string2 = NSMutableAttributedString(string: "hi2", attributes: attr)
        TestLabel.attributedText = string2

       // if HomeVar.HabmTime != "" && HomeVar.HabmText != "" && HomeVar.NextEvent != "" && HomeVar.News1 != "" && HomeVar.NewsL != "" && HomeVar.NewestVersion != "" && HomeVar.NewVersionAvailable != "" && HomeVar.LDU != ""
    }
    
    @objc func setToTV() {
        if HomeVar.essenDate != "" && HomeVar.essenHeute != "" && HomeVar.HabmText != "" && HomeVar.HabmTime != "" && HomeVar.LDU != "" && HomeVar.News1 != "" && HomeVar.NewsL != "" && HomeVar.NextEvent != "" {
        HomeTV.text = "Hausaufgaben bis morgen:\n\(HomeViewController.HomeVar.HabmText)\n\nNeuigkeiten:\n-Administratoren: \(HomeViewController.HomeVar.News1)\n\n-Lehrer: \(HomeViewController.HomeVar.NewsL)\n\nNächstes Event: \(HomeViewController.HomeVar.NextEvent)\n\nEssen heute:\n\(HomeViewController.HomeVar.essenHeute)\n\nUpdate: \(HomeViewController.HomeVar.NewVersionAvailable)\n\nHABM-Updatezeit: \(HomeViewController.HomeVar.HabmTime)\nSpeiseplan-Updatezeit: \(HomeViewController.HomeVar.essenDate)\nLDU: \(HomeViewController.HomeVar.LDU)"
            timer.invalidate()
        }
    }
    
    static func bulletinNWUP() -> BLTNPageItem {
        var ref: DatabaseReference!
        
        ref = Database.database().reference()
        ref.child("standardData").child("iosCurrentVer").child("versionnumber").observeSingleEvent(of: .value) { (NewestBuildDB) in
            var NewestBuildDBLES = NewestBuildDB.value as! String
            HomeViewController.HomeVar.NewestVersion = NewestBuildDBLES
        }
        let NewestBuildDBLE = HomeViewController.HomeVar.NewestVersion
        let nUABpage = BLTNPageItem(title: "Neues Update verfügbar")
        nUABpage.image = UIImage(named: "DownloadCloud")
        nUABpage.descriptionText = "Ein neues Update ist verfügbar. Schau im Updatecenter für mehr Informationen vorbei."
        nUABpage.actionButtonTitle = "Ok"
        nUABpage.actionHandler = { (item: BLTNActionItem) in
            HomeVar.UpdateReminderSession = "1"
            item.manager?.dismissBulletin()
            //updatecenterid
            /*let mainStoryboardIpad : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
             let initialViewControlleripad : UIViewController = mainStoryboardIpad.instantiateViewController(withIdentifier: "updatecenterid") as UIViewController
             self.window = UIWindow(frame: UIScreen.main.bounds)
             self.window?.rootViewController = initialViewControlleripad
             self.window?.makeKeyAndVisible()*/
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
