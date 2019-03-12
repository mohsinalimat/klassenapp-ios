//
//  Woche1EditViewController.swift
//  KlassenAppD
//
//  Created by Adrian Baumgart on 07.11.18.
//  Copyright © 2018 Adrian Baumgart. All rights reserved.
//

import UIKit
import FirebaseDatabase
import JGProgressHUD

class Woche1EditViewController: UIViewController {

    @IBOutlet weak var MondayWeek1Text: UITextView!
    @IBOutlet weak var TuesdayWeek1Text: UITextView!
    @IBOutlet weak var WednesdayWeek1Text: UITextView!
    @IBOutlet weak var ThursdayWeek1Text: UITextView!
    @IBOutlet weak var FridayWeek1Text: UITextView!
    /*@IBOutlet weak var MondayWeek1Text: UITextView!
    @IBOutlet weak var TuesdayWeek1Text: UITextView!
    @IBOutlet weak var WednesdayWeek1Text: UITextView!
    @IBOutlet weak var ThursdayWeek1Text: UITextView!
    @IBOutlet weak var FridayWeek1Text: UITextView!
    @IBOutlet weak var WholeWeek1Text: UITextView!*/
    @IBOutlet weak var HomeworkLabelW1: UILabel!
    
   // @IBOutlet weak var HomeworkLabelW1: UILabel!
    
