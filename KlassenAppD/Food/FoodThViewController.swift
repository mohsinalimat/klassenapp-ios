//
//  FoodThViewController.swift
//  KlassenAppD
//
//  Created by Adrian Baumgart on 14.07.18.
//  Copyright © 2018 Adrian Baumgart. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class FoodThViewController: UIViewController {
    
    let network: NetworkManager = NetworkManager.sharedInstance
    @IBOutlet weak var FoodThText: UITextView!
    @IBOutlet weak var FoodThLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if UserDefaults.standard.integer(forKey: "DarkmodeStatus") == 1 {
            view.backgroundColor = UIColor(red:0.08, green:0.08, blue:0.08, alpha:1.0)
            FoodThText.textColor = UIColor.white
            FoodThLabel.textColor = UIColor.white
            FoodThText.backgroundColor = UIColor(red:0.08, green:0.08, blue:0.08, alpha:1.0)
            UIApplication.shared.statusBarStyle = .lightContent
        }
        
        if UserDefaults.standard.integer(forKey: "DarkmodeStatus") == 0 {
            view.backgroundColor = UIColor.white
            FoodThText.textColor = UIColor.black
            FoodThLabel.textColor = UIColor.black
            FoodThText.backgroundColor = UIColor.white
            UIApplication.shared.statusBarStyle = .default
        }
        // Do any additional setup after loading the view.
        /*NetworkManager.isUnreachable { (_) in
            var UDFOOTH = UserDefaults.standard.string(forKey: "UDFOODTH")
            if UDFOOTH == nil {
                self.FoodThText.text = "Keine Daten vorhanden"
            }
            else {
                self.FoodThText.text = "S: " + UDFOOTH!
            }
        }*/
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return UIStatusBarStyle(rawValue: UserDefaults.standard.integer(forKey: "DarkmodeStatus"))!
    }
    override func viewDidAppear(_ animated: Bool) {
       
        var ref: DatabaseReference!
        
        ref = Database.database().reference()
        
        ref.child("Speiseplan").child("Thursday").observeSingleEvent(of: .value) { (FoodThursdaySnap) in
            let FoodThursdayLE = FoodThursdaySnap.value as? String
            UserDefaults.standard.set(FoodThursdayLE, forKey: "UDFOODTH")
            self.FoodThText.text = FoodThursdayLE
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
