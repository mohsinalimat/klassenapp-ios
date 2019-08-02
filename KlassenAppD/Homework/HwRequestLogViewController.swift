//
//  HwRequestLogViewController.swift
//  KlassenAppD
//
//  Created by Adrian Baumgart on 31.05.19.
//  Copyright © 2019 Adrian Baumgart. All rights reserved.
//

import Firebase
import SPFakeBar
import UIKit

class HwRequestLogViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, DZNEmptyDataSetSource, DZNEmptyDataSetDelegate {
    let navigationbar = SPFakeBarView(style: .stork)
    
    private var InfoTV: UITableView!
    
    var log: [Request] = []
    var idlog: [String] = UserDefaults.standard.stringArray(forKey: "RequestLog") ?? [""]
    
    var style = Appearances()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return log.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "infocell")
        cell?.textLabel?.numberOfLines = 0
        cell?.textLabel?.lineBreakMode = .byTruncatingTail
        if log[indexPath.row].status == "In Bearbeitung" {
            cell?.textLabel!.text = "\(log[indexPath.row].id) | \(log[indexPath.row].time)\n\nStatus: \(log[indexPath.row].status)\n\n\"\(log[indexPath.row].content)\""
        }
        else {
            if log[indexPath.row].declined_reas == "-" {
                cell?.textLabel!.text = "\(log[indexPath.row].id) | \(log[indexPath.row].time)\n\nStatus: \(log[indexPath.row].status)\n\nÜberprüft von: \(log[indexPath.row].checked_by)\n\n\"\(log[indexPath.row].content)\""
            }
            else if log[indexPath.row].declined_reas != "-" {
                cell?.textLabel!.text = "\(log[indexPath.row].id) | \(log[indexPath.row].time)\n\nStatus: \(log[indexPath.row].status)\n\nÜberprüft von: \(log[indexPath.row].checked_by)\n\nGrund: \(log[indexPath.row].declined_reas)\n\n\"\(log[indexPath.row].content)\""
            }
        }
        if UserDefaults.standard.integer(forKey: "DarkmodeStatus") == 1 {
            cell?.backgroundColor = UIColor(red: 0.05, green: 0.05, blue: 0.05, alpha: 1.0)
            cell?.textLabel!.textColor = UIColor.white
        }
        if UserDefaults.standard.integer(forKey: "DarkmodeStatus") == 0 {
            cell?.backgroundColor = UIColor.white
            cell?.textLabel!.textColor = UIColor.black
        }
        return cell!
    }
    
    func title(forEmptyDataSet scrollView: UIScrollView) -> NSAttributedString? {
        let str = "Keine Daten"
        let attrs = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 25)]
        return NSAttributedString(string: str, attributes: attrs)
    }
    
    func description(forEmptyDataSet scrollView: UIScrollView) -> NSAttributedString? {
        let str = "Du sieht hier Daten, sobald du eine Anfrage erstellt hast."
        let attrs = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 18)]
        return NSAttributedString(string: str, attributes: attrs)
    }
    
    func buttonTitle(forEmptyDataSet scrollView: UIScrollView, for state: UIControl.State) -> NSAttributedString? {
        var btnColor: UIColor!
        if UserDefaults.standard.integer(forKey: "ManualAppearance") == 0 {
            if #available(iOS 13.0, *) {
                if traitCollection.userInterfaceStyle == .dark {
                    btnColor = .white
                }
                else if traitCollection.userInterfaceStyle == .light || traitCollection.userInterfaceStyle == .unspecified {
                    btnColor = .black
                }
            }
        }
        else {
            if UserDefaults.standard.integer(forKey: "DarkmodeStatus") == 1 {
                btnColor = .white
            }
            else if UserDefaults.standard.integer(forKey: "DarkmodeStatus") == 0 {
                btnColor = .black
            }
        }
        let str = "Schließen"
        let attrs = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 18), NSAttributedString.Key.foregroundColor: btnColor]
        return NSAttributedString(string: str, attributes: attrs as [NSAttributedString.Key: Any])
    }
    
    func emptyDataSet(_ scrollView: UIScrollView, didTap button: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationbar.titleLabel.text = "Anfragenverlauf"
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
        
        InfoTV = UITableView(frame: CGRect(x: 8, y: 100, width: view.frame.width - 16, height: view.frame.height - 200))
        InfoTV.register(UITableViewCell.self, forCellReuseIdentifier: "infocell")
        InfoTV.dataSource = self
        InfoTV.delegate = self
        view.addSubview(InfoTV!)
        
        InfoTV.emptyDataSetSource = self
        InfoTV.emptyDataSetDelegate = self
        InfoTV.tableFooterView = UIView()
        
        
        changeAppearance()
        /*if UserDefaults.standard.integer(forKey: "DarkmodeStatus") == 1 {
            view.backgroundColor = style.darkBackground
            navigationbar.backgroundColor = style.darkTitleBackground
            navigationbar.titleLabel.textColor = style.darkText
            InfoTV.backgroundColor = style.darkBackground
            setNeedsStatusBarAppearanceUpdate()
        }
        if UserDefaults.standard.integer(forKey: "DarkmodeStatus") == 0 {
            view.backgroundColor = style.lightBackground
            navigationbar.backgroundColor = style.lightTitleBackground
            navigationbar.titleLabel.textColor = style.lightText
            InfoTV.backgroundColor = style.lightBackground
            setNeedsStatusBarAppearanceUpdate()
        }*/
        InfoTV.allowsSelection = false
        InfoTV.estimatedRowHeight = 85
        InfoTV.rowHeight = UITableView.automaticDimension
        downloadLog()
    }
    
    func changeAppearance() {
        if UserDefaults.standard.integer(forKey: "ManualAppearance") == 0 {
            if #available(iOS 13.0, *) {
                if traitCollection.userInterfaceStyle == .dark {
                 view.backgroundColor = style.darkBackground
                 navigationbar.backgroundColor = style.darkTitleBackground
                 navigationbar.titleLabel.textColor = style.darkText
                 InfoTV.backgroundColor = style.darkBackground
                    setNeedsStatusBarAppearanceUpdate()
                }
                else if traitCollection.userInterfaceStyle == .light || traitCollection.userInterfaceStyle == .unspecified {
                    view.backgroundColor = style.lightBackground
                    navigationbar.backgroundColor = style.lightTitleBackground
                    navigationbar.titleLabel.textColor = style.lightText
                    InfoTV.backgroundColor = style.lightBackground
                    setNeedsStatusBarAppearanceUpdate()
                }
            }
        }
        else {
            if UserDefaults.standard.integer(forKey: "DarkmodeStatus") == 1 {
                view.backgroundColor = style.darkBackground
                navigationbar.backgroundColor = style.darkTitleBackground
                navigationbar.titleLabel.textColor = style.darkText
                InfoTV.backgroundColor = style.darkBackground
                setNeedsStatusBarAppearanceUpdate()
            }
            else if UserDefaults.standard.integer(forKey: "DarkmodeStatus") == 0 {
                view.backgroundColor = style.lightBackground
                navigationbar.backgroundColor = style.lightTitleBackground
                navigationbar.titleLabel.textColor = style.lightText
                InfoTV.backgroundColor = style.lightBackground
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
    
    func downloadLog() {
        var ref: DatabaseReference!
        
        ref = Database.database().reference()
        
        if idlog != [""] {
            for requestid in idlog {
                var statusi = ""
                ref.child("requests").observeSingleEvent(of: .value) { snap in
                    if snap.hasChild(requestid) {
                        self.log.removeAll()
                        statusi = "In Bearbeitung"
                        ref.child("requests").child(requestid).observe(.value, with: { snappi in
                            if let item = snappi.value as? [String: AnyObject] {
                                let cont = item["Content"] as? String
                                let time = item["time"] as? String
                                self.log.append(Request(id: requestid, content: cont ?? "", status: statusi, time: time ?? "", declined_reas: "-", checked_by: "-"))
                                self.InfoTV.reloadData()
                            }
                        })
                    }
                    else {
                        self.log.removeAll()
                        ref.child("standardData").child("requestlog").child(requestid).observe(.value, with: { snappi in
                            if let item = snappi.value as? [String: AnyObject] {
                                let cont = item["Content"] as? String
                                let time = item["time"] as? String
                                let checkedby = item["checkdBy"] as? String
                                
                                statusi = item["status"] as! String
                                if statusi == "declined" {
                                    let declined_translated = "Abgelehnt"
                                    let declined_r = item["declined_reason"] as! String
                                    self.log.append(Request(id: requestid, content: cont ?? "", status: declined_translated, time: time ?? "", declined_reas: declined_r, checked_by: checkedby ?? ""))
                                }
                                else if statusi == "accepted" {
                                    let accepted_translated = "Angenommen"
                                    self.log.append(Request(id: requestid, content: cont ?? "", status: accepted_translated, time: time ?? "", declined_reas: "-", checked_by: checkedby ?? ""))
                                }
                                self.InfoTV.reloadData()
                            }
                        })
                    }
                }
            }
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    struct Request {
        var id = ""
        var content = ""
        var status = ""
        var time = ""
        var declined_reas = ""
        var checked_by = ""
    }
}
