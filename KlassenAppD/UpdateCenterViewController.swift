//
//  UpdateCenterViewController.swift
//  KlassenAppD
//
//  Created by Adrian Baumgart on 20.10.18.
//  Copyright © 2018 Adrian Baumgart. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth
import ExpandingMenu

class UpdateCenterViewController: UIViewController {

    @IBOutlet weak var UCTBack: UIView!
    @IBOutlet weak var UCTitle: UILabel!
    @IBOutlet weak var UCSearchIndicator: UILabel!
    @IBOutlet weak var UCSearchActivityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var UCNUpdateView: UIView!
    @IBOutlet weak var UCNUTitle: UILabel!
    @IBOutlet weak var UCNUNumber: UILabel!
    @IBOutlet weak var UCUNDescription: UITextView!

    @IBAction func BackfromUCBtn(_ sender: Any)
    {
        FirstViewController.LastVC.LastVCV = "UpdateCenter"
        self.performSegue(withIdentifier: "backfromuc", sender: nil)
    }
    @IBAction func UCUNInstallBtn(_ sender: Any)
    {
        var ref: DatabaseReference!
        
        ref = Database.database().reference()
        
        ref.child("standardData").child("iosCurrentVer").child("UpdateLink").observeSingleEvent(of: .value) { (linksnap) in
            let linksnapLE = linksnap.value as! String
            print(linksnapLE)
            UIApplication.shared.openURL(NSURL(string: linksnapLE)! as URL)
        }
       // UIApplication.shared.openURL(NSURL(string: "https://klassenappd-team.github.io")! as URL)
    }
    override func viewDidLoad() {
        UCSearchActivityIndicator.isHidden = false
        UCSearchActivityIndicator.startAnimating()
        UCPublic.UpdateRecieved = "0"
        UCNUpdateView.isHidden = true
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
        let item8 = ExpandingMenuItem(size: menuButtonSize, title: "Chat", image: UIImage(named: "chat")!, highlightedImage: UIImage(named: "chat")!, backgroundImage: UIImage(named: "chat"), backgroundHighlightedImage: UIImage(named: "chat")) { () -> Void in
            if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "chatID") as? ChatViewController
            {
                self.present(vc, animated: true, completion: nil)
            }
            // Do some action
            print("btn8")
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
            menuButton.addMenuItems([item00, item0, item1, item2, item3, item4, item5, item6, item8, item9])
        }
        else {
            menuButton.addMenuItems([item00, item0, item1, item2, item3, item4, item5, item6, item9])
        }
        if UserDefaults.standard.integer(forKey: "DarkmodeStatus") == 1 {
            view.backgroundColor = UIColor(red:0.05, green:0.05, blue:0.05, alpha:1.0)
            UCTBack.backgroundColor = UIColor(red:0.13, green:0.13, blue:0.13, alpha:1.0)
            UCNUpdateView.backgroundColor = UIColor(red:0.05, green:0.05, blue:0.05, alpha:1.0)
            UCTitle.textColor = UIColor.white
            UCSearchIndicator.textColor = UIColor.white
            UCSearchActivityIndicator.color = UIColor.white
            UCNUTitle.textColor = UIColor.white
            UCNUNumber.textColor = UIColor.white
            UCUNDescription.textColor = UIColor.white
            UCUNDescription.backgroundColor = UIColor(red:0.05, green:0.05, blue:0.05, alpha:1.0)
            UIApplication.shared.statusBarStyle = .lightContent
        }
        if UserDefaults.standard.integer(forKey: "DarkmodeStatus") == 0 {
            view.backgroundColor = UIColor.white
            UCTBack.backgroundColor = UIColor(red:0.97, green:0.97, blue:0.97, alpha:0.8)
            UCNUpdateView.backgroundColor = UIColor.white
            UCTitle.textColor = UIColor.black
            UCSearchIndicator.textColor = UIColor.black
            UCSearchActivityIndicator.color = UIColor.gray
            UCNUTitle.textColor = UIColor.black
            UCNUNumber.textColor = UIColor.black
            UCUNDescription.textColor = UIColor.black
            UCUNDescription.backgroundColor = UIColor.white
            UIApplication.shared.statusBarStyle = .default
        }

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        var ref: DatabaseReference!
        
        ref = Database.database().reference()
        
        ref.child("standardData").child("iosCurrentVer").child("versionnumber").observeSingleEvent(of: .value) { (UCNewUpdate) in
            let UCNewUpdateLE = UCNewUpdate.value as! String
            UCPublic.UpdateRecieved = "1"
            self.UCSearchActivityIndicator.stopAnimating()
            self.UCSearchActivityIndicator.isHidden = true
            let dictionary = Bundle.main.infoDictionary!
            let versionCurrent = dictionary["CFBundleShortVersionString"] as! String
            
            if versionCurrent.compare(UCNewUpdateLE, options: .numeric) == .orderedAscending {
                self.UCSearchIndicator.isHidden = true
                self.UCNUNumber.text = "Updatenummer: \(UCNewUpdateLE)"
                ref.child("standardData").child("iosCurrentVer").child("description").observeSingleEvent(of: .value, with: { (UCNewUpdateDes) in
                    let UCNewUpdateDesLE = UCNewUpdateDes.value as! String
                    self.UCUNDescription.text = "Beschreibung: \(UCNewUpdateDesLE)"
                })
                self.UCNUpdateView.isHidden = false
            }
            if versionCurrent.compare(UCNewUpdateLE, options: .numeric) == .orderedDescending {
                self.UCSearchIndicator.isHidden = true
                
                self.UCNUTitle.text = "Moment..."
                self.UCNUNumber.text = "Etwas ist schief gelaufen"
                self.UCUNDescription.text = "Du befindest dich in einer Betaversion. Solange die finale Version nicht veröffentlicht wurde, wirst du hier nichts finden ;)"
                self.UCNUpdateView.isHidden = false
            }
            if versionCurrent == UCNewUpdateLE {
                self.UCSearchIndicator.text = "Kein neues Update"
                self.UCSearchActivityIndicator.stopAnimating()
                self.UCSearchActivityIndicator.isHidden = true
            }
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    struct UCPublic {
        static var UpdateRecieved = "0"
    }

}