    @IBAction func Week1Upload(_ sender: Any)
    {
        let hud = JGProgressHUD(style: .dark)
        hud.textLabel.text = "Hochladen"
        hud.show(in: self.view)
        
        var ref: DatabaseReference!
        
        ref = Database.database().reference()
        ref.child("homework").child("Week1").child("Monday").setValue(MondayWeek1Text.text) {
            (error:Error?, ref:DatabaseReference) in
            if let error = error {
                print("Data could not be saved: \(error).")
            } else {
                print("Data saved successfully!")
                hud.dismiss(animated: true)
            }
        }
        DownloadWeek1()
    }
    @IBAction func HW1BBtn(_ sender: Any)
    {
        FirstViewController.LastVC.LastVCV = "hw"
        self.performSegue(withIdentifier: "hw1tsegue", sender: nil)
    }
    @IBAction func HW1Bbtn(_ sender: Any)
    {
        FirstViewController.LastVC.LastVCV = "hw"
        self.performSegue(withIdentifier: "hw1tsegue", sender: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if UserDefaults.standard.integer(forKey: "DarkmodeStatus") == 1 {
            view.backgroundColor = UIColor(red:0.08, green:0.08, blue:0.08, alpha:1.0)
            HomeworkLabelW1.textColor = UIColor.white
            MondayWeek1Text.textColor = UIColor.white
            TuesdayWeek1Text.textColor = UIColor.white
            WednesdayWeek1Text.textColor = UIColor.white
            ThursdayWeek1Text.textColor = UIColor.white
            FridayWeek1Text.textColor = UIColor.white
           // WholeWeek1Text.textColor = UIColor.white
            UIApplication.shared.statusBarStyle = .lightContent
            MondayWeek1Text.backgroundColor = UIColor(red:0.08, green:0.08, blue:0.08, alpha:1.0)
            TuesdayWeek1Text.backgroundColor = UIColor(red:0.08, green:0.08, blue:0.08, alpha:1.0)
            WednesdayWeek1Text.backgroundColor = UIColor(red:0.08, green:0.08, blue:0.08, alpha:1.0)
            ThursdayWeek1Text.backgroundColor = UIColor(red:0.08, green:0.08, blue:0.08, alpha:1.0)
            FridayWeek1Text.backgroundColor = UIColor(red:0.08, green:0.08, blue:0.08, alpha:1.0)
           // WholeWeek1Text.backgroundColor = UIColor(red:0.08, green:0.08, blue:0.08, alpha:1.0)
        }
        if UserDefaults.standard.integer(forKey: "DarkmodeStatus") == 0 {
            view.backgroundColor = UIColor.white
            HomeworkLabelW1.textColor = UIColor.black
            MondayWeek1Text.textColor = UIColor.black
            TuesdayWeek1Text.textColor = UIColor.black
            WednesdayWeek1Text.textColor = UIColor.black
            ThursdayWeek1Text.textColor = UIColor.black
            FridayWeek1Text.textColor = UIColor.black
           // WholeWeek1Text.textColor = UIColor.black
            UIApplication.shared.statusBarStyle = .default
            MondayWeek1Text.backgroundColor = UIColor.white
            TuesdayWeek1Text.backgroundColor = UIColor.white
            WednesdayWeek1Text.backgroundColor = UIColor.white
            ThursdayWeek1Text.backgroundColor = UIColor.white
            FridayWeek1Text.backgroundColor = UIColor.white
           // WholeWeek1Text.backgroundColor = UIColor.white
            
        }
        // Do any additional setup after loading the view.
        /*NetworkManager.isUnreachable { (_) in
         var Week1MondayUD = UserDefaults.standard.string(forKey: "UDW1MO")
         var Week1TuesdayUD = UserDefaults.standard.string(forKey: "UDW1TU")
         var Week1WednesdayUD = UserDefaults.standard.string(forKey: "UDW1WE")
         var Week1ThursdayUD = UserDefaults.standard.string(forKey: "UDW1TH")
         var Week1FridayUD = UserDefaults.standard.string(forKey: "UDW1FR")
         var Week1Date = UserDefaults.standard.string(forKey: "UDW1DA")
         if Week1MondayUD == nil {
         self.MondayWeek1Text.text = "Keine Daten vorhanden"
         }
         else {
         self.MondayWeek1Text.text = "S:" + Week1MondayUD!
         }
         if Week1TuesdayUD == nil {
         self.TuesdayWeek1Text.text = "Keine Daten vorhanden"
         }
         else {
         self.TuesdayWeek1Text.text = "S: " + Week1TuesdayUD!
         }
         if Week1WednesdayUD == nil {
         self.WednesdayWeek1Text.text = "Keine Daten vorhanden"
         }
         else {
         self.WednesdayWeek1Text.text = "S: " + Week1WednesdayUD!
         }
         if Week1ThursdayUD == nil {
         self.ThursdayWeek1Text.text = "Keine Daten vorhanden"
         }
         else {
         self.ThursdayWeek1Text.text = "S: " + Week1ThursdayUD!
         }
         if Week1FridayUD == nil {
         self.FridayWeek1Text.text = "Keine Daten vorhanden"
         }
         else {
         self.FridayWeek1Text.text = "S: " + Week1FridayUD!
         }
         if Week1Date == nil {
         self.HomeworkLabelW1.text = "Keine Daten vorhanden"
         }
         else {
         self.HomeworkLabelW1.text = "S: " + Week1Date!
         }
         }*/
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return UIStatusBarStyle(rawValue: UserDefaults.standard.integer(forKey: "DarkmodeStatus"))!
    }
    /*  let date = Date()
     let calendar = Calendar.current
     
     let currentday = calendar.component(.weekday, from: date)
     
     print(currentday) */
    
    /* So = 1
     Mo = 2
     Di = 3
     Mi = 4
     Do = 5
     Fr = 6
     Sa = 7 */
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func DownloadWeek1() {
        var ref: DatabaseReference!
        
        ref = Database.database().reference()
        ref.child("homework").child("Week1").child("Monday").observeSingleEvent(of: .value) { (MondayWeek1Snap) in
            let MondayWeek1Home = MondayWeek1Snap.value as? String
            self.MondayWeek1Text.text = MondayWeek1Home
            
            ref.child("homework").child("Week1").child("Tuesday").observeSingleEvent(of: .value) { (TuesdayWeek1Snap) in
                let TuesdayWeek1Home = TuesdayWeek1Snap.value as? String
                self.TuesdayWeek1Text.text = TuesdayWeek1Home
                
                ref.child("homework").child("Week1").child("Wednesday").observeSingleEvent(of: .value) { (WednesdayWeek1Snap) in
                    let WednesdayWeek1Home = WednesdayWeek1Snap.value as? String
                    self.WednesdayWeek1Text.text = WednesdayWeek1Home
                    
                    ref.child("homework").child("Week1").child("Thursday").observeSingleEvent(of: .value) { (ThursdayWeek1Snap) in
                        let ThursdayWeek1Home = ThursdayWeek1Snap.value as? String
                        self.ThursdayWeek1Text.text = ThursdayWeek1Home
                        
                        ref.child("homework").child("Week1").child("Friday").observeSingleEvent(of: .value) { (FridayWeek1Snap) in
                            let FridayWeek1Home = FridayWeek1Snap.value as? String
                            self.FridayWeek1Text.text = FridayWeek1Home
                            /*  Week1Var.Week1Friday = FridayWeek1Home!
                             self.WholeWeek1Text.text = "\(Week1Var.Week1Monday)\n\n\(Week1Var.Week1Tuesday)\n\n\(Week1Var.Week1Wednesday)\n\n\(Week1Var.Week1Thursday)\n\n\(Week1Var.Week1Friday)"*/
                        }
                    }
                }
            }
        }
        ref.child("homework").child("Week1").child("Datum").observeSingleEvent(of: .value) { (DateWeek1Snap) in
            let DateWeek1LE = DateWeek1Snap.value as? String
            self.HomeworkLabelW1.text = DateWeek1LE
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        /*if UserDefaults.standard.integer(forKey: "Checker") != 1 && UserDefaults.standard.string(forKey: "TEALOGGER") != "tea" {
         self.performSegue(withIdentifier: "HW1toLogin", sender: nil)
         }*/
        var ref: DatabaseReference!
        
        ref = Database.database().reference()
        DownloadWeek1()
        
        /*ref.child("homework").child("Week1").child("Monday").observeSingleEvent(of: .value) { (MondayWeek1Snap) in
         let MondayWeek1Home = MondayWeek1Snap.value as? String
         UserDefaults.standard.set(MondayWeek1Home, forKey: "UDW1MO")
         self.MondayWeek1Text.text = MondayWeek1Home
         }
         ref.child("homework").child("Week1").child("Tuesday").observeSingleEvent(of: .value) { (TuesdayWeek1Snap) in
         let TuesdayWeek1Home = TuesdayWeek1Snap.value as? String
         UserDefaults.standard.set(TuesdayWeek1Home, forKey: "UDW1TU")
         self.TuesdayWeek1Text.text = TuesdayWeek1Home
         }
         ref.child("homework").child("Week1").child("Wednesday").observeSingleEvent(of: .value) { (WednesdayWeek1Snap) in
         let WednesdayWeek1Home = WednesdayWeek1Snap.value as? String
         UserDefaults.standard.set(WednesdayWeek1Home, forKey: "UDW1WE")
         self.WednesdayWeek1Text.text = WednesdayWeek1Home
         }
         ref.child("homework").child("Week1").child("Thursday").observeSingleEvent(of: .value) { (ThursdayWeek1Snap) in
         let ThursdayWeek1Home = ThursdayWeek1Snap.value as? String
         UserDefaults.standard.set(ThursdayWeek1Home, forKey: "UDW1TH")
         self.ThursdayWeek1Text.text = ThursdayWeek1Home
         }
         ref.child("homework").child("Week1").child("Friday").observeSingleEvent(of: .value) { (FridayWeek1Snap) in
         let FridayWeek1Home = FridayWeek1Snap.value as? String
         UserDefaults.standard.set(FridayWeek1Home, forKey: "UDW1FR")
         self.FridayWeek1Text.text = FridayWeek1Home
         }
         ref.child("homework").child("Week1").child("Datum").observeSingleEvent(of: .value) { (DateWeek1Snap) in
         let DateWeek1LE = DateWeek1Snap.value as? String
         UserDefaults.standard.set(DateWeek1LE, forKey: "UDW1DA")
         self.HomeworkLabelW1.text = DateWeek1LE
         }*/
        
        
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
