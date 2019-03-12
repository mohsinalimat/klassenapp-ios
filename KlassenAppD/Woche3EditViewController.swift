//
//  Woche3EditViewController.swift
//  KlassenAppD
//
//  Created by Adrian Baumgart on 07.11.18.
//  Copyright © 2018 Adrian Baumgart. All rights reserved.
//

import UIKit
import FirebaseDatabase

class Woche3EditViewController: UIViewController {

    let network: NetworkManager = NetworkManager.sharedInstance
    @IBOutlet weak var MondayWeek3Text: UITextView!
    @IBOutlet weak var TuesdayWeek3Text: UITextView!
    @IBOutlet weak var WednesdayWeek3Text: UITextView!
    @IBOutlet weak var ThursdayWeek3Text: UITextView!
    @IBOutlet weak var FridayWeek3Text: UITextView!
    /* @IBOutlet weak var MondayWeek3Text: UITextView!
    @IBOutlet weak var TuesdayWeek3Text: UITextView!
    @IBOutlet weak var WednesdayWeek3Text: UITextView!
    @IBOutlet weak var ThursdayWeek3Text: UITextView!
    @IBOutlet weak var FridayWeek3Text: UITextView!
    @IBOutlet weak var WholeWeek3Text: UITextView!*/
    
     @IBOutlet weak var HomeworkLabelW3: UILabel!
    
    @IBAction func Week3Upload(_ sender: Any)
    {
        DownloadWeek3()
    }
    
