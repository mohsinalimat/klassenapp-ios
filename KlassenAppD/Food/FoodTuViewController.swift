//
//  FoodTuViewController.swift
//  KlassenAppD
//
//  Created by Adrian Baumgart on 14.07.18.
//  Copyright © 2018 Adrian Baumgart. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import NVActivityIndicatorView

class FoodTuViewController: UIViewController {
    
    @IBOutlet weak var FoodTuText: UITextView!
    @IBOutlet weak var FoodTuLabel: UILabel!
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
            FoodTuText.textColor = UIColor.white
            FoodTuLabel.textColor = UIColor.white
            FoodTuText.backgroundColor = UIColor(red:0.08, green:0.08, blue:0.08, alpha:1.0)
            self.setNeedsStatusBarAppearanceUpdate()
            
        }
        
        if UserDefaults.standard.integer(forKey: "DarkmodeStatus") == 0 {
            view.backgroundColor = UIColor.white
            FoodTuText.textColor = UIColor.black
            FoodTuLabel.textColor = UIColor.black
            FoodTuText.backgroundColor = UIColor.white
            self.setNeedsStatusBarAppearanceUpdate()
        }
        
        // Do any additional setup after loading the view.
       /* NetworkManager.isUnreachable { (_) in
            var UDFOOTU = UserDefaults.standard.string(forKey: "UDFOODTU")
            if UDFOOTU == nil {
                self.FoodTuText.text = "Keine Daten vorhanden"
            }
            else {
                self.FoodTuText.text = "S: " + UDFOOTU!
            }
        }*/
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        var ref: DatabaseReference!
        
        ref = Database.database().reference()
        
        ref.child("Speiseplan").child("Tuesday").observeSingleEvent(of: .value) { (FoodTuesdaySnap) in
            let FoodTuesdayLE = FoodTuesdaySnap.value as? String
            UserDefaults.standard.set(FoodTuesdayLE, forKey: "UDFOODTU")
            self.FoodTuText.text = FoodTuesdayLE
            self.loader.stopAnimating()
        }
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
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
