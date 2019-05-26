//
//  AppInfosViewController.swift
//  KlassenAppD
//
//  Created by Adrian Baumgart on 28.12.18.
//  Copyright © 2018 Adrian Baumgart. All rights reserved.
//

import UIKit
import FirebaseDatabase
import SPFakeBar

class AppInfosViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let navigationbar = SPFakeBarView(style: .stork)
    
    private var InfoTV: UITableView!
    
    var n1:[String] = ["Appname: KlassenApp", "Bundle-Identifier: \(AppInfoPublic.bundleid!)", "Appversion: \(AppInfoPublic.version) (Build: \(AppInfoPublic.build))", "Website: https://klassenappd.de", "Email-Adresse: mail@klassenappd.de", "Erstveröffentlichung: 19.Juli 2018", "App-Entwickler: Adrian Baumgart", "Datenbank: Firebase Database", "GitHub-Link: https://github.com/AdriBoy21/klassenapp-ios", "© Adrian Baumgart, 2018 - 2019"]
   /* var n2:[String] = ["KlassenApp", "Adrian", "Firebase", "-Firebase\n-Fabric\n-Crashlytics\n-ReachabilitySwift\n-Alamofire\n-BulletinBoard\n-NotificationBannerSwift\n-RevealingSplashView\n-SendBidSDK\n-MiBadgeButton-Swift\n-SwipeableTabBarController\n-ExpandingMenu\n-SendBirdSDK\n-JGProgressHUD\n-TrueTime"]
    var n3:[String] = ["KlassenApp", "Adrian", "Firebase", "-Firebase -Fabric -Crashlytics -ReachabilitySwift -Alamofire -BulletinBoard -NotificationBannerSwift -RevealingSplashView\n-SendBidSDK -MiBadgeButton-Swift -SwipeableTabBarController\n-ExpandingMenu -SendBirdSDK -JGProgressHUD -TrueTime"]*/
   // @IBOutlet weak var InfoTVCell: AppInfosTableViewCell!
    
    @IBAction func BackBtn(_ sender: Any)
    {
        FirstViewController.LastVC.LastVCV = "settings"
        self.performSegue(withIdentifier: "backfrominfo2", sender: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return n1.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //infocell
        let cell = tableView.dequeueReusableCell(withIdentifier: "infocell")
        cell?.textLabel?.numberOfLines = 0
        cell?.textLabel?.lineBreakMode = .byTruncatingTail
        cell?.textLabel!.text = n1[indexPath.row]
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationbar.titleLabel.text = "Appinformationen"
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
        
        InfoTV = UITableView(frame: CGRect(x: 8, y: 100, width: self.view.frame.width - 16, height: self.view.frame.height - 150))
        InfoTV.register(UITableViewCell.self, forCellReuseIdentifier: "infocell")
        InfoTV.dataSource = self
        InfoTV.delegate = self
        self.view.addSubview(InfoTV!)
        
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
    
    struct AppInfoPublic {
        static var dictionary = Bundle.main.infoDictionary!
        static var version = dictionary["CFBundleShortVersionString"] as! String
        static var build = dictionary["CFBundleVersion"] as! String
        static var bundleid = Bundle.main.bundleIdentifier
        static var database = "Laden..."
    }

}
