//
//  HomeViewController.swift
//  KlassenAppD
//
//  Created by Adrian Baumgart on 19.03.19.
//  Copyright © 2019 Adrian Baumgart. All rights reserved.
//

import EZAlertController
import Firebase
import NVActivityIndicatorView
import SAConfettiView
import SCLAlertView
import UIKit
import WhatsNewKit

class HomeViewController: UIViewController {
    var timer: Timer!
    var disappearUpdate: Timer!
    var loader: NVActivityIndicatorView!
    
    let TextSizeAttr = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 14)]
    
    @IBOutlet var DateLabel: UILabel!
    @IBOutlet var TitleBar: UIView!
    @IBOutlet var TestLabel: UILabel!
    @IBOutlet var HomeTitle: UILabel!
    @IBOutlet var HomeTitleBackground: UIView!
    @IBOutlet var HomeTV: UITextView!
    @IBAction func reloadEverything(_ sender: Any) {
        loader.startAnimating()
        reloadData()
    }
    
    func viewLoadSetup() {
        loader = NVActivityIndicatorView(frame: CGRect(x: view.center.x - 25, y: view.center.y - 25, width: 50, height: 50))
        loader.type = .ballPulseSync
        loader.color = UIColor.red
        view.addSubview(loader)
        if HomeTV.text == "Download..." {
            loader.startAnimating()
        }
        else {
            loader.stopAnimating()
        }
        
        if UserDefaults.standard.string(forKey: "TitleBarColor") != nil, UserDefaults.standard.string(forKey: "TitleBarColor") != "" {
            TitleBar.backgroundColor = UIColor(red: CGFloat(UserDefaults.standard.integer(forKey: "TitleBarRed")) / 255, green: CGFloat(UserDefaults.standard.integer(forKey: "TitleBarGreen")) / 255, blue: CGFloat(UserDefaults.standard.integer(forKey: "TitleBarBlue")) / 255, alpha: 1)
        }
        
        if UserDefaults.standard.integer(forKey: "DarkmodeStatus") == 1 {
            view.backgroundColor = UIColor(red: 0.05, green: 0.05, blue: 0.05, alpha: 1.0)
            HomeTitleBackground.backgroundColor = UIColor(red: 0.13, green: 0.13, blue: 0.13, alpha: 1.0)
            HomeTitle.textColor = UIColor.white
            HomeTV.textColor = UIColor.white
            HomeTV.backgroundColor = UIColor(red: 0.05, green: 0.05, blue: 0.05, alpha: 1.0)
            setNeedsStatusBarAppearanceUpdate()
        }
        if UserDefaults.standard.integer(forKey: "DarkmodeStatus") == 0 {
            view.backgroundColor = UIColor.white
            HomeTitleBackground.backgroundColor = UIColor(red: 0.95, green: 0.95, blue: 0.95, alpha: 1.0)
            
            HomeTitle.textColor = UIColor.black
            HomeTV.textColor = UIColor.black
            HomeTV.backgroundColor = UIColor.white
            setNeedsStatusBarAppearanceUpdate()
        }
        
        var ref: DatabaseReference!
        
        ref = Database.database().reference()
        
        reloadData()
        
        ref.observe(.childChanged) { _ in
            self.reloadData()
        }
        
        if HomeViewController.AutomaticMover.LastVisitedView == "hw" {
            HomeViewController.AutomaticMover.LastVisitedView = ""
            tabBarController?.selectedIndex = 1
        }
        if HomeViewController.AutomaticMover.LastVisitedView == "test" {
            HomeViewController.AutomaticMover.LastVisitedView = ""
            tabBarController?.selectedIndex = 2
        }
        if HomeViewController.AutomaticMover.LastVisitedView == "plans" {
            HomeViewController.AutomaticMover.LastVisitedView = ""
            tabBarController?.selectedIndex = 3
        }
        if HomeViewController.AutomaticMover.LastVisitedView == "settings" {
            HomeViewController.AutomaticMover.LastVisitedView = ""
            tabBarController?.selectedIndex = 4
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        viewLoadSetup()
    }
    
    func reloadData() {
        let date = Date()
        let calender = Calendar.current
        let components = calender.dateComponents([.year, .month, .day, .hour, .minute, .second], from: date)
        let currentday = calender.component(.weekday, from: date)
        let day = components.day
        let month = components.month
        var month2 = ""
        var day2 = ""
        var weekdaystring = ""
        if currentday == 1 {
            weekdaystring = "Sonntag"
        }
        if currentday == 2 {
            weekdaystring = "Montag"
        }
        if currentday == 3 {
            weekdaystring = "Dienstag"
        }
        if currentday == 4 {
            weekdaystring = "Mittwoch"
        }
        if currentday == 5 {
            weekdaystring = "Donnerstag"
        }
        if currentday == 6 {
            weekdaystring = "Freitag"
        }
        if currentday == 7 {
            weekdaystring = "Samstag"
        }
        if day! < 10 {
            day2 = "0\(day!)"
        }
        else {
            day2 = "\(day!)"
        }
        if month! < 10 {
            month2 = "0\(month!)"
        }
        else {
            month2 = "\(month!)"
        }
        
        let fulllabelstring = "\(weekdaystring), \(day2).\(month2)."
        DateLabel.text = fulllabelstring
        
        var ref: DatabaseReference!
        ref = Database.database().reference()
        
        ref.child("standardData").child("bd1event").observeSingleEvent(of: .value) { birthdaysnap in
            let BDSnap = birthdaysnap.value as? String
            
            let confettiView2 = SAConfettiView(frame: self.HomeTitleBackground.bounds)
            confettiView2.tag = 5
            
            if BDSnap == "1" {
                if UserDefaults.standard.integer(forKey: "FirstBDE") != 1 {
                    let confettiView = SAConfettiView(frame: self.view.bounds)
                    confettiView.type = .Confetti
                    self.view.addSubview(confettiView)
                    confettiView.startConfetti()
                    DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2)) {
                        confettiView.stopConfetti()
                        confettiView.removeFromSuperview()
                        EZAlertController.alert("Hallo", message: "Entschuldigung für die Störung, aber bitte lies dir die nächsten Nachrichten durch.", acceptMessage: "Weiter") { () -> () in
                            EZAlertController.alert("Nachricht", message: "Diese Woche feiert die KlassenApp ihren ersten Geburtstag.", acceptMessage: "Weiter") { () -> () in
                                EZAlertController.alert("Nachricht", message: "Ich möchte mich bedanken, dass ihr die App seit einem Jahr verwendet.", acceptMessage: "Weiter") { () -> () in
                                    EZAlertController.alert("Nachricht", message: "Jetzt viel Spaß bei der Verwendung der App! Auf ein neues Jahr!")
                                }
                            }
                        }
                    }
                    UserDefaults.standard.set(1, forKey: "FirstBDE")
                }
                confettiView2.type = .Confetti
                self.HomeTitleBackground.addSubview(confettiView2)
                confettiView2.startConfetti()
            }
            else {
                if let viewWithTag = self.view.viewWithTag(5) {
                    viewWithTag.removeFromSuperview()
                }
                else {}
            }
        }
        
        ref.child("standardData").child("LDU").observeSingleEvent(of: .value) { LDUSnap in
            let LDUSNAP = LDUSnap.value as? String
            HomeViewController.HomeVar.LDU = LDUSNAP!
        }
        ref.child("homework").child("bismorgen").child("hausaufgaben").observeSingleEvent(of: .value) { HABMINFOSNAP in
            let HABMINFOLE = HABMINFOSNAP.value as? String
            HomeViewController.HomeVar.HabmText = HABMINFOLE!
        }
        ref.child("homework").child("bismorgen").child("updatetime").observeSingleEvent(of: .value) { HABMLDUSNAP in
            let HABMLDULE = HABMLDUSNAP.value as! String
            HomeViewController.HomeVar.HabmTime = HABMLDULE
        }
        ref.child("news").child("news1").observeSingleEvent(of: .value) { News1Snap in
            let NEWS1SNAP = News1Snap.value as? String
            HomeViewController.HomeVar.News1 = NEWS1SNAP!
        }
        ref.child("news").child("newsL").observeSingleEvent(of: .value) { NewsLSnap in
            let NEWSLSNAP = NewsLSnap.value as? String
            HomeViewController.HomeVar.NewsL = NEWSLSNAP!
        }
        ref.child("standardData").child("iosCurrentVer").child("versionnumber").observeSingleEvent(of: .value) { NewestBuildDB in
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
        
        if currentday == 2 {
            ref.child("Speiseplan").child("monday").observeSingleEvent(of: .value) { MondayFoodSnap in
                let MondayFood = MondayFoodSnap.value as? String
                HomeViewController.HomeVar.essenHeute = MondayFood!
            }
            ref.child("homework").child("Week1").child("Monday").observeSingleEvent(of: .value) { HWToday in
                HomeViewController.HomeVar.HomeworkToday = HWToday.value as! String
            }
        }
        else if currentday == 3 {
            ref.child("Speiseplan").child("Tuesday").observeSingleEvent(of: .value) { TuesdayFoodSnap in
                let TuesdayFood = TuesdayFoodSnap.value as? String
                HomeViewController.HomeVar.essenHeute = TuesdayFood!
            }
            ref.child("homework").child("Week1").child("Tuesday").observeSingleEvent(of: .value) { HWToday in
                HomeViewController.HomeVar.HomeworkToday = HWToday.value as! String
            }
        }
        else if currentday == 4 {
            ref.child("Speiseplan").child("Wednesday").observeSingleEvent(of: .value) { WednesdayFoodSnap in
                let WednesdayFood = WednesdayFoodSnap.value as? String
                HomeViewController.HomeVar.essenHeute = WednesdayFood!
            }
            ref.child("homework").child("Week1").child("Wednesday").observeSingleEvent(of: .value) { HWToday in
                HomeViewController.HomeVar.HomeworkToday = HWToday.value as! String
            }
        }
        else if currentday == 5 {
            ref.child("Speiseplan").child("Thursday").observeSingleEvent(of: .value) { ThursdayFoodSnap in
                let ThursdayFood = ThursdayFoodSnap.value as? String
                HomeViewController.HomeVar.essenHeute = ThursdayFood!
            }
            ref.child("homework").child("Week1").child("Thursday").observeSingleEvent(of: .value) { HWToday in
                HomeViewController.HomeVar.HomeworkToday = HWToday.value as! String
            }
        }
        else if currentday == 6 {
            ref.child("Speiseplan").child("Friday").observeSingleEvent(of: .value) { FridayFoodSnap in
                let FridayFood = FridayFoodSnap.value as? String
                HomeViewController.HomeVar.essenHeute = FridayFood!
            }
            ref.child("homework").child("Week1").child("Friday").observeSingleEvent(of: .value) { HWToday in
                HomeViewController.HomeVar.HomeworkToday = HWToday.value as! String
            }
        }
        else if currentday == 7 || currentday == 1 {
            HomeViewController.HomeVar.essenHeute = "Kein Essen heute!"
            ref.child("homework").child("Week1").child("Friday").observeSingleEvent(of: .value) { HWToday in
                HomeViewController.HomeVar.HomeworkToday = HWToday.value as! String
            }
        }
        
        ref.child("Speiseplan").child("Datum").observeSingleEvent(of: .value) { FoodDateSnap in
            let FoodDate = FoodDateSnap.value as? String
            HomeViewController.HomeVar.essenDate = FoodDate!
        }
        
        ref.child("arbeiten").child("nextEvent").observeSingleEvent(of: .value) { Test1LabelSnap in
            let TEST1LABELSNAP = Test1LabelSnap.value as? String
            HomeViewController.HomeVar.NextEvent = TEST1LABELSNAP!
            self.timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.setToTV), userInfo: nil, repeats: true)
            self.loader.stopAnimating()
        }
        
        ref.child("standardData").child("iosCurrentVer").child("versionnumber").observeSingleEvent(of: .value) { NewestBuildDB in
            let dictionary = Bundle.main.infoDictionary!
            let versionCurrent = dictionary["CFBundleShortVersionString"] as! String
            let NEWESTBUILD = NewestBuildDB.value as? String
            HomeViewController.HomeVar.NewestVersion = NEWESTBUILD ?? versionCurrent
            
            if versionCurrent.compare(NEWESTBUILD!, options: .numeric) == .orderedAscending {
                if HomeVar.UpdateReminderSession != "1" {
                    ref.child("standardData").child("iosCurrentVer").child("description").observeSingleEvent(of: .value, with: { Descrip in
                        let UpdateDescripton = Descrip.value as! String
                        
                        var UpdateAppearance: SCLAlertView.SCLAppearance!
                        
                        if UserDefaults.standard.integer(forKey: "DarkmodeStatus") == 1 {
                            UpdateAppearance = SCLAlertView.SCLAppearance(
                                showCloseButton: false, contentViewColor: UIColor(red: 0.05, green: 0.05, blue: 0.05, alpha: 1.0),
                                contentViewBorderColor: UIColor.black,
                                titleColor: UIColor.white
                            )
                        }
                        
                        if UserDefaults.standard.integer(forKey: "DarkmodeStatus") == 0 {
                            UpdateAppearance = SCLAlertView.SCLAppearance(
                                showCloseButton: false, contentViewColor: UIColor.white,
                                contentViewBorderColor: UIColor.white,
                                titleColor: UIColor.black
                            )
                        }
                        
                        let UpdateAlert = SCLAlertView(appearance: UpdateAppearance)
                        
                        UpdateAlert.addButton("Installieren", action: {
                            UIApplication.shared.open(URL(string: "https://klassenappd.de/ios/ios_download_direct.html")!)
                        })
                        
                        UpdateAlert.addButton("Nicht jetzt", action: {
                            HomeVar.UpdateReminderSession = "1"
                        })
                        
                        UpdateAlert.showInfo("Update verfügbar (Version: \(NEWESTBUILD!))", subTitle: "Ein neues Update ist verfügbar mit folgenden Änderungen:\n\n \(UpdateDescripton)\n\nEs wird empfohlen das Update zu installieren.")
                        
                    })
                }
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        var ref: DatabaseReference!
        
        ref = Database.database().reference()
        
        let attr = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 20)]
        
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
                title: "Version \(versionCurrent)",
                items: [
                    WhatsNew.Item(
                        title: "Datenänderungen",
                        subtitle: "Die Art, wie Daten aus der Datenbank abgerufen und gespeichert werden, wurde geändert. Unter anderem werden Daten nun automatisch aktualisiert und Offline gespeichert.",
                        image: UIImage(named: "icons8-aktualisieren-30")
                    ),
                    WhatsNew.Item(
                        title: "Elemente entfernt",
                        subtitle: "Einige Elemente wurden aus der KlassenApp verändert: Die Zahl beim Auswählen des Appicons, der Login, 3D Touch und der \"Kontakt via Mail\"-Knopf.",
                        image: UIImage(named: "icon_close")
                    ),
                    WhatsNew.Item(
                        title: "Kleinere Änderungen",
                        subtitle: "Mehrere Bugs wurden behoben, eine neue Updatenachricht erscheint bei neuen Updates, die Tabbar wurde animiert und es wurden einige Aussehensänderungen vorgenommen.",
                        image: UIImage(named: "icons8-gruppe-von-fragen-30")
                    )
                ]
            )
            let whatsNewViewController = WhatsNewViewController(
                whatsNew: whatsNew,
                configuration: HomeVar.WhatsNewConfig
            )
            
            present(whatsNewViewController, animated: true)
            UserDefaults.standard.set("1", forKey: "\(versionCurrent)")
        }
    }
    
    @objc func removeUpdateMessage() {
        if HomeVar.UpdateReminderSession == "1" {
        }
        else {}
    }
    
    @objc func setToTV() {
        if HomeVar.essenDate != "", HomeVar.essenHeute != "", HomeVar.HabmText != "", HomeVar.HabmTime != "", HomeVar.LDU != "", HomeVar.News1 != "", HomeVar.NewsL != "", HomeVar.NextEvent != "" {
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
                HomeTV.backgroundColor = UIColor(red: 0.05, green: 0.05, blue: 0.05, alpha: 1.0)
            }
            if UserDefaults.standard.integer(forKey: "DarkmodeStatus") == 0 {
                HomeTV.textColor = UIColor.black
                HomeTV.backgroundColor = UIColor.white
            }
            timer.invalidate()
            loader.stopAnimating()
            HomeTV.scrollRangeToVisible(NSMakeRange(0, 0))
        }
    }
    
    func randomString(length: Int) -> String {
        let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890"
        return String((0...length - 1).map { _ in letters.randomElement()! })
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
        static var HomeworkToday = ""
    }
    
    struct AutomaticMover {
        static var LastVisitedView = ""
    }
}

extension NSMutableAttributedString {
    @discardableResult func bold(_ text: String) -> NSMutableAttributedString {
        let attrs: [NSAttributedString.Key: Any] = [
            .font: UIFont(name: "Arial", size: 19)!
        ]
        let boldString = NSMutableAttributedString(string: text, attributes: attrs)
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

extension Int: Sequence {
    public func makeIterator() -> CountableRange<Int>.Iterator {
        return (0..<self).makeIterator()
    }
}
