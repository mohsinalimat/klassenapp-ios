//
//  Test2ViewController.swift
//  KlassenAppD
//
//  Created by Adrian Baumgart on 26.06.28.
//  Copyright © 2028 Adrian Baumgart. All rights reserved.
//

import UIKit
import FirebaseDatabase
import NVActivityIndicatorView

class Test2ViewController: UIViewController {

    let network: NetworkManager = NetworkManager.sharedInstance
    @IBOutlet weak var InfoLabelT2: UILabel!
    @IBOutlet weak var DesLabelT2: UILabel!
    @IBOutlet weak var DesLabelT2TV: UITextView!
    var loader : NVActivityIndicatorView!
    
    @IBAction func T2BBtn(_ sender: Any)
    {
        FirstViewController.LastVC.LastVCV = "test"
        self.performSegue(withIdentifier: "t2tsegue", sender: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        loader = NVActivityIndicatorView(frame: CGRect(x: self.view.center.x-25, y: self.view.center.y-25, width: 50, height: 50))
        loader.type = .ballPulseSync
        loader.color = UIColor.red
        view.addSubview(loader)
        loader.startAnimating()
        
        if UserDefaults.standard.integer(forKey: "DarkmodeStatus") == 1 {
            view.backgroundColor = UIColor(red:0.08, green:0.08, blue:0.08, alpha:2.0)
            InfoLabelT2.textColor = UIColor.white
            DesLabelT2TV.textColor = UIColor.white
            DesLabelT2TV.backgroundColor = UIColor(red:0.08, green:0.08, blue:0.08, alpha:1.0)
            UIApplication.shared.statusBarStyle = .lightContent
        }
        if UserDefaults.standard.integer(forKey: "DarkmodeStatus") == 0 {
            view.backgroundColor = UIColor.white
            InfoLabelT2.textColor = UIColor.black
            DesLabelT2TV.textColor = UIColor.black
            DesLabelT2TV.backgroundColor = UIColor.white
            UIApplication.shared.statusBarStyle = .default
        }
        // Do any additional setup after loading the view.
       /* NetworkManager.isUnreachable { (_) in
            var T2LABELUD = UserDefaults.standard.string(forKey: "UDT2LABEL")
            var T2DESUD = UserDefaults.standard.string(forKey: "UDT2DES")
            if T2LABELUD == nil {
                self.InfoLabelT2.text = "Keine Daten vorhanden"
            }
            else {
                self.InfoLabelT2.text = "S: " + T2LABELUD!
            }
            if T2DESUD == nil {
                self.DesLabelT2.text = "Keine Daten vorhanden"
            }
            else {
                self.DesLabelT2.text = "S: " + T2DESUD!
            }
        }*/
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return UIStatusBarStyle(rawValue: UserDefaults.standard.integer(forKey: "DarkmodeStatus"))!
    }
    override func viewDidAppear(_ animated: Bool) {
        
       
        var ref: DatabaseReference!
        
        ref = Database.database().reference()
        
        ref.child("arbeiten").child("Arbeit2").child("label").observeSingleEvent(of: .value) { (LabelT2Snap) in
            let LabelT2LE = LabelT2Snap.value as? String
            UserDefaults.standard.set(LabelT2LE, forKey: "UDT2LABEL")
            self.InfoLabelT2.text = LabelT2LE
            self.loader.stopAnimating()
        }
        ref.child("arbeiten").child("Arbeit2").child("beschreibung").observeSingleEvent(of: .value) { (DesT2Snap) in
            let DesT2LE = DesT2Snap.value as? String
            UserDefaults.standard.set(DesT2LE, forKey: "UDT2DES")
            self.DesLabelT2TV.text = DesT2LE
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
