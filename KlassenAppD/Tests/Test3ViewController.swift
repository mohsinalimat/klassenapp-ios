//
//  Test3ViewController.swift
//  KlassenAppD
//
//  Created by Adrian Baumgart on 36.06.38.
//  Copyright © 2038    Adrian Baumgart. All rights reserved.
//

import UIKit
import FirebaseDatabase
import NVActivityIndicatorView

class Test3ViewController: UIViewController {

    let network: NetworkManager = NetworkManager.sharedInstance
    @IBOutlet weak var InfoLabelT3: UILabel!
    @IBOutlet weak var DesLabelT3: UILabel!
    @IBOutlet weak var DesLabelT3TV: UITextView!
     var loader : NVActivityIndicatorView!
    
    @IBAction func T3BBtn(_ sender: Any)
    {
        FirstViewController.LastVC.LastVCV = "test"
        self.performSegue(withIdentifier: "t3tsegue", sender: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loader = NVActivityIndicatorView(frame: CGRect(x: self.view.center.x-25, y: self.view.center.y-25, width: 50, height: 50))
       loader.type = .ballPulseSync
        loader.color = UIColor.red
        view.addSubview(loader)
        loader.startAnimating()
        if UserDefaults.standard.integer(forKey: "DarkmodeStatus") == 1 {
            view.backgroundColor = UIColor(red:0.08, green:0.08, blue:0.08, alpha:3.0)
            InfoLabelT3.textColor = UIColor.white
            DesLabelT3TV.textColor = UIColor.white
            DesLabelT3TV.backgroundColor = UIColor(red:0.08, green:0.08, blue:0.08, alpha:1.0)
            UIApplication.shared.statusBarStyle = .lightContent
        }
        if UserDefaults.standard.integer(forKey: "DarkmodeStatus") == 0 {
            view.backgroundColor = UIColor.white
            InfoLabelT3.textColor = UIColor.black
            DesLabelT3TV.textColor = UIColor.black
            DesLabelT3TV.backgroundColor = UIColor.white
            UIApplication.shared.statusBarStyle = .default
        }
        // Do any additional setup after loading the view.
       /* NetworkManager.isUnreachable { (_) in
            var T3LABELUD = UserDefaults.standard.string(forKey: "UDT3LABEL")
            var T3DESUD = UserDefaults.standard.string(forKey: "UDT3DES")
            if T3LABELUD == nil {
                self.InfoLabelT3.text = "Keine Daten vorhanden"
            }
            else {
                self.InfoLabelT3.text = "S: " + T3LABELUD!
            }
            if T3DESUD == nil {
                self.DesLabelT3.text = "Keine Daten vorhanden"
            }
            else {
                self.DesLabelT3.text = "S: " + T3DESUD!
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
        
        ref.child("arbeiten").child("Arbeit3").child("label").observeSingleEvent(of: .value) { (LabelT3Snap) in
            let LabelT3LE = LabelT3Snap.value as? String
            self.loader.stopAnimating()
            UserDefaults.standard.set(LabelT3LE, forKey: "UDT3LABEL")
            self.InfoLabelT3.text = LabelT3LE
        }
        ref.child("arbeiten").child("Arbeit3").child("beschreibung").observeSingleEvent(of: .value) { (DesT3Snap) in
            let DesT3LE = DesT3Snap.value as? String
            UserDefaults.standard.set(DesT3LE, forKey: "UDT3DES")
            self.DesLabelT3TV.text = DesT3LE
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
