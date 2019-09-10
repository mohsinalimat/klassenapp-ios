//
//  NewHomeViewController.swift
//  KlassenAppD
//
//  Created by Adrian Baumgart on 09.09.19.
//  Copyright © 2019 Adrian Baumgart. All rights reserved.
//

import UIKit
import Firebase
import WhatsNewKit
import SCLAlertView

class NewHomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var allHomeEntries:[homeEntry] = []
    
    var style = Appearances()
    
    var WhatsNewDarkMode: Bool!
    var UpdateAlertAllowed: Bool! = true
    var newestBuild: Int!

    @IBOutlet weak var DateLabel: UILabel!
    @IBOutlet weak var HomeTitle: UILabel!
    @IBOutlet weak var TitleBackground: UIView!
    @IBOutlet weak var TitleBar: UIView!
    @IBOutlet weak var HomeTableView: UITableView!
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {

        let view:UIView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: self.view.bounds.size.width, height: 10))
        view.backgroundColor = .clear

        return view
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return allHomeEntries.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "homecell", for: indexPath)
        
        if UserDefaults.standard.integer(forKey: "AutoAppearance") == 1 {
                   if #available(iOS 13.0, *) {
                       if traitCollection.userInterfaceStyle == .dark {
                        cell.textLabel!.textColor = style.darkText
                        cell.detailTextLabel?.textColor = style.darkText
                        cell.backgroundColor = style.darkCell
                        cell.contentView.backgroundColor = style.darkCell
                       }
                       else if traitCollection.userInterfaceStyle == .light || traitCollection.userInterfaceStyle == .unspecified {
                        cell.textLabel!.textColor = style.lightText
                        cell.detailTextLabel?.textColor = style.lightText
                        cell.backgroundColor = style.lightCell
                        cell.contentView.backgroundColor = style.lightCell
                       }
                   }
               }
               else {
                   if UserDefaults.standard.integer(forKey: "DarkmodeStatus") == 1 {
                    cell.textLabel!.textColor = style.darkText
                    cell.detailTextLabel?.textColor = style.darkText
                    cell.backgroundColor = style.darkCell
                    cell.contentView.backgroundColor = style.darkCell
                   }
                   else if UserDefaults.standard.integer(forKey: "DarkmodeStatus") == 0 {
                    cell.textLabel!.textColor = style.lightText
                    cell.detailTextLabel?.textColor = style.lightText
                    cell.backgroundColor = style.lightCell
                    cell.contentView.backgroundColor = style.lightCell
                   }
               }
        cell.textLabel!.text = allHomeEntries[indexPath.section].title
        cell.detailTextLabel!.text = allHomeEntries[indexPath.section].content
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10.0
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        viewLoadSetup()
    }
    
    override func viewDidAppear(_ animated: Bool) {
    }
    
    func viewLoadSetup() {
        
        changeAppearance()
        
        let ref: DatabaseReference = Database.database().reference()
        
        ref.child("standardData").child("iosCurrentVer").child("versionnumber").observeSingleEvent(of: .value) { (_) in
        }
        
        loadWhatsNew()
        
        ref.observe(.value) { _ in
            self.loadUpdateAlert()
            self.allHomeEntries.removeAll()
            self.HomeTableView.reloadData()
            self.loadData()
        }
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        
        if #available(iOS 13.0, *) {
            if UserDefaults.standard.integer(forKey: "AutoAppearance") == 1 {
                UIView.animate(withDuration: 0.1) {
                    self.changeAppearance()
                }
                self.setNeedsStatusBarAppearanceUpdate()
            }
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        var style: UIStatusBarStyle!
        if UserDefaults.standard.integer(forKey: "AutoAppearance") == 1 {
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
                if UserDefaults.standard.integer(forKey: "DarkmodeStatus") == 0 {
                    style = .default
                }
            }
        }
        return style
    }
    
    func changeAppearance() {
        if UserDefaults.standard.integer(forKey: "AutoAppearance") == 1 {
            if #available(iOS 13.0, *) {
                if traitCollection.userInterfaceStyle == .dark {
                    view.backgroundColor = style.darkBackground
                    TitleBackground.backgroundColor = style.darkTitleBackground
                    HomeTitle.textColor = style.darkText
                    HomeTableView.backgroundColor = style.darkBackground
                    self.tabBarController!.tabBar.barTintColor = self.style.darkBarTintColor
                    self.tabBarController!.tabBar.tintColor = self.style.darkTintColor
                    HomeTableView.reloadData()
                    setNeedsStatusBarAppearanceUpdate()
                }
                else if traitCollection.userInterfaceStyle == .light || traitCollection.userInterfaceStyle == .unspecified {
                    view.backgroundColor = style.lightBackground
                    TitleBackground.backgroundColor = style.lightTitleBackground
                    HomeTitle.textColor = style.lightText
                    HomeTableView.backgroundColor = style.lightBackground
                    self.tabBarController!.tabBar.barTintColor = self.style.lightBarTintColor
                    self.tabBarController!.tabBar.tintColor = self.style.lightTintColor
                    HomeTableView.reloadData()
                    setNeedsStatusBarAppearanceUpdate()
                }
            }
        }
        else {
            if UserDefaults.standard.integer(forKey: "DarkmodeStatus") == 1 {
                view.backgroundColor = style.darkBackground
                view.backgroundColor = style.darkBackground
                TitleBackground.backgroundColor = style.darkTitleBackground
                HomeTitle.textColor = style.darkText
                HomeTableView.backgroundColor = style.darkBackground
                self.tabBarController!.tabBar.barTintColor = self.style.darkBarTintColor
                self.tabBarController!.tabBar.tintColor = self.style.darkTintColor
                HomeTableView.reloadData()
                setNeedsStatusBarAppearanceUpdate()
            }
            else if UserDefaults.standard.integer(forKey: "DarkmodeStatus") == 0 {
                view.backgroundColor = style.lightBackground
                view.backgroundColor = style.lightBackground
                TitleBackground.backgroundColor = style.lightTitleBackground
                HomeTitle.textColor = style.lightText
                HomeTableView.backgroundColor = style.lightBackground
                self.tabBarController!.tabBar.barTintColor = self.style.lightBarTintColor
                self.tabBarController!.tabBar.tintColor = self.style.lightTintColor
                HomeTableView.reloadData()
                setNeedsStatusBarAppearanceUpdate()
            }
        }
        if UserDefaults.standard.string(forKey: "TitleBarColor") != nil, UserDefaults.standard.string(forKey: "TitleBarColor") != "" {
            TitleBar.backgroundColor = UIColor(red: CGFloat(UserDefaults.standard.integer(forKey: "TitleBarRed")) / 255, green: CGFloat(UserDefaults.standard.integer(forKey: "TitleBarGreen")) / 255, blue: CGFloat(UserDefaults.standard.integer(forKey: "TitleBarBlue")) / 255, alpha: 1)
        }
    }
    
    func loadUpdateAlert() {
        let ref: DatabaseReference = Database.database().reference()
        
        ref.child("standardData").child("iosCurrentVer").child("build").observeSingleEvent(of: .value) { (snapshot1) in
            ref.child("standardData").child("iosCurrentVer").child("versionnumber").observeSingleEvent(of: .value) { (snapshot2) in
                ref.child("standardData").child("iosCurrentVer").child("description").observeSingleEvent(of: .value) { (snapshot3) in
                    ref.child("standardData").child("iosCurrentVer").child("UpdateLink").observeSingleEvent(of: .value) { (snapshot4) in
                        let dictionary = Bundle.main.infoDictionary!
                        let buildCurrent = dictionary["CFBundleVersion"] as? String
                        let build = Int(buildCurrent!)
                        
                        if snapshot1.value as! Int > build! {
                            if self.UpdateAlertAllowed == true {
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
                                
                                UpdateAlert.addButton("Installieren") {
                                    UIApplication.shared.open(URL(string: snapshot4.value as! String)!)
                                }
                                
                                UpdateAlert.addButton("Nicht jetzt") {
                                    self.UpdateAlertAllowed = false
                                }
                                UpdateAlert.showInfo("Update verfügbar (Version: \(snapshot2.value as! String) | Build: \(snapshot1.value as! Int))", subTitle: "Ein Update ist verfügbar und beinhaltet die folgenden Änderungen. Es wird empfohlen das Update zu installieren. \n\n \(snapshot3.value as! String)")
                            }
                        }
                    }
                }
            }
        }
    }
    
    func loadWhatsNew() {
        let dictionary = Bundle.main.infoDictionary!
        let versionCurrent = dictionary["CFBundleShortVersionString"] as! String
        var WNConfig = WhatsNewViewController.Configuration()
        if UserDefaults.standard.string(forKey: "\(versionCurrent)") != "1" {
            if WhatsNewDarkMode == true {
                WNConfig = WhatsNewViewController.Configuration(theme: .darkRed)
            }
            if WhatsNewDarkMode == false {
                WNConfig = WhatsNewViewController.Configuration(theme: .whiteRed)
            }
            WNConfig.itemsView.contentMode = .center
                let whatsNew = WhatsNew(
                    title: "Version \(versionCurrent)",
                    items: [
                        WhatsNew.Item(
                            title: "Hausaufgaben von heute",
                            subtitle: "Auf der Homeseite kann man nun die Hausaufgaben sehen, die an diesem Tag aufgegeben wurden",
                            image: UIImage(named: "homeicon")
                        ),
                        WhatsNew.Item(
                            title: "Aktualisierte Ansichten",
                            subtitle: "Ab dieser Version erscheinen alle Menüs als Popover (über der vorherigen Ansicht). Darunter auch die Farbauswahl und der Stundenplan!",
                            image: UIImage(named: "screen_route")
                        ),
                        WhatsNew.Item(
                            title: "Ausrichtung",
                            subtitle: "Auf iPads lässt sich die App nun um 90 Grad drehen!",
                            image: UIImage(named: "ipad")
                        ),
                        WhatsNew.Item(
                            title: "Aufgeräumt & kleinere Änderungen",
                            subtitle: "Es wurden unnötige Codeteile entfernt, überflüssige Ansichten gelöscht und der Code wurde verkleinert. Das kann u.a. zu Performanceverbesserungen führren! Auch wurden kleinere Sachen an der App verändert.",
                            image: UIImage(named: "cleaner")
                        ),
                        WhatsNew.Item(
                            title: "Danke",
                            subtitle: "Falls du das liest: Nochmal vielen Dank, dass du diese App verwendest. Jede Person hat zur App beigetragen, sei es auch nur durch das Herunterladen. Das zweite Jahr hat begonnen!",
                            image: UIImage(named: "designicon")
                        )
                    ]
                )
                let whatsNewViewController = WhatsNewViewController(
                    whatsNew: whatsNew,
                    configuration: WNConfig
                )
                
                present(whatsNewViewController, animated: true)
                UserDefaults.standard.set("1", forKey: "\(versionCurrent)")
            }
    }
    
    func loadData() {
        
        allHomeEntries.removeAll()
        HomeTableView.reloadData()
        
        let ref: DatabaseReference = Database.database().reference()
        
        let date = Date()
        let calender = Calendar.current
        let components = calender.dateComponents([.year, .month, .day, .hour, .minute, .second], from: date)
        let currentday = calender.component(.weekday, from: date)
        let day = components.day
        let month = components.month
        var month2 = ""
        var day2 = ""
        var weekdaystring = ""
        var homeworkWeekString = ""
        var foodWeekString = ""
        if currentday == 1 {
            weekdaystring = "Sonntag"
            homeworkWeekString = "Sonntag"
            foodWeekString = "Sonntag"
        }
        if currentday == 2 {
            weekdaystring = "Montag"
            homeworkWeekString = "Monday"
            foodWeekString = "monday"
        }
        if currentday == 3 {
            weekdaystring = "Dienstag"
            homeworkWeekString = "Tuesday"
            foodWeekString = "Tuesday"
        }
        if currentday == 4 {
            weekdaystring = "Mittwoch"
            homeworkWeekString = "Wednesday"
            foodWeekString = "Wednesday"
        }
        if currentday == 5 {
            weekdaystring = "Donnerstag"
            homeworkWeekString = "Thursday"
            foodWeekString = "Thursday"
        }
        if currentday == 6 {
            weekdaystring = "Freitag"
            homeworkWeekString = "Friday"
            foodWeekString = "Friday"
        }
        if currentday == 7 {
            weekdaystring = "Samstag"
            homeworkWeekString = "Samstag"
            foodWeekString = "Samstag"
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
        
        ref.child("homework").child("bismorgen").child("hausaufgaben").observeSingleEvent(of: .value) { (snapshot1) in
            self.allHomeEntries.append(homeEntry(title: "Hausaufgaben bis morgen", content: snapshot1.value as! String, sorter: 1))
            
            ref.child("homework").child("Week1").child(homeworkWeekString).observeSingleEvent(of: .value) { (snapshot2) in
            if homeworkWeekString != "Samstag" && homeworkWeekString != "Sonntag" {
                self.allHomeEntries.append(homeEntry(title: "Hausaufgaben von heute", content: snapshot2.value as! String, sorter: 2))
            }
            else {
                self.allHomeEntries.append(homeEntry(title: "Hausaufgaben von heute", content: "Keine Hausaufgaben heute, es ist Wochenende!", sorter: 2))
                }
                    
                ref.child("news").child("news1").observeSingleEvent(of: .value) { (snapshot3_1) in
                    ref.child("news").child("newsL").observeSingleEvent(of: .value) { (snapshot3_2) in
                        self.allHomeEntries.append(homeEntry(title: "Neuigkeiten", content: "-Administratoren: \(snapshot3_1.value as! String) \n\n-Lehrer: \(snapshot3_2.value as! String)", sorter: 3))
                            
                        ref.child("arbeiten").child("nextEvent").observeSingleEvent(of: .value) { (snapshot4) in
                            self.allHomeEntries.append(homeEntry(title: "Nächste Veranstaltung", content: snapshot4.value as! String, sorter: 4))
                            
                            ref.child("Speiseplan").child(foodWeekString).observeSingleEvent(of: .value) { (snapshot5) in
                                if foodWeekString != "Samstag" && foodWeekString != "Sonntag" {
                                    self.allHomeEntries.append(homeEntry(title: "Essen heute", content: snapshot5.value as! String, sorter: 5))
                                }
                                else {
                                    self.allHomeEntries.append(homeEntry(title: "Essen heute", content: "Kein Essen heute, es ist Wochenende!", sorter: 5))
                                }
                                ref.child("standardData").child("iosCurrentVer").child("build").observeSingleEvent(of: .value) { (snapshot6_1) in
                                    ref.child("standardData").child("iosCurrentVer").child("versionnumber").observeSingleEvent(of: .value) { (snapshot6_2) in
                                        
                                        let dictionary = Bundle.main.infoDictionary!
                                        let buildCurrent = dictionary["CFBundleVersion"] as? String
                                        let build = Int(buildCurrent!)
                                        
                                        if snapshot6_1.value as! Int > build! {
                                            self.allHomeEntries.append(homeEntry(title: "Appupdate", content: "Ein Update auf die Version \(snapshot6_2.value as! String) ist verfügbar.", sorter: 6))
                                        }
                                        else {
                                            self.allHomeEntries.append(homeEntry(title: "Appupdate", content: "Es ist kein Update verfügbar. Du benutzt bereits die neuste Version! 👍", sorter: 6))
                                        }
                                        
                                        ref.child("homework").child("Week1").child("Datum").observeSingleEvent(of: .value) { (snapshot7_1) in
                                            ref.child("Speiseplan").child("Datum").observeSingleEvent(of: .value) { (snapshot7_2) in
                                                ref.child("homework").child("bismorgen").child("updatetime").observeSingleEvent(of: .value) { (snapshot7_3) in
                                                    ref.child("standardData").child("LDU").observeSingleEvent(of: .value) { (snapshot7_4) in
                                                        self.allHomeEntries.append(homeEntry(title: "Zeiten", content: "-Hausaufgabenwoche: \(snapshot7_1.value as! String)\n\n-Speiseplanwoche: \(snapshot7_2.value as! String)\n\n-HABM-Updatezeit: \(snapshot7_3.value as! String)\n\n-LDU: \(snapshot7_4.value as! String)", sorter: 7))
                                                        
                                                        self.HomeTableView.reloadData()
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }

    struct homeEntry {
        var title: String
        var content: String
        var sorter: Int
    }
}
