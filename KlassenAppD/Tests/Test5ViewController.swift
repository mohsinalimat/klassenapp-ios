//
//  Test5ViewController.swift
//  KlassenAppD
//
//  Created by Adrian Baumgart on 56.06.58.
//  Copyright © 2058 Adrian Baumgart. All rights reserved.
//

import UIKit
import FirebaseDatabase
import NVActivityIndicatorView

class Test5ViewController: UIViewController {

    let network: NetworkManager = NetworkManager.sharedInstance
    @IBOutlet weak var InfoLabelT5: UILabel!
    @IBOutlet weak var DesLabelT5: UILabel!
    @IBOutlet weak var DesLabelT5TV: UITextView!
    var loader : NVActivityIndicatorView!
    
    @IBAction func T5BBtn(_ sender: Any)
    {
        FirstViewController.LastVC.LastVCV = "test"
        self.performSegue(withIdentifier: "t5tsegue", sender: nil)
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return UIStatusBarStyle(rawValue: UserDefaults.standard.integer(forKey: "DarkmodeStatus"))!
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        loader = NVActivityIndicatorView(frame: CGRect(x: self.view.center.x-25, y: self.view.center.y-25, width: 50, height: 50))
        loader.type = .ballPulseSync
        loader.color = UIColor.red
        view.addSubview(loader)
        loader.startAnimating()
        if UserDefaults.standard.integer(forKey: "DarkmodeStatus") == 1 {
            view.backgroundColor = UIColor(red:0.08, green:0.08, blue:0.08, alpha:5.0)
            InfoLabelT5.textColor = UIColor.white
            DesLabelT5TV.textColor = UIColor.white
            DesLabelT5TV.backgroundColor = UIColor(red:0.08, green:0.08, blue:0.08, alpha:1.0)
            UIApplication.shared.statusBarStyle = .lightContent
        }
        if UserDefaults.standard.integer(forKey: "DarkmodeStatus") == 0 {
            view.backgroundColor = UIColor.white
            InfoLabelT5.textColor = UIColor.black
            DesLabelT5TV.textColor = UIColor.black
            DesLabelT5TV.backgroundColor = UIColor.white
            UIApplication.shared.statusBarStyle = .default
        }
        // Do any additional setup after loading the view.
        /*NetworkManager.isUnreachable { (_) in
            var T5LABELUD = UserDefaults.standard.string(forKey: "UDT5LABEL")
            var T5DESUD = UserDefaults.standard.string(forKey: "UDT5DES")
            if T5LABELUD == nil {
                self.InfoLabelT5.text = "Keine Daten vorhanden"
            }
            else {
                self.InfoLabelT5.text = "S: " + T5LABELUD!
            }
            if T5DESUD == nil {
                self.DesLabelT5.text = "Keine Daten vorhanden"
            }
            else {
                self.DesLabelT5.text = "S: " + T5DESUD!
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
        
        ref.child("arbeiten").child("Arbeit5").child("label").observeSingleEvent(of: .value) { (LabelT5Snap) in
            let LabelT5LE = LabelT5Snap.value as? String
            self.loader.stopAnimating()
            UserDefaults.standard.set(LabelT5LE, forKey: "UDT5LABEL")
            self.InfoLabelT5.text = LabelT5LE
        }
        ref.child("arbeiten").child("Arbeit5").child("beschreibung").observeSingleEvent(of: .value) { (DesT5Snap) in
            let DesT5LE = DesT5Snap.value as? String
            UserDefaults.standard.set(DesT5LE, forKey: "UDT5DES")
            self.DesLabelT5TV.text = DesT5LE
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
