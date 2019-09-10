//
//  EventsNewViewController.swift
//  KlassenAppD
//
//  Created by Adrian Baumgart on 03.09.19.
//  Copyright © 2019 Adrian Baumgart. All rights reserved.
//

import UIKit
import FirebaseDatabase
import SPStorkController

class EventsNewViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, DZNEmptyDataSetSource, DZNEmptyDataSetDelegate {
    
    @IBOutlet weak var eventsTableView: UITableView!
    @IBOutlet weak var TitleBackground: UIView!
    @IBOutlet weak var PageTitle: UILabel!
    @IBOutlet weak var TitleBar: UIView!
    
    var style = Appearances()
    
    var allEvents:[singleEvent] = []
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        allEvents.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "supercell", for: indexPath)
        
        if UserDefaults.standard.integer(forKey: "AutoAppearance") == 1 {
                   if #available(iOS 13.0, *) {
                       if traitCollection.userInterfaceStyle == .dark {
                        cell.textLabel!.textColor = style.darkText
                        cell.backgroundColor = style.darkBackground
                       }
                       else if traitCollection.userInterfaceStyle == .light || traitCollection.userInterfaceStyle == .unspecified {
                        cell.textLabel!.textColor = style.lightText
                        cell.backgroundColor = style.lightBackground
                       }
                   }
               }
               else {
                   if UserDefaults.standard.integer(forKey: "DarkmodeStatus") == 1 {
                    cell.textLabel!.textColor = style.darkText
                    cell.backgroundColor = style.darkBackground
                   }
                   else if UserDefaults.standard.integer(forKey: "DarkmodeStatus") == 0 {
                    cell.textLabel!.textColor = style.lightText
                    cell.backgroundColor = style.lightBackground
                   }
               }
        cell.textLabel!.text = allEvents[indexPath.row].name
        cell.detailTextLabel!.text = allEvents[indexPath.row].formattedDate
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
           AllNewEventsViewController.TestVC.selectedEventID = allEvents[indexPath.row].identifier
           
           let impactFeedbackgenerator = UIImpactFeedbackGenerator(style: .light)
           impactFeedbackgenerator.prepare()
           impactFeedbackgenerator.impactOccurred()
           let controller1 = AllNewEventsViewController()
           let transitionDelegate = SPStorkTransitioningDelegate()
           controller1.transitioningDelegate = transitionDelegate
           controller1.modalPresentationStyle = .custom
           controller1.modalPresentationCapturesStatusBarAppearance = true
           self.present(controller1, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        viewLoadSetup()
    }
    
    func viewLoadSetup() {
        if UserDefaults.standard.string(forKey: "TitleBarColor") != nil && UserDefaults.standard.string(forKey: "TitleBarColor") != "" {
            TitleBar.backgroundColor = UIColor(red: CGFloat(UserDefaults.standard.integer(forKey: "TitleBarRed")) / 255, green: CGFloat(UserDefaults.standard.integer(forKey: "TitleBarGreen")) / 255, blue: CGFloat(UserDefaults.standard.integer(forKey: "TitleBarBlue")) / 255, alpha: 1)
        }
        
        eventsTableView.emptyDataSetSource = self
        eventsTableView.emptyDataSetDelegate = self
        eventsTableView.tableFooterView = UIView()
        
        changeAppearance()
        fetchData()
    }
    
    func changeAppearance() {
        if UserDefaults.standard.integer(forKey: "AutoAppearance") == 1 {
            if #available(iOS 13.0, *) {
                if traitCollection.userInterfaceStyle == .dark {
                    view.backgroundColor = style.darkBackground
                    TitleBackground.backgroundColor = style.darkTitleBackground
                    PageTitle.textColor = style.darkText
                    eventsTableView.backgroundColor = style.darkBackground
                    self.tabBarController!.tabBar.barTintColor = self.style.darkBarTintColor
                    self.tabBarController!.tabBar.tintColor = self.style.darkTintColor
                    setNeedsStatusBarAppearanceUpdate()
                }
                else if traitCollection.userInterfaceStyle == .light || traitCollection.userInterfaceStyle == .unspecified {
                    view.backgroundColor = style.lightBackground
                    TitleBackground.backgroundColor = style.lightTitleBackground
                    PageTitle.textColor = style.lightText
                    eventsTableView.backgroundColor = style.lightBackground
                    self.tabBarController!.tabBar.barTintColor = self.style.lightBarTintColor
                    self.tabBarController!.tabBar.tintColor = self.style.lightTintColor
                    setNeedsStatusBarAppearanceUpdate()
                }
            }
        }
        else {
            if UserDefaults.standard.integer(forKey: "DarkmodeStatus") == 1 {
                view.backgroundColor = style.darkBackground
                view.backgroundColor = style.darkBackground
                TitleBackground.backgroundColor = style.darkTitleBackground
                PageTitle.textColor = style.darkText
                eventsTableView.backgroundColor = style.darkBackground
                self.tabBarController!.tabBar.barTintColor = self.style.darkBarTintColor
                self.tabBarController!.tabBar.tintColor = self.style.darkTintColor
                setNeedsStatusBarAppearanceUpdate()
            }
            else if UserDefaults.standard.integer(forKey: "DarkmodeStatus") == 0 {
                view.backgroundColor = style.lightBackground
                view.backgroundColor = style.lightBackground
                TitleBackground.backgroundColor = style.lightTitleBackground
                PageTitle.textColor = style.lightText
                eventsTableView.backgroundColor = style.lightBackground
                self.tabBarController!.tabBar.barTintColor = self.style.lightBarTintColor
                self.tabBarController!.tabBar.tintColor = self.style.lightTintColor
                setNeedsStatusBarAppearanceUpdate()
            }
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
    
    func title(forEmptyDataSet scrollView: UIScrollView) -> NSAttributedString? {
        let str = "Keine Daten"
        let attrs = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 25)]
        return NSAttributedString(string: str, attributes: attrs)
    }
    
    func description(forEmptyDataSet scrollView: UIScrollView) -> NSAttributedString? {
        let str = "Derzeit gibt es keine anstehenen Veranstaltungen. Es kann auch sein, dass die Daten noch nicht heruntergeladen wurden."
        let attrs = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 18)]
        return NSAttributedString(string: str, attributes: attrs)
    }
    
    func fetchData() {
        var databasekeys: [String] = []
        
        let ref: DatabaseReference
        ref = Database.database().reference()
        
        ref.child("arbeiten").child("listi").observe(.value) { snapshot in
            
            databasekeys.removeAll()
            self.allEvents.removeAll()
            
            if let item = snapshot.value as? [String: AnyObject] {
                databasekeys = Array(item.keys)
                
                for key in databasekeys {
                    let date = item[key]!["date"] as? Int
                    let formattedDate = item[key]!["formattedDate"] as? String
                    let name = item[key]!["name"] as? String
                    let identifier = key as? String
                    
                    self.allEvents.append(singleEvent(name: name!, formattedDate: formattedDate!, date: date!, identifier: identifier!))
                }
            }
            self.allEvents.sort(by: { $0.date < $1.date })
            self.eventsTableView.reloadData()
        }
    }
    
    struct singleEvent {
        var name: String
        var formattedDate: String
        var date: Int
        var identifier: String
    }
}
