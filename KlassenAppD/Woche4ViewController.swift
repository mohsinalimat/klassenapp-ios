//
//  Woche4ViewController.swift
//  KlassenAppD
//
//  Created by Adrian Baumgart on 11.06.18.
//  Copyright © 2018 Adrian Baumgart. All rights reserved.
//

import UIKit
import FirebaseDatabase

class Woche4ViewController: UIViewController {

    let network: NetworkManager = NetworkManager.sharedInstance
    @IBOutlet weak var MondayWeek4Text: UITextView!
    @IBOutlet weak var TuesdayWeek4Text: UITextView!
    @IBOutlet weak var WednesdayWeek4Text: UITextView!
    @IBOutlet weak var ThursdayWeek4Text: UITextView!
    @IBOutlet weak var FridayWeek4Text: UITextView!
    @IBOutlet weak var WholeWeek4Text: UITextView!
    
    @IBOutlet weak var HomeworkLabelW4: UILabel!
    
    @IBAction func BackHW4Btn(_ sender: Any)
    {
        FirstViewController.LastVC.LastVCV = "hw"
        self.performSegue(withIdentifier: "hw4tsegue", sender: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if UserDefaults.standard.integer(forKey: "DarkmodeStatus") == 1 {
            view.backgroundColor = UIColor(red:0.08, green:0.08, blue:0.08, alpha:1.0)
            HomeworkLabelW4.textColor = UIColor.white
            MondayWeek4Text.textColor = UIColor.white
            TuesdayWeek4Text.textColor = UIColor.white
            WednesdayWeek4Text.textColor = UIColor.white
            ThursdayWeek4Text.textColor = UIColor.white
            FridayWeek4Text.textColor = UIColor.white
            WholeWeek4Text.textColor = UIColor.white
            UIApplication.shared.statusBarStyle = .lightContent
            MondayWeek4Text.backgroundColor = UIColor(red:0.08, green:0.08, blue:0.08, alpha:1.0)
            TuesdayWeek4Text.backgroundColor = UIColor(red:0.08, green:0.08, blue:0.08, alpha:1.0)
            WednesdayWeek4Text.backgroundColor = UIColor(red:0.08, green:0.08, blue:0.08, alpha:1.0)
            ThursdayWeek4Text.backgroundColor = UIColor(red:0.08, green:0.08, blue:0.08, alpha:1.0)
            FridayWeek4Text.backgroundColor = UIColor(red:0.08, green:0.08, blue:0.08, alpha:1.0)
            WholeWeek4Text.backgroundColor = UIColor(red:0.08, green:0.08, blue:0.08, alpha:1.0)
        }
        if UserDefaults.standard.integer(forKey: "DarkmodeStatus") == 0 {
            view.backgroundColor = UIColor.white
            HomeworkLabelW4.textColor = UIColor.black
            MondayWeek4Text.textColor = UIColor.black
            TuesdayWeek4Text.textColor = UIColor.black
            WednesdayWeek4Text.textColor = UIColor.black
            ThursdayWeek4Text.textColor = UIColor.black
            FridayWeek4Text.textColor = UIColor.black
            WholeWeek4Text.textColor = UIColor.black
            UIApplication.shared.statusBarStyle = .default
            MondayWeek4Text.backgroundColor = UIColor.white
            TuesdayWeek4Text.backgroundColor = UIColor.white
            WednesdayWeek4Text.backgroundColor = UIColor.white
            ThursdayWeek4Text.backgroundColor = UIColor.white
            FridayWeek4Text.backgroundColor = UIColor.white
            WholeWeek4Text.backgroundColor = UIColor.white
        }
        // Do any additional setup after loading the view.
        /*NetworkManager.isUnreachable { (_) in
            var Week4MondayUD = UserDefaults.standard.string(forKey: "UDW4MO")
            var Week4TuesdayUD = UserDefaults.standard.string(forKey: "UDW4TU")
            var Week4WednesdayUD = UserDefaults.standard.string(forKey: "UDW4WE")
            var Week4ThursdayUD = UserDefaults.standard.string(forKey: "UDW4TH")
            var Week4FridayUD = UserDefaults.standard.string(forKey: "UDW4FR")
            var Week4Date = UserDefaults.standard.string(forKey: "UDW4DA")
            if Week4MondayUD == nil {
                self.MondayWeek4Text.text = "Keine Daten vorhanden"
            }
            else {
                self.MondayWeek4Text.text = "S:" + Week4MondayUD!
            }
            if Week4TuesdayUD == nil {
                self.TuesdayWeek4Text.text = "Keine Daten vorhanden"
            }
            else {
                self.TuesdayWeek4Text.text = "S: " + Week4TuesdayUD!
            }
            if Week4WednesdayUD == nil {
                self.WednesdayWeek4Text.text = "Keine Daten vorhanden"
            }
            else {
                self.WednesdayWeek4Text.text = "S: " + Week4WednesdayUD!
            }
            if Week4ThursdayUD == nil {
                self.ThursdayWeek4Text.text = "Keine Daten vorhanden"
            }
            else {
                self.ThursdayWeek4Text.text = "S: " + Week4ThursdayUD!
            }
            if Week4FridayUD == nil {
                self.FridayWeek4Text.text = "Keine Daten vorhanden"
            }
            else {
                self.FridayWeek4Text.text = "S: " + Week4FridayUD!
            }
            if Week4Date == nil {
                self.HomeworkLabelW4.text = "Keine Daten vorhanden"
            }
            else {
                self.HomeworkLabelW4.text = "S: " + Week4Date!
            }
        }*/
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return UIStatusBarStyle(rawValue: UserDefaults.standard.integer(forKey: "DarkmodeStatus"))!
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewDidAppear(_ animated: Bool) {
       
        var ref: DatabaseReference!
        ref = Database.database().reference()
        
        ref.child("homework").child("Week4").child("Monday").observeSingleEvent(of: .value) { (MondayWeek4Snap) in
            let MondayWeek4Home = MondayWeek4Snap.value as? String
            Week4Var.Week4Monday = MondayWeek4Home!
        
        ref.child("homework").child("Week4").child("Tuesday").observeSingleEvent(of: .value) { (TuesdayWeek4Snap) in
            let TuesdayWeek4Home = TuesdayWeek4Snap.value as? String
            Week4Var.Week4Tuesday = TuesdayWeek4Home!
        
        ref.child("homework").child("Week4").child("Wednesday").observeSingleEvent(of: .value) { (WednesdayWeek4Snap) in
            let WednesdayWeek4Home = WednesdayWeek4Snap.value as? String
            Week4Var.Week4Wednesday = WednesdayWeek4Home!
        
        ref.child("homework").child("Week4").child("Thursday").observeSingleEvent(of: .value) { (ThursdayWeek4Snap) in
            let ThursdayWeek4Home = ThursdayWeek4Snap.value as? String
            Week4Var.Week4Thursday = ThursdayWeek4Home!
            
        
        ref.child("homework").child("Week4").child("Friday").observeSingleEvent(of: .value) { (FridayWeek4Snap) in
            let FridayWeek4Home = FridayWeek4Snap.value as? String
            Week4Var.Week4Friday = FridayWeek4Home!
            self.WholeWeek4Text.text = "\(Week4Var.Week4Monday)\n\n\(Week4Var.Week4Tuesday)\n\n\(Week4Var.Week4Wednesday)\n\n\(Week4Var.Week4Thursday)\n\n\(Week4Var.Week4Friday)"
        }
    }
}
}
}
        ref.child("homework").child("Week4").child("Datum").observeSingleEvent(of: .value) { (DateWeek4Snap) in
            let DateWeek4LE = DateWeek4Snap.value as? String
            self.HomeworkLabelW4.text = DateWeek4LE
        }
        
        /*ref.child("homework").child("Week4").child("Monday").observeSingleEvent(of: .value) { (MondayWeek4Snap) in
            let MondayWeek4Home = MondayWeek4Snap.value as? String
            UserDefaults.standard.set(MondayWeek4Home, forKey: "UDW4MO")
            self.MondayWeek4Text.text = MondayWeek4Home
        }
        ref.child("homework").child("Week4").child("Tuesday").observeSingleEvent(of: .value) { (TuesdayWeek4Snap) in
            let TuesdayWeek4Home = TuesdayWeek4Snap.value as? String
            UserDefaults.standard.set(TuesdayWeek4Home, forKey: "UDW4TU")
            self.TuesdayWeek4Text.text = TuesdayWeek4Home
        }
        ref.child("homework").child("Week4").child("Wednesday").observeSingleEvent(of: .value) { (WednesdayWeek4Snap) in
            let WednesdayWeek4Home = WednesdayWeek4Snap.value as? String
            UserDefaults.standard.set(WednesdayWeek4Home, forKey: "UDW4WE")
            self.WednesdayWeek4Text.text = WednesdayWeek4Home
        }
        ref.child("homework").child("Week4").child("Thursday").observeSingleEvent(of: .value) { (ThursdayWeek4Snap) in
            let ThursdayWeek4Home = ThursdayWeek4Snap.value as? String
            UserDefaults.standard.set(ThursdayWeek4Home, forKey: "UDW4TH")
            self.ThursdayWeek4Text.text = ThursdayWeek4Home
        }
        ref.child("homework").child("Week4").child("Friday").observeSingleEvent(of: .value) { (FridayWeek4Snap) in
            let FridayWeek4Home = FridayWeek4Snap.value as? String
            UserDefaults.standard.set(FridayWeek4Home, forKey: "UDW4FR")
            self.FridayWeek4Text.text = FridayWeek4Home
        }
        ref.child("homework").child("Week4").child("Datum").observeSingleEvent(of: .value) { (DateWeek4Snap) in
            let DateWeek4LE = DateWeek4Snap.value as? String
            UserDefaults.standard.set(DateWeek4LE, forKey: "UDW4DA")
            self.HomeworkLabelW4.text = DateWeek4LE
        }*/
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    struct Week4Var {
        static var Week4Monday = ""
        static var Week4Tuesday = ""
        static var Week4Wednesday = ""
        static var Week4Thursday = ""
        static var Week4Friday = ""
    }

}
