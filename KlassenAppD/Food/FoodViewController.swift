//
//  FoodViewController.swift
//  KlassenAppD
//
//  Created by Adrian Baumgart on 14.07.18.
//  Copyright © 2018 Adrian Baumgart. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth
import ExpandingMenu

class FoodViewController: UIViewController {

    let network: NetworkManager = NetworkManager.sharedInstance
    @IBOutlet weak var FoodLabel: UILabel!
    @IBOutlet weak var FoodWeekLabel: UILabel!
    @IBOutlet weak var TitleBackground: UIView!
    @IBOutlet weak var TitleBar: UIView!
    @IBOutlet weak var MondayBtn: UIButton!
    @IBOutlet weak var TuesdayBtn: UIButton!
    @IBOutlet weak var WednesdayBtn: UIButton!
    @IBOutlet weak var ThursdayBtn: UIButton!
    @IBOutlet weak var FridayBtn: UIButton!
    @IBAction func BackBtn(_ sender: Any) {
        FirstViewController.LastVC.LastVCV = "plans"
        self.performSegue(withIdentifier: "backfromfood", sender: nil)
    }
    @IBAction func BackFood(_ sender: Any)
    {
        FirstViewController.LastVC.LastVCV = "settings"
        self.performSegue(withIdentifier: "BackFoodtoEverywhere", sender: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        if UserDefaults.standard.string(forKey: "ButtonColor") != nil && UserDefaults.standard.string(forKey: "ButtonColor") != "" {
            self.MondayBtn.backgroundColor = UIColor(red: CGFloat(UserDefaults.standard.integer(forKey: "ButtonRed"))/255, green: CGFloat(UserDefaults.standard.integer(forKey: "ButtonGreen"))/255, blue: CGFloat(UserDefaults.standard.integer(forKey: "ButtonBlue"))/255, alpha: 1)
            
            self.TuesdayBtn.backgroundColor = UIColor(red: CGFloat(UserDefaults.standard.integer(forKey: "ButtonRed"))/255, green: CGFloat(UserDefaults.standard.integer(forKey: "ButtonGreen"))/255, blue: CGFloat(UserDefaults.standard.integer(forKey: "ButtonBlue"))/255, alpha: 1)
            
            self.WednesdayBtn.backgroundColor = UIColor(red: CGFloat(UserDefaults.standard.integer(forKey: "ButtonRed"))/255, green: CGFloat(UserDefaults.standard.integer(forKey: "ButtonGreen"))/255, blue: CGFloat(UserDefaults.standard.integer(forKey: "ButtonBlue"))/255, alpha: 1)
            
            self.ThursdayBtn.backgroundColor = UIColor(red: CGFloat(UserDefaults.standard.integer(forKey: "ButtonRed"))/255, green: CGFloat(UserDefaults.standard.integer(forKey: "ButtonGreen"))/255, blue: CGFloat(UserDefaults.standard.integer(forKey: "ButtonBlue"))/255, alpha: 1)
            
            self.FridayBtn.backgroundColor = UIColor(red: CGFloat(UserDefaults.standard.integer(forKey: "ButtonRed"))/255, green: CGFloat(UserDefaults.standard.integer(forKey: "ButtonGreen"))/255, blue: CGFloat(UserDefaults.standard.integer(forKey: "ButtonBlue"))/255, alpha: 1)
        }
        if UserDefaults.standard.string(forKey: "TitleBarColor") != nil && UserDefaults.standard.string(forKey: "TitleBarColor") != "" {
            self.TitleBar.backgroundColor = UIColor(red: CGFloat(UserDefaults.standard.integer(forKey: "TitleBarRed"))/255, green: CGFloat(UserDefaults.standard.integer(forKey: "TitleBarGreen"))/255, blue: CGFloat(UserDefaults.standard.integer(forKey: "TitleBarBlue"))/255, alpha: 1)
        }
        
        if UserDefaults.standard.integer(forKey: "DarkmodeStatus") == 1 {
            view.backgroundColor = UIColor(red:0.08, green:0.08, blue:0.08, alpha:1.0)
            TitleBackground.backgroundColor = UIColor(red:0.13, green:0.13, blue:0.13, alpha:1.0)
            FoodLabel.textColor = UIColor.white
            FoodWeekLabel.textColor = UIColor.white
            UIApplication.shared.statusBarStyle = .lightContent
        }
        
        if UserDefaults.standard.integer(forKey: "DarkmodeStatus") == 0 {
            view.backgroundColor = UIColor.white
            TitleBackground.backgroundColor = UIColor(red:0.95, green:0.95, blue:0.95, alpha:1.0)
            FoodLabel.textColor = UIColor.black
            FoodWeekLabel.textColor = UIColor.black
            UIApplication.shared.statusBarStyle = .default
        }
        // Do any additional setup after loading the view.
       /* NetworkManager.isUnreachable { (_) in
            var FoodDateUSER = UserDefaults.standard.string(forKey: "FOODDATEUD")
            if FoodDateUSER == nil {
                self.FoodWeekLabel.text = "Keine Daten vorhanden"
            }
            else {
                self.FoodWeekLabel.text = "S: Aktuelle Woche: " + FoodDateUSER!
            }
        }*/
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return UIStatusBarStyle(rawValue: UserDefaults.standard.integer(forKey: "DarkmodeStatus"))!
    }
    override func viewDidAppear(_ animated: Bool) {
        
        var ref: DatabaseReference!
        
        ref = Database.database().reference()
        
        ref.child("Speiseplan").child("Datum").observeSingleEvent(of: .value) { (FoodDateSnap) in
            let FoodDateLE = FoodDateSnap.value as? String
            UserDefaults.standard.set(FoodDateLE, forKey: "FOODDATEUD")
            self.FoodWeekLabel.text = "Aktuelle Woche: " + FoodDateLE!
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

}