    @IBAction func HW3BBtn(_ sender: Any)
    {
        FirstViewController.LastVC.LastVCV = "hw"
        self.performSegue(withIdentifier: "hw3tsegue", sender: nil)
    }
    @IBAction func HW3Bbtn(_ sender: Any)
    {
        FirstViewController.LastVC.LastVCV = "hw"
        self.performSegue(withIdentifier: "hw3tsegue", sender: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if UserDefaults.standard.integer(forKey: "DarkmodeStatus") == 1 {
            view.backgroundColor = UIColor(red:0.08, green:0.08, blue:0.08, alpha:1.0)
            HomeworkLabelW3.textColor = UIColor.white
            MondayWeek3Text.textColor = UIColor.white
            TuesdayWeek3Text.textColor = UIColor.white
            WednesdayWeek3Text.textColor = UIColor.white
            ThursdayWeek3Text.textColor = UIColor.white
            FridayWeek3Text.textColor = UIColor.white
           // WholeWeek3Text.textColor = UIColor.white
            UIApplication.shared.statusBarStyle = .lightContent
            MondayWeek3Text.backgroundColor = UIColor(red:0.08, green:0.08, blue:0.08, alpha:1.0)
            TuesdayWeek3Text.backgroundColor = UIColor(red:0.08, green:0.08, blue:0.08, alpha:1.0)
            WednesdayWeek3Text.backgroundColor = UIColor(red:0.08, green:0.08, blue:0.08, alpha:1.0)
            ThursdayWeek3Text.backgroundColor = UIColor(red:0.08, green:0.08, blue:0.08, alpha:1.0)
            FridayWeek3Text.backgroundColor = UIColor(red:0.08, green:0.08, blue:0.08, alpha:1.0)
           // WholeWeek3Text.backgroundColor = UIColor(red:0.08, green:0.08, blue:0.08, alpha:1.0)
        }
        if UserDefaults.standard.integer(forKey: "DarkmodeStatus") == 0 {
            view.backgroundColor = UIColor.white
            HomeworkLabelW3.textColor = UIColor.black
            MondayWeek3Text.textColor = UIColor.black
            TuesdayWeek3Text.textColor = UIColor.black
            WednesdayWeek3Text.textColor = UIColor.black
            ThursdayWeek3Text.textColor = UIColor.black
            FridayWeek3Text.textColor = UIColor.black
            //WholeWeek3Text.textColor = UIColor.black
            UIApplication.shared.statusBarStyle = .default
            MondayWeek3Text.backgroundColor = UIColor.white
            TuesdayWeek3Text.backgroundColor = UIColor.white
            WednesdayWeek3Text.backgroundColor = UIColor.white
            ThursdayWeek3Text.backgroundColor = UIColor.white
            FridayWeek3Text.backgroundColor = UIColor.white
          //  WholeWeek3Text.backgroundColor = UIColor.white
        }
        // Do any additional setup after loading the view.
        /*NetworkManager.isUnreachable { (_) in
         var Week3MondayUD = UserDefaults.standard.string(forKey: "UDW3MO")
         var Week3TuesdayUD = UserDefaults.standard.string(forKey: "UDW3TU")
         var Week3WednesdayUD = UserDefaults.standard.string(forKey: "UDW3WE")
         var Week3ThursdayUD = UserDefaults.standard.string(forKey: "UDW3TH")
         var Week3FridayUD = UserDefaults.standard.string(forKey: "UDW3FR")
         var Week3Date = UserDefaults.standard.string(forKey: "UDW3DA")
         if Week3MondayUD == nil {
         self.MondayWeek3Text.text = "Keine Daten vorhanden"
         }
         else {
         self.MondayWeek3Text.text = "S:" + Week3MondayUD!
         }
         if Week3TuesdayUD == nil {
         self.TuesdayWeek3Text.text = "Keine Daten vorhanden"
         }
         else {
         self.TuesdayWeek3Text.text = "S: " + Week3TuesdayUD!
         }
         if Week3WednesdayUD == nil {
         self.WednesdayWeek3Text.text = "Keine Daten vorhanden"
         }
         else {
         self.WednesdayWeek3Text.text = "S: " + Week3WednesdayUD!
         }
         if Week3ThursdayUD == nil {
         self.ThursdayWeek3Text.text = "Keine Daten vorhanden"
         }
         else {
         self.ThursdayWeek3Text.text = "S: " + Week3ThursdayUD!
         }
         if Week3FridayUD == nil {
         self.FridayWeek3Text.text = "Keine Daten vorhanden"
         }
         else {
         self.FridayWeek3Text.text = "S: " + Week3FridayUD!
         }
         if Week3Date == nil {
         self.HomeworkLabelW3.text = "Keine Daten vorhanden"
         }
         else {
         self.HomeworkLabelW3.text = "S: " + Week3Date!
         }
         }*/
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return UIStatusBarStyle(rawValue: UserDefaults.standard.integer(forKey: "DarkmodeStatus"))!
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func DownloadWeek3() {
        var ref: DatabaseReference!
        
        ref = Database.database().reference()
        ref.child("homework").child("Week3").child("Monday").observeSingleEvent(of: .value) { (MondayWeek3Snap) in
            let MondayWeek3Home = MondayWeek3Snap.value as? String
            self.MondayWeek3Text.text = MondayWeek3Home
            
            ref.child("homework").child("Week3").child("Tuesday").observeSingleEvent(of: .value) { (TuesdayWeek3Snap) in
                let TuesdayWeek3Home = TuesdayWeek3Snap.value as? String
                self.TuesdayWeek3Text.text = TuesdayWeek3Home
                
                ref.child("homework").child("Week3").child("Wednesday").observeSingleEvent(of: .value) { (WednesdayWeek3Snap) in
                    let WednesdayWeek3Home = WednesdayWeek3Snap.value as? String
                    self.WednesdayWeek3Text.text = WednesdayWeek3Home
                    
                    ref.child("homework").child("Week3").child("Thursday").observeSingleEvent(of: .value) { (ThursdayWeek3Snap) in
                        let ThursdayWeek3Home = ThursdayWeek3Snap.value as? String
                        self.ThursdayWeek3Text.text = ThursdayWeek3Home
                        
                        
                        ref.child("homework").child("Week3").child("Friday").observeSingleEvent(of: .value) { (FridayWeek3Snap) in
                            let FridayWeek3Home = FridayWeek3Snap.value as? String
                            self.FridayWeek3Text.text = FridayWeek3Home
                            /*  Week3Var.Week3Friday = FridayWeek3Home!
                             self.WholeWeek3Text.text = "\(Week3Var.Week3Monday)\n\n\(Week3Var.Week3Tuesday)\n\n\(Week3Var.Week3Wednesday)\n\n\(Week3Var.Week3Thursday)\n\n\(Week3Var.Week3Friday)"*/
                        }
                    }
                }
            }
        }
        ref.child("homework").child("Week3").child("Datum").observeSingleEvent(of: .value) { (DateWeek3Snap) in
            let DateWeek3LE = DateWeek3Snap.value as? String
            self.HomeworkLabelW3.text = DateWeek3LE
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        var ref: DatabaseReference!
        
        ref = Database.database().reference()
        
        DownloadWeek3()
        
        /*ref.child("homework").child("Week3").child("Monday").observeSingleEvent(of: .value) { (MondayWeek3Snap) in
         let MondayWeek3Home = MondayWeek3Snap.value as? String
         UserDefaults.standard.set(MondayWeek3Home, forKey: "UDW3MO")
         self.MondayWeek3Text.text = MondayWeek3Home
         }
         ref.child("homework").child("Week3").child("Tuesday").observeSingleEvent(of: .value) { (TuesdayWeek3Snap) in
         let TuesdayWeek3Home = TuesdayWeek3Snap.value as? String
         UserDefaults.standard.set(TuesdayWeek3Home, forKey: "UDW3TU")
         self.TuesdayWeek3Text.text = TuesdayWeek3Home
         }
         ref.child("homework").child("Week3").child("Wednesday").observeSingleEvent(of: .value) { (WednesdayWeek3Snap) in
         let WednesdayWeek3Home = WednesdayWeek3Snap.value as? String
         UserDefaults.standard.set(WednesdayWeek3Home, forKey: "UDW3WE")
         self.WednesdayWeek3Text.text = WednesdayWeek3Home
         }
         ref.child("homework").child("Week3").child("Thursday").observeSingleEvent(of: .value) { (ThursdayWeek3Snap) in
         let ThursdayWeek3Home = ThursdayWeek3Snap.value as? String
         UserDefaults.standard.set(ThursdayWeek3Home, forKey: "UDW3TH")
         self.ThursdayWeek3Text.text = ThursdayWeek3Home
         }
         ref.child("homework").child("Week3").child("Friday").observeSingleEvent(of: .value) { (FridayWeek3Snap) in
         let FridayWeek3Home = FridayWeek3Snap.value as? String
         UserDefaults.standard.set(FridayWeek3Home, forKey: "UDW3FR")
         self.FridayWeek3Text.text = FridayWeek3Home
         }
         ref.child("homework").child("Week3").child("Datum").observeSingleEvent(of: .value) { (DateWeek3Snap) in
         let DateWeek3LE = DateWeek3Snap.value as? String
         UserDefaults.standard.set(DateWeek3LE, forKey: "UDW3DA")
         self.HomeworkLabelW3.text = DateWeek3LE
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
