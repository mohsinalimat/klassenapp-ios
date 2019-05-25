//
//  Woche2ViewController.swift
//  KlassenAppD
//
//  Created by Adrian Baumgart on 11.06.18.
//  Copyright © 2018 Adrian Baumgart. All rights reserved.
//

import UIKit
import FirebaseDatabase
import NVActivityIndicatorView

class Woche2ViewController: UIViewController {
    
    @IBOutlet weak var MondayWeek2Text: UITextView!
    @IBOutlet weak var TuesdayWeek2Text: UITextView!
    @IBOutlet weak var WednesdayWeek2Text: UITextView!
    @IBOutlet weak var ThursdayWeek2Text: UITextView!
    @IBOutlet weak var FridayWeek2Text: UITextView!
    @IBOutlet weak var WholeWeek2Text: UITextView!
    
    @IBOutlet weak var HomeworkLabelW2: UILabel!
    
    var loader : NVActivityIndicatorView!

    
    @IBAction func HW2BBtn(_ sender: Any)
    {
        FirstViewController.LastVC.LastVCV = "hw"
        self.performSegue(withIdentifier: "hw2tsegue", sender: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loader = NVActivityIndicatorView(frame: CGRect(x: self.view.center.x-25, y: self.view.center.y-25, width: 50, height: 50))
        loader.type = .ballPulseSync
        loader.color = UIColor.red
        view.addSubview(loader)
        loader.startAnimating()
        if UserDefaults.standard.integer(forKey: "DarkmodeStatus") == 1 {
            view.backgroundColor = UIColor(red:0.08, green:0.08, blue:0.08, alpha:1.0)
            HomeworkLabelW2.textColor = UIColor.white
            MondayWeek2Text.textColor = UIColor.white
            TuesdayWeek2Text.textColor = UIColor.white
            WednesdayWeek2Text.textColor = UIColor.white
            ThursdayWeek2Text.textColor = UIColor.white
            FridayWeek2Text.textColor = UIColor.white
            WholeWeek2Text.textColor = UIColor.white
            self.setNeedsStatusBarAppearanceUpdate()
            MondayWeek2Text.backgroundColor = UIColor(red:0.08, green:0.08, blue:0.08, alpha:1.0)
            TuesdayWeek2Text.backgroundColor = UIColor(red:0.08, green:0.08, blue:0.08, alpha:1.0)
            WednesdayWeek2Text.backgroundColor = UIColor(red:0.08, green:0.08, blue:0.08, alpha:1.0)
            ThursdayWeek2Text.backgroundColor = UIColor(red:0.08, green:0.08, blue:0.08, alpha:1.0)
            FridayWeek2Text.backgroundColor = UIColor(red:0.08, green:0.08, blue:0.08, alpha:1.0)
            WholeWeek2Text.backgroundColor = UIColor(red:0.08, green:0.08, blue:0.08, alpha:1.0)
        }
        if UserDefaults.standard.integer(forKey: "DarkmodeStatus") == 0 {
            view.backgroundColor = UIColor.white
            HomeworkLabelW2.textColor = UIColor.black
            MondayWeek2Text.textColor = UIColor.black
            TuesdayWeek2Text.textColor = UIColor.black
            WednesdayWeek2Text.textColor = UIColor.black
            ThursdayWeek2Text.textColor = UIColor.black
            FridayWeek2Text.textColor = UIColor.black
            WholeWeek2Text.textColor = UIColor.black
            self.setNeedsStatusBarAppearanceUpdate()
            MondayWeek2Text.backgroundColor = UIColor.white
            TuesdayWeek2Text.backgroundColor = UIColor.white
            WednesdayWeek2Text.backgroundColor = UIColor.white
            ThursdayWeek2Text.backgroundColor = UIColor.white
            FridayWeek2Text.backgroundColor = UIColor.white
            WholeWeek2Text.backgroundColor = UIColor.white
        }
        // Do any additional setup after loading the view.
      /*  NetworkManager.isUnreachable { (_) in
            var Week2MondayUD = UserDefaults.standard.string(forKey: "UDW2MO")
            var Week2TuesdayUD = UserDefaults.standard.string(forKey: "UDW2TU")
            var Week2WednesdayUD = UserDefaults.standard.string(forKey: "UDW2WE")
            var Week2ThursdayUD = UserDefaults.standard.string(forKey: "UDW2TH")
            var Week2FridayUD = UserDefaults.standard.string(forKey: "UDW2FR")
            var Week2Date = UserDefaults.standard.string(forKey: "UDW2DA")
            if Week2MondayUD == nil {
                self.MondayWeek2Text.text = "Keine Daten vorhanden"
            }
            else {
                self.MondayWeek2Text.text = "S:" + Week2MondayUD!
            }
            if Week2TuesdayUD == nil {
                self.TuesdayWeek2Text.text = "Keine Daten vorhanden"
            }
            else {
                self.TuesdayWeek2Text.text = "S: " + Week2TuesdayUD!
            }
            if Week2WednesdayUD == nil {
                self.WednesdayWeek2Text.text = "Keine Daten vorhanden"
            }
            else {
                self.WednesdayWeek2Text.text = "S: " + Week2WednesdayUD!
            }
            if Week2ThursdayUD == nil {
                self.ThursdayWeek2Text.text = "Keine Daten vorhanden"
            }
            else {
                self.ThursdayWeek2Text.text = "S: " + Week2ThursdayUD!
            }
            if Week2FridayUD == nil {
                self.FridayWeek2Text.text = "Keine Daten vorhanden"
            }
            else {
                self.FridayWeek2Text.text = "S: " + Week2FridayUD!
            }
            if Week2Date == nil {
                self.HomeworkLabelW2.text = "Keine Daten vorhanden"
            }
            else {
                self.HomeworkLabelW2.text = "S: " + Week2Date!
            }
        }*/
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        var ref: DatabaseReference!
        
        ref = Database.database().reference()
        
        ref.child("homework").child("Week2").child("Monday").observeSingleEvent(of: .value) { (MondayWeek2Snap) in
            let MondayWeek2Home = MondayWeek2Snap.value as? String
            Week2Var.Week2Monday = MondayWeek2Home!
        
        ref.child("homework").child("Week2").child("Tuesday").observeSingleEvent(of: .value) { (TuesdayWeek2Snap) in
            let TuesdayWeek2Home = TuesdayWeek2Snap.value as? String
            Week2Var.Week2Tuesday = TuesdayWeek2Home!
        
        ref.child("homework").child("Week2").child("Wednesday").observeSingleEvent(of: .value) { (WednesdayWeek2Snap) in
            let WednesdayWeek2Home = WednesdayWeek2Snap.value as? String
            Week2Var.Week2Wednesday = WednesdayWeek2Home!
        
        ref.child("homework").child("Week2").child("Thursday").observeSingleEvent(of: .value) { (ThursdayWeek2Snap) in
            let ThursdayWeek2Home = ThursdayWeek2Snap.value as? String
            Week2Var.Week2Thursday = ThursdayWeek2Home!
            
        
        ref.child("homework").child("Week2").child("Friday").observeSingleEvent(of: .value) { (FridayWeek2Snap) in
            let FridayWeek2Home = FridayWeek2Snap.value as? String
            Week2Var.Week2Friday = FridayWeek2Home!
             self.WholeWeek2Text.text = "\(Week2Var.Week2Monday)\n\n\(Week2Var.Week2Tuesday)\n\n\(Week2Var.Week2Wednesday)\n\n\(Week2Var.Week2Thursday)\n\n\(Week2Var.Week2Friday)"
            self.loader.stopAnimating()
        }
    }
}
}
}
        ref.child("homework").child("Week2").child("Datum").observeSingleEvent(of: .value) { (DateWeek2Snap) in
            let DateWeek2LE = DateWeek2Snap.value as? String
            self.HomeworkLabelW2.text = DateWeek2LE
        }
        
       
        
        /*ref.child("homework").child("Week2").child("Monday").observeSingleEvent(of: .value) { (MondayWeek2Snap) in
            let MondayWeek2Home = MondayWeek2Snap.value as? String
            UserDefaults.standard.set(MondayWeek2Home, forKey: "UDW2MO")
            self.MondayWeek2Text.text = MondayWeek2Home
        }
        ref.child("homework").child("Week2").child("Tuesday").observeSingleEvent(of: .value) { (TuesdayWeek2Snap) in
            let TuesdayWeek2Home = TuesdayWeek2Snap.value as? String
            UserDefaults.standard.set(TuesdayWeek2Home, forKey: "UDW2TU")
            self.TuesdayWeek2Text.text = TuesdayWeek2Home
        }
        ref.child("homework").child("Week2").child("Wednesday").observeSingleEvent(of: .value) { (WednesdayWeek2Snap) in
            let WednesdayWeek2Home = WednesdayWeek2Snap.value as? String
            UserDefaults.standard.set(WednesdayWeek2Home, forKey: "UDW2WE")
            self.WednesdayWeek2Text.text = WednesdayWeek2Home
        }
        ref.child("homework").child("Week2").child("Thursday").observeSingleEvent(of: .value) { (ThursdayWeek2Snap) in
            let ThursdayWeek2Home = ThursdayWeek2Snap.value as? String
            UserDefaults.standard.set(ThursdayWeek2Home, forKey: "UDW2TH")
            self.ThursdayWeek2Text.text = ThursdayWeek2Home
        }
        ref.child("homework").child("Week2").child("Friday").observeSingleEvent(of: .value) { (FridayWeek2Snap) in
            let FridayWeek2Home = FridayWeek2Snap.value as? String
            UserDefaults.standard.set(FridayWeek2Home, forKey: "UDW2FR")
            self.FridayWeek2Text.text = FridayWeek2Home
        }
        ref.child("homework").child("Week2").child("Datum").observeSingleEvent(of: .value) { (DateWeek2Snap) in
            let DateWeek2LE = DateWeek2Snap.value as? String
            UserDefaults.standard.set(DateWeek2LE, forKey: "UDW2DA")
            self.HomeworkLabelW2.text = DateWeek2LE
        }*/
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        var style: UIStatusBarStyle!
        if UserDefaults.standard.integer(forKey: "DarkmodeStatus") == 1 {
            style = .lightContent
        }
        else if UserDefaults.standard.integer(forKey: "DarkmodeStatus") == 0 {
            style = .default
        }
        return style
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    
     */
    struct Week2Var {
        static var Week2Monday = ""
        static var Week2Tuesday = ""
        static var Week2Wednesday = ""
        static var Week2Thursday = ""
        static var Week2Friday = ""
    }
}
