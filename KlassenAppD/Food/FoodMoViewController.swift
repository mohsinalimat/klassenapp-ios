//
//  FoodMoViewController.swift
//  KlassenAppD
//
//  Created by Adrian Baumgart on 14.07.18.
//  Copyright © 2018 Adrian Baumgart. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import NVActivityIndicatorView

class FoodMoViewController: UIViewController {
    
    let network: NetworkManager = NetworkManager.sharedInstance
    @IBOutlet weak var FoodMoText: UITextView!
    @IBOutlet weak var FoodMoLabel: UILabel!
    var loader : NVActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loader = NVActivityIndicatorView(frame: CGRect(x: self.view.center.x-25, y: self.view.center.y-25, width: 50, height: 50))
        //loader.type = .ballRotateChase
        loader.type = .ballPulseSync
        loader.color = UIColor.red
        view.addSubview(loader)
        loader.startAnimating()
        if UserDefaults.standard.integer(forKey: "DarkmodeStatus") == 1 {
            view.backgroundColor = UIColor(red:0.08, green:0.08, blue:0.08, alpha:1.0)
            FoodMoText.textColor = UIColor.white
            FoodMoLabel.textColor = UIColor.white
            FoodMoText.backgroundColor = UIColor(red:0.08, green:0.08, blue:0.08, alpha:1.0)
            UIApplication.shared.statusBarStyle = .lightContent
        }
        
        if  UserDefaults.standard.integer(forKey: "DarkmodeStatus") == 0 {
            view.backgroundColor = UIColor.white
            FoodMoText.textColor = UIColor.black
            FoodMoLabel.textColor = UIColor.black
            FoodMoText.backgroundColor = UIColor.white
            UIApplication.shared.statusBarStyle = .default        }
        // Do any additional setup after loading the view.
       /* NetworkManager.isUnreachable { (_) in
            var UDFOOMO = UserDefaults.standard.string(forKey: "UDFOODMO")
            if UDFOOMO == nil {
                self.FoodMoText.text = "Keine Daten vorhanden"
            }
            else {
                self.FoodMoText.text = "S: " + UDFOOMO!
            }
        }*/
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return UIStatusBarStyle(rawValue: UserDefaults.standard.integer(forKey: "DarkmodeStatus"))!
    }
    override func viewDidAppear(_ animated: Bool) {
      
        var ref: DatabaseReference!
        
        ref = Database.database().reference()
        
        ref.child("Speiseplan").child("monday").observeSingleEvent(of: .value) { (FoodMondaySnap) in
            let FoodMondayLE = FoodMondaySnap.value as? String
            UserDefaults.standard.set(FoodMondayLE, forKey: "UDFOODMO")
            self.FoodMoText.text = FoodMondayLE
            self.loader.stopAnimating()
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
