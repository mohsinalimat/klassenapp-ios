//
//  AppInfosViewController.swift
//  KlassenAppD
//
//  Created by Adrian Baumgart on 28.12.18.
//  Copyright © 2018 Adrian Baumgart. All rights reserved.
//

import UIKit
import FirebaseDatabase

class AppInfosViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var n1:[String] = ["Appname: KlassenApp", "Appversion: \(AppInfoPublic.version) (Build \(AppInfoPublic.build))", "Website: klassenappd.de", "Email-Adresse: mail@klassenappd.de", "Erstveröffentlichung: 19.Juli 2018", "App-Entwickler: Adrian Baumgart", "Datenbank: Firebase Database", "Verwendete Bibliotheken:\n-Firebase:\n  -Firebase/Core\n  -Firebase/Database\n  -Firebase/Auth\n  -Firebase/Storage\n  -Firebase/Crash\n  -Firebase/Messaging\n  -Firebase/InAppMessagingDisplay\n  -Firebase/Performance\n  -Firebase/Functions\n\n-Fabric\n-Crashlytics\n-ReachabilitySwift\n-Alamofire\n-BulletinBoard\n-NotificationBannerSwift\n-RevealingSplashView\n-SendBidSDK\n-MiBadgeButton-Swift\n-SwipeableTabBarController\n-ExpandingMenu\n-JGProgressHUD\n-TrueTime", "Vielen Dank an:\n-Die Klasse 8d\n-Xcode\n-Apple\n-Swift\n-Google\n-GitHub\n-Fabric\n-ashleymills\n-Almaofire\n-alexaubry\n-Daltron\n-PiXeL16\n-SendBird\n-mustafaibrahim989\n-marcosgriselli\n-monoqlo\n-JonasGessner\n-instacart", "© Adrian Baumgart, 2019"]
   /* var n2:[String] = ["KlassenApp", "Adrian", "Firebase", "-Firebase\n-Fabric\n-Crashlytics\n-ReachabilitySwift\n-Alamofire\n-BulletinBoard\n-NotificationBannerSwift\n-RevealingSplashView\n-SendBidSDK\n-MiBadgeButton-Swift\n-SwipeableTabBarController\n-ExpandingMenu\n-SendBirdSDK\n-JGProgressHUD\n-TrueTime"]
    var n3:[String] = ["KlassenApp", "Adrian", "Firebase", "-Firebase -Fabric -Crashlytics -ReachabilitySwift -Alamofire -BulletinBoard -NotificationBannerSwift -RevealingSplashView\n-SendBidSDK -MiBadgeButton-Swift -SwipeableTabBarController\n-ExpandingMenu -SendBirdSDK -JGProgressHUD -TrueTime"]*/
    @IBOutlet weak var TItle: UILabel!
    @IBOutlet weak var TitleBackground: UIView!
   // @IBOutlet weak var InfoTVCell: AppInfosTableViewCell!
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return n1.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //infocell
        var cell = tableView.dequeueReusableCell(withIdentifier: "infocell", for: indexPath) as? AppInfosTableViewCell
        cell?.TitleName.text = n1[indexPath.row]
        if UserDefaults.standard.integer(forKey: "DarkmodeStatus") == 1 {
            cell!.backgroundColor = UIColor(red:0.05, green:0.05, blue:0.05, alpha:1.0)
            cell?.TitleName.textColor = UIColor.white
        }
        if UserDefaults.standard.integer(forKey: "DarkmodeStatus") == 0 {
            cell!.backgroundColor = UIColor.white
            cell?.TitleName.textColor = UIColor.black
        }
        return cell!
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
     //   let dictionary = Bundle.main.infoDictionary!
        //AppInfoPublic.version = dictionary["CFBundleShortVersionString"] as! String
        //AppInfoPublic.build = dictionary["CFBundleVersion"] as! String
       // InfoTV.reloadData()
        
    }
    
    @IBOutlet weak var InfoTV: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        if UserDefaults.standard.integer(forKey: "DarkmodeStatus") == 1 {
            view.backgroundColor = UIColor(red:0.05, green:0.05, blue:0.05, alpha:1.0)
            TitleBackground.backgroundColor = UIColor(red:0.13, green:0.13, blue:0.13, alpha:1.0)
            TItle.textColor = UIColor.white
            InfoTV.backgroundColor = UIColor(red:0.05, green:0.05, blue:0.05, alpha:1.0)
            UIApplication.shared.statusBarStyle = .lightContent
        }
        if UserDefaults.standard.integer(forKey: "DarkmodeStatus") == 0 {
            view.backgroundColor = UIColor.white
            TitleBackground.backgroundColor = UIColor(red:0.97, green:0.97, blue:0.97, alpha:0.8)
            TItle.textColor = UIColor.black
            InfoTV.backgroundColor = UIColor.white
            UIApplication.shared.statusBarStyle = .default
        }
        InfoTV.allowsSelection = false
        InfoTV.estimatedRowHeight = 85
        InfoTV.rowHeight = UITableView.automaticDimension
        // Do any additional setup after loading the view.
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
        static var database = "Laden..."
    }

}
