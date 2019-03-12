//
//  FoodFrViewController.swift
//  KlassenAppD
//
//  Created by Adrian Baumgart on 14.07.18.
//  Copyright © 2018 Adrian Baumgart. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class FoodFrViewController: UIViewController {
    
    let network: NetworkManager = NetworkManager.sharedInstance
    @IBOutlet weak var FoodFrText: UITextView!
    @IBOutlet weak var FoodFrLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if UserDefaults.standard.integer(forKey: "DarkmodeStatus") == 1 {
            view.backgroundColor = UIColor(red:0.08, green:0.08, blue:0.08, alpha:1.0)
            FoodFrText.textColor = UIColor.white
            FoodFrLabel.textColor = UIColor.white
            FoodFrText.backgroundColor = UIColor(red:0.08, green:0.08, blue:0.08, alpha:1.0)
            UIApplication.shared.statusBarStyle = .lightContent
        }
        
        if UserDefaults.standard.integer(forKey: "DarkmodeStatus") == 0 {
            view.backgroundColor = UIColor.white
            FoodFrText.textColor = UIColor.black
            FoodFrLabel.textColor = UIColor.black
            FoodFrText.backgroundColor = UIColor.white
            UIApplication.shared.statusBarStyle = .default
        }
        // Do any additional setup after loading the view.
    /*    NetworkManager.isUnreachable { (_) in
            var UDFOOFR = UserDefaults.standard.string(forKey: "UDFOODFR")
            if UDFOOFR == nil {
                self.FoodFrText.text = "Keine Daten vorhanden"
            }
            else {
                self.FoodFrText.text = "S: " + UDFOOFR!
            }
        }*/
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return UIStatusBarStyle(rawValue: UserDefaults.standard.integer(forKey: "DarkmodeStatus"))!
    }
    override func viewDidAppear(_ animated: Bool) {
      
        var ref: DatabaseReference!
        
        ref = Database.database().reference()
        
        ref.child("Speiseplan").child("Friday").observeSingleEvent(of: .value) { (FoodFridaySnap) in
            let FoodFridayLE = FoodFridaySnap.value as? String
            UserDefaults.standard.set(FoodFridayLE, forKey: "UDFOODFR")
            self.FoodFrText.text = FoodFridayLE
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
