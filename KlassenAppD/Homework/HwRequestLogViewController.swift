//
//  HwRequestLogViewController.swift
//  KlassenAppD
//
//  Created by Adrian Baumgart on 31.05.19.
//  Copyright © 2019 Adrian Baumgart. All rights reserved.
//

import UIKit
import SPFakeBar
import Firebase

class HwRequestLogViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, DZNEmptyDataSetSource, DZNEmptyDataSetDelegate {

    let navigationbar = SPFakeBarView(style: .stork)
    
    private var InfoTV: UITableView!
    
    var log:[Request] = []
    var idlog:[String] = UserDefaults.standard.stringArray(forKey: "RequestLog") ?? [""]
    /* var n2:[String] = ["KlassenApp", "Adrian", "Firebase", "-Firebase\n-Fabric\n-Crashlytics\n-ReachabilitySwift\n-Alamofire\n-BulletinBoard\n-NotificationBannerSwift\n-RevealingSplashView\n-SendBidSDK\n-MiBadgeButton-Swift\n-SwipeableTabBarController\n-ExpandingMenu\n-SendBirdSDK\n-JGProgressHUD\n-TrueTime"]
     var n3:[String] = ["KlassenApp", "Adrian", "Firebase", "-Firebase -Fabric -Crashlytics -ReachabilitySwift -Alamofire -BulletinBoard -NotificationBannerSwift -RevealingSplashView\n-SendBidSDK -MiBadgeButton-Swift -SwipeableTabBarController\n-ExpandingMenu -SendBirdSDK -JGProgressHUD -TrueTime"]*/
    // @IBOutlet weak var InfoTVCell: AppInfosTableViewCell!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return log.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //infocell
        let cell = tableView.dequeueReusableCell(withIdentifier: "infocell")
        cell?.textLabel?.numberOfLines = 0
        cell?.textLabel?.lineBreakMode = .byTruncatingTail
        //print("\(log[indexPath.row].id) + \(log[indexPath.row].content)")
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
        //cell?.textLabel?.text = log[indexPath.row].id
        if UserDefaults.standard.integer(forKey: "DarkmodeStatus") == 1 {
            cell?.backgroundColor = UIColor(red:0.05, green:0.05, blue:0.05, alpha:1.0)
            cell?.textLabel!.textColor = UIColor.white
        }
        if UserDefaults.standard.integer(forKey: "DarkmodeStatus") == 0 {
            cell?.backgroundColor = UIColor.white
            cell?.textLabel!.textColor = UIColor.black
        }
        return cell!
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        //   let dictionary = Bundle.main.infoDictionary!
        //AppInfoPublic.version = dictionary["CFBundleShortVersionString"] as! String
        //AppInfoPublic.build = dictionary["CFBundleVersion"] as! String
        // InfoTV.reloadData()
        
    }
    
    func title(forEmptyDataSet scrollView: UIScrollView) -> NSAttributedString? {
        let str = "Keine Daten"
        let attrs = [/*NSAttributedString.Key.font: UIFont.preferredFont(forTextStyle: .headline)*/ NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 25)]
        return NSAttributedString(string: str, attributes: attrs)
    }
    
    func description(forEmptyDataSet scrollView: UIScrollView) -> NSAttributedString? {
        let str = "Du sieht hier Daten, sobald du eine Anfrage erstellt hast."
        let attrs = [/*NSAttributedString.Key.font: UIFont.preferredFont(forTextStyle: .body)*/ NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 18)]
        return NSAttributedString(string: str, attributes: attrs)
    }
    
    func buttonTitle(forEmptyDataSet scrollView: UIScrollView, for state: UIControl.State) -> NSAttributedString? {
        var btnColor: UIColor!
        if UserDefaults.standard.integer(forKey: "DarkmodeStatus") == 1 {
            btnColor = .white
        }
        else if UserDefaults.standard.integer(forKey: "DarkmodeStatus") == 0 {
            btnColor = .black
        }
        let str = "Schließen"
        //UIFont.preferredFont(forTextStyle: .callout)
        let attrs = [/*NSAttributedString.Key.font: UIFont.preferredFont(forTextStyle: .callout), */NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 18), NSAttributedString.Key.foregroundColor: btnColor]
        return NSAttributedString(string: str, attributes: attrs as [NSAttributedString.Key : Any])
    }
    
    func emptyDataSet(_ scrollView: UIScrollView, didTap button: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationbar.titleLabel.text = "Anfragenverlauf"
        navigationbar.titleLabel.font = navigationbar.titleLabel.font.withSize(23)
        navigationbar.height = 95
        navigationbar.titleLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
        navigationbar.titleLabel.numberOfLines = 3
        self.view.addSubview(navigationbar)
        for subview in navigationbar.subviews {
            if subview is UIVisualEffectView {
                subview.removeFromSuperview()
            }
        }
        
        let titlebar = UIView(frame: CGRect(x: 0, y: navigationbar.height - 1, width: self.view.frame.width, height: 3))
        titlebar.backgroundColor = UIColor(red:0.61, green:0.32, blue:0.88, alpha:1.0)
        
        if UserDefaults.standard.string(forKey: "TitleBarColor") != nil && UserDefaults.standard.string(forKey: "TitleBarColor") != "" {
            titlebar.backgroundColor = UIColor(red: CGFloat(UserDefaults.standard.integer(forKey: "TitleBarRed"))/255, green: CGFloat(UserDefaults.standard.integer(forKey: "TitleBarGreen"))/255, blue: CGFloat(UserDefaults.standard.integer(forKey: "TitleBarBlue"))/255, alpha: 1)
        }
        self.view.addSubview(titlebar)
        
        InfoTV = UITableView(frame: CGRect(x: 8, y: 100, width: self.view.frame.width - 16, height: self.view.frame.height - 200))
        InfoTV.register(UITableViewCell.self, forCellReuseIdentifier: "infocell")
        InfoTV.dataSource = self
        InfoTV.delegate = self
        self.view.addSubview(InfoTV!)
        
        
        InfoTV.emptyDataSetSource = self
        InfoTV.emptyDataSetDelegate = self
        InfoTV.tableFooterView = UIView()
        
        if UserDefaults.standard.integer(forKey: "DarkmodeStatus") == 1 {
            view.backgroundColor = UIColor(red:0.05, green:0.05, blue:0.05, alpha:1.0)
            navigationbar.backgroundColor = UIColor(red:0.13, green:0.13, blue:0.13, alpha:1.0)
            navigationbar.titleLabel.textColor = .white
            InfoTV.backgroundColor = UIColor(red:0.05, green:0.05, blue:0.05, alpha:1.0)
            self.setNeedsStatusBarAppearanceUpdate()
        }
        if UserDefaults.standard.integer(forKey: "DarkmodeStatus") == 0 {
            view.backgroundColor = UIColor.white
            navigationbar.backgroundColor = UIColor(red:0.95, green:0.95, blue:0.95, alpha:1.0)
            navigationbar.titleLabel.textColor = .black
            InfoTV.backgroundColor = UIColor.white
            self.setNeedsStatusBarAppearanceUpdate()
        }
        InfoTV.allowsSelection = false
        InfoTV.estimatedRowHeight = 85
        InfoTV.rowHeight = UITableView.automaticDimension
        // Do any additional setup after loading the view.
        
        downloadLog()
        
    }
    
    func downloadLog() {
        var ref: DatabaseReference!
        
        ref = Database.database().reference()
        print("LOG: \(idlog)")
        
        if idlog != [""] {
            for requestid in idlog {
                print("REQUESTID: \(requestid)")
                var statusi = ""
                ref.child("requests").observeSingleEvent(of: .value) { (snap) in
                    if snap.hasChild(requestid) {
                        self.log.removeAll()
                        statusi = "In Bearbeitung"
                        print(statusi)
                        ref.child("requests").child(requestid).observe(.value, with: { (snappi) in
                            if let item = snappi.value as? [String:AnyObject] {
                                let cont = item["Content"] as? String
                                let time = item["time"] as? String
                                self.log.append(Request.init(id: requestid, content: cont ?? "", status: statusi, time: time ?? "", declined_reas: "-", checked_by: "-"))
                                print("LOG2: \(self.log)")
                                self.InfoTV.reloadData()
                            }
                        })
                        /*ref.child("requests").child(requestid).child("Content").observeSingleEvent(of: .value, with: { (singlesnap) in
                         let SiSnap = singlesnap.value as! String
                         self.log.append(Request.init(id: requestid, content: SiSnap, status: statusi))
                         print("HALLO: \(self.log)")
                         self.InfoTV.reloadData()
                         })*/
                    }
                    else {
                        self.log.removeAll()
                        ref.child("standardData").child("requestlog").child(requestid).observe(.value, with: { (snappi) in
                            if let item = snappi.value as? [String:AnyObject] {
                                let cont = item["Content"] as? String
                                let time = item["time"] as? String
                                let checkedby = item["checkdBy"] as? String
                                
                                
                                statusi = item["status"] as! String
                                if statusi == "declined" {
                                    let declined_translated = "Abgelehnt"
                                    let declined_r = item["declined_reason"] as! String
                                    self.log.append(Request.init(id: requestid, content: cont ?? "", status: declined_translated, time: time ?? "", declined_reas: declined_r, checked_by: checkedby ?? ""))
                                }
                                else if statusi == "accepted" {
                                    let accepted_translated = "Angenommen"
                                    self.log.append(Request.init(id: requestid, content: cont ?? "", status: accepted_translated, time: time ?? "", declined_reas: "-", checked_by: checkedby ?? ""))
                                }
                                print("HALLO: \(self.log)")
                                self.InfoTV.reloadData()
                            }
                        })
                        /*ref.child("requests").child(requestid).child("Content").observeSingleEvent(of: .value, with: { (singlesnap) in
                         let SiSnap = singlesnap.value as! String
                         self.log.append(Request.init(id: requestid, content: SiSnap, status: statusi))
                         print("HALLO: \(self.log)")
                         self.InfoTV.reloadData()
                         })*/
                    }
                }
            }
        }
        
        
        //InfoTV.reloadData()
        
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
    struct Request {
        var id = ""
        var content = ""
        var status = ""
        var time = ""
        var declined_reas = ""
        var checked_by = ""
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
