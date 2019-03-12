//
//  MoreViewController.swift
//  KlassenAppD
//
//  Created by Adrian Baumgart on 14.07.18.
//  Copyright © 2018 Adrian Baumgart. All rights reserved.
//

import UIKit
import FirebaseDatabase
import MIBadgeButton_Swift
import FirebaseAuth

class MoreViewController: UIViewController {

    @IBOutlet weak var MoreOptionsLabel: UILabel!
    @IBOutlet weak var backgroundTitleView: UIView!
    @IBOutlet weak var AppVersionLabel: UILabel!
    @IBOutlet weak var LastDataUpdated: UILabel!
    @IBOutlet weak var UpdateCenterBtn: MIBadgeButton!
    @IBOutlet weak var ChatBtnOut: UIButton!
    
    @IBAction func FeedbackBtn(_ sender: Any)
    {
        UIApplication.shared.openURL(NSURL(string: "https://goo.gl/forms/8scxGoMvyGfk7Tha2")! as URL)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if UserDefaults.standard.integer(forKey: "Checker") == 1 || UserDefaults.standard.string(forKey: "TEALOGGER") == "tea" {
            ChatBtnOut.isHidden = true
        }
        else if Auth.auth().currentUser != nil {
            ChatBtnOut.isHidden = false
        }
        if UserDefaults.standard.integer(forKey: "DarkmodeStatus") == 1 {
            view.backgroundColor = UIColor(red:0.05, green:0.05, blue:0.05, alpha:1.0)
            backgroundTitleView.backgroundColor = UIColor(red:0.13, green:0.13, blue:0.13, alpha:1.0)
            MoreOptionsLabel.textColor = UIColor.white
            LastDataUpdated.textColor = UIColor.white
            AppVersionLabel.textColor = UIColor.white
            UIApplication.shared.statusBarStyle = .lightContent
        }
        if UserDefaults.standard.integer(forKey: "DarkmodeStatus") == 0 {
            view.backgroundColor = UIColor.white
            backgroundTitleView.backgroundColor = UIColor(red:0.97, green:0.97, blue:0.97, alpha:0.8)
            MoreOptionsLabel.textColor = UIColor.black
            LastDataUpdated.textColor = UIColor.black
            AppVersionLabel.textColor = UIColor.black
            UIApplication.shared.statusBarStyle = .default
        }
        
        let dictionary = Bundle.main.infoDictionary!
        let version = dictionary["CFBundleShortVersionString"] as! String
        let build = dictionary["CFBundleVersion"] as! String
        AppVersionLabel.text = "Version: \(version) (Build: \(build)) "
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool)
    {
        UpdateCenterBtn.badgeString = nil
        
        var ref: DatabaseReference!
        
        ref = Database.database().reference()
        var bundleID = Bundle.main.bundleIdentifier as! String
        if bundleID == "com.adrianbaumgart.KlassenAppDREA1234" {
            ref.child("standardData").child("iosCurrentVer").child("versionnumber").observeSingleEvent(of: .value) { (NewestBuildDB) in
                var NewestBuildDBLE = NewestBuildDB.value as? String
                let dictionary = Bundle.main.infoDictionary!
                let versionCurrent = dictionary["CFBundleShortVersionString"] as! String
                
                if versionCurrent.compare(NewestBuildDBLE!, options: .numeric) == .orderedAscending {
                    self.UpdateCenterBtn.badgeString = "1"
                    
                    /*if LastVC.UpdateReminderSession != "1" {
                     var NewestBuildDBLES = NewestBuildDB.value as! String
                     LastVC.NEWUPDATEVERDB = NewestBuildDBLES
                     let introPage = FirstViewController.bulletinNWUP()
                     self.bulletinManager = BLTNItemManager(rootItem: introPage)
                     self.bulletinManager.showBulletin(above: self)
                     /*while LastVC.showUCC == "0" {
                     if LastVC.showUC == "1" {
                     LastVC.showUCC == "1"
                     self.performSegue(withIdentifier: "gotoupdatecenter", sender: nil)
                     }
                     }*/
                     
                     //self.newUpdatealert(title: "Neues Update", message: "Es gibt eine neue Version der App (Version \(NewestBuildDBLES))")
                     }*/
                }
            }
        }
        
        ref.child("standardData").child("LDU").observeSingleEvent(of: .value) { (LDUCSnap) in
            let LDUCLE = LDUCSnap.value as? String
            self.LastDataUpdated.text = "Letztes Datenbankupdate: " + LDUCLE!
        }
        
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return UIStatusBarStyle(rawValue: UserDefaults.standard.integer(forKey: "DarkmodeStatus"))!
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
