//
//  TimeTableAllViewController.swift
//  KlassenAppD
//
//  Created by Adrian Baumgart on 25.05.19.
//  Copyright © 2019 Adrian Baumgart. All rights reserved.
//

import Firebase
import SPFakeBar
import UIKit

class TimeTableAllViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var navigationbar = SPFakeBarView(style: .stork)
    private var TimeTableTV: UITableView!
    
    var timeTableArray: [String] = []
    
    var style = Appearances()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if TimeTableVC.selectedDay == "monday" {
            TimeTableVC.selectedDayD = "Montag"
        }
        if TimeTableVC.selectedDay == "tuesday" {
            TimeTableVC.selectedDayD = "Dienstag"
        }
        if TimeTableVC.selectedDay == "wednesday" {
            TimeTableVC.selectedDayD = "Mittwoch"
        }
        if TimeTableVC.selectedDay == "thursday" {
            TimeTableVC.selectedDayD = "Donnerstag"
        }
        if TimeTableVC.selectedDay == "friday" {
            TimeTableVC.selectedDayD = "Freitag"
        }
        
        navigationbar.titleLabel.text = "Stundenplan: \(TimeTableVC.selectedDayD)"
        navigationbar.titleLabel.font = navigationbar.titleLabel.font.withSize(23)
        navigationbar.height = 95
        navigationbar.titleLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
        navigationbar.titleLabel.numberOfLines = 3
        view.addSubview(navigationbar)
        for subview in navigationbar.subviews {
            if subview is UIVisualEffectView {
                subview.removeFromSuperview()
            }
        }
        
        let titlebar = UIView(frame: CGRect(x: 0, y: navigationbar.height - 1, width: view.frame.width, height: 3))
        titlebar.backgroundColor = UIColor(red: 0.61, green: 0.32, blue: 0.88, alpha: 1.0)
        
        if UserDefaults.standard.string(forKey: "TitleBarColor") != nil, UserDefaults.standard.string(forKey: "TitleBarColor") != "" {
            titlebar.backgroundColor = UIColor(red: CGFloat(UserDefaults.standard.integer(forKey: "TitleBarRed")) / 255, green: CGFloat(UserDefaults.standard.integer(forKey: "TitleBarGreen")) / 255, blue: CGFloat(UserDefaults.standard.integer(forKey: "TitleBarBlue")) / 255, alpha: 1)
        }
        view.addSubview(titlebar)
        
        TimeTableTV = UITableView(frame: CGRect(x: 8, y: 100, width: view.frame.width - 16, height: view.frame.height - 150))
        TimeTableTV.register(UITableViewCell.self, forCellReuseIdentifier: "timetablecell")
        TimeTableTV.dataSource = self
        TimeTableTV.delegate = self
        view.addSubview(TimeTableTV!)
        
        if UserDefaults.standard.integer(forKey: "DarkmodeStatus") == 1 {
            view.backgroundColor = style.darkBackground
            TimeTableTV.backgroundColor = style.darkBackground
            navigationbar.backgroundColor = style.darkTitleBackground
            navigationbar.titleLabel.textColor = style.darkText
            TimeTableTV!.backgroundColor = style.darkBackground
            setNeedsStatusBarAppearanceUpdate()
        }
        
        if UserDefaults.standard.integer(forKey: "DarkmodeStatus") == 0 {
            view.backgroundColor = style.lightBackground
            TimeTableTV.backgroundColor = style.lightBackground
            navigationbar.backgroundColor = style.lightTitleBackground
            navigationbar.titleLabel.textColor = style.lightText
            TimeTableTV!.backgroundColor = style.lightBackground
            setNeedsStatusBarAppearanceUpdate()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        loadData()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    func loadData() {
        let ref: DatabaseReference
        ref = Database.database().reference()
        
        ref.child("stundenplan").child(TimeTableVC.selectedDay).observe(.value) { snapshot in
            self.timeTableArray.removeAll()
            for child in snapshot.children {
                let snap = child as! DataSnapshot
                let hours = snap.value as! String
                self.timeTableArray.append(hours)
            }
            self.TimeTableTV.reloadData()
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return timeTableArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellmon = TimeTableTV.dequeueReusableCell(withIdentifier: "timetablecell", for: indexPath)
        cellmon.textLabel?.text = timeTableArray[indexPath.row]
        if UserDefaults.standard.integer(forKey: "DarkmodeStatus") == 1 {
            cellmon.backgroundColor = UIColor(red: 0.05, green: 0.05, blue: 0.05, alpha: 1.0)
            cellmon.textLabel!.textColor = UIColor.white
        }
        if UserDefaults.standard.integer(forKey: "DarkmodeStatus") == 0 {
            cellmon.backgroundColor = UIColor.white
            cellmon.textLabel!.textColor = UIColor.black
        }
        return cellmon
    }
    
    struct TimeTableVC {
        static var selectedDay = ""
        static var selectedDayD = ""
    }
}
