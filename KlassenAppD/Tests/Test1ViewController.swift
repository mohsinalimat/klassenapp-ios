//
//  Test1ViewController.swift
//  KlassenAppD
//
//  Created by Adrian Baumgart on 16.06.18.
//  Copyright © 2018 Adrian Baumgart. All rights reserved.
//

import UIKit
import FirebaseDatabase
import NVActivityIndicatorView

class Test1ViewController: UIViewController {
    
    @IBOutlet weak var InfoLabelT1: UILabel!
    @IBOutlet weak var DesLabelT1: UILabel!
    @IBOutlet weak var DesLabelT1TV: UITextView!
    var loader : NVActivityIndicatorView!
    
    @IBAction func T1BBtn(_ sender: Any)
    {
        FirstViewController.LastVC.LastVCV = "test"
        //FirstViewController.LastVC.ShortDirect = "0"
        self.performSegue(withIdentifier: "t1tsegue", sender: nil)
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
            InfoLabelT1.textColor = UIColor.white
            //DesLabelT1.textColor = UIColor.white
            DesLabelT1TV.textColor = UIColor.white
            DesLabelT1TV.backgroundColor = UIColor(red:0.08, green:0.08, blue:0.08, alpha:1.0)
           self.setNeedsStatusBarAppearanceUpdate()
        }
        if UserDefaults.standard.integer(forKey: "DarkmodeStatus") == 0 {
            view.backgroundColor = UIColor.white
            InfoLabelT1.textColor = UIColor.black
            //DesLabelT1.textColor = UIColor.black
            DesLabelT1TV.textColor = UIColor.black
            DesLabelT1TV.backgroundColor = UIColor.white
            
            //GLT1V.DarkmodeVar = 0
            self.setNeedsStatusBarAppearanceUpdate()
        }

        // Do any additional setup after loading the view.
       /* NetworkManager.isUnreachable { (_) in
            let T1LABELUD = UserDefaults.standard.string(forKey: "UDT1LABEL")
            let T1DESUD = UserDefaults.standard.string(forKey: "UDT1DES")
            if T1LABELUD == nil {
                self.InfoLabelT1.text = "Keine Daten vorhanden"
            }
            else {
                self.InfoLabelT1.text = "S: " + T1LABELUD!
            }
            if T1DESUD == nil {
                self.DesLabelT1.text = "Keine Daten vorhanden"
            }
            else {
                self.DesLabelT1.text = "S: " + T1DESUD!
            }
        }*/
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func calledViaSiriShortcutTest1() {
        if #available(iOS 12.0, *) {
            let TestShortcutActivity = NSUserActivity(activityType: "com.adrianbaumgart.KlassenAppDREA1234.SiriShortcutNextTest")
            TestShortcutActivity.title = "Was findet als nächstes in der Schule statt?"
            TestShortcutActivity.isEligibleForSearch = true
            TestShortcutActivity.isEligibleForPrediction = true
            self.userActivity = TestShortcutActivity
            self.userActivity?.becomeCurrent()
        } else {
            // Fallback on earlier versions
        }
    }
    
    /*override func preferredStatusBarStyle() -> UIStatusBarStyle {
     
    }*/
    
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
    
    override func viewDidAppear(_ animated: Bool) {
       
        var ref: DatabaseReference!
        
        ref = Database.database().reference()
        
        ref.child("arbeiten").child("Arbeit1").child("label").observeSingleEvent(of: .value) { (LabelT1Snap) in
            let LabelT1LE = LabelT1Snap.value as? String
            UserDefaults.standard.set(LabelT1LE, forKey: "UDT1LABEL")
            self.InfoLabelT1.text = LabelT1LE
            self.loader.stopAnimating()
        }
        ref.child("arbeiten").child("Arbeit1").child("beschreibung").observeSingleEvent(of: .value) { (DesT1Snap) in
            let DesT1LE = DesT1Snap.value as? String
            UserDefaults.standard.set(DesT1LE, forKey: "UDT1DES")
            self.DesLabelT1TV.text = DesT1LE
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    
}
