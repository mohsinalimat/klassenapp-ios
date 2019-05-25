//
//  FoodAllViewController.swift
//  KlassenAppD
//
//  Created by Adrian Baumgart on 25.05.19.
//  Copyright © 2019 Adrian Baumgart. All rights reserved.
//

import UIKit
import Firebase
import SPFakeBar

class FoodAllViewController: UIViewController {

    let navigationbar = SPFakeBarView(style: .stork)
    
    override func viewDidLoad() {
        navigationbar.titleLabel.text = "Download..."
        navigationbar.titleLabel.font = navigationbar.titleLabel.font.withSize(23)
        navigationbar.height = 100
        navigationbar.titleLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
        navigationbar.titleLabel.numberOfLines = 3
        self.view.addSubview(navigationbar)
        for subview in navigationbar.subviews {
            if subview is UIVisualEffectView {
                subview.removeFromSuperview()
            }
        }
        var foodtextview = UITextView(frame: CGRect(x: 8, y: 105, width: self.view.frame.width - 16, height: self.view.frame.height - 100))
        foodtextview.isEditable = false
        foodtextview.text = "Download..."
        foodtextview.font = .systemFont(ofSize: 16)
        
        self.view.addSubview(foodtextview)
        if UserDefaults.standard.integer(forKey: "DarkmodeStatus") == 1 {
            view.backgroundColor = UIColor(red:0.05, green:0.05, blue:0.05, alpha:1.0)
            navigationbar.backgroundColor = UIColor(red:0.13, green:0.13, blue:0.13, alpha:1.0)
            navigationbar.titleLabel.textColor = .white
            foodtextview.textColor = .white
            foodtextview.backgroundColor = UIColor(red:0.05, green:0.05, blue:0.05, alpha:1.0)
            self.setNeedsStatusBarAppearanceUpdate()
        }
        if UserDefaults.standard.integer(forKey: "DarkmodeStatus") == 0 {
            view.backgroundColor = UIColor.white
            navigationbar.backgroundColor = UIColor(red:0.95, green:0.95, blue:0.95, alpha:1.0)
            navigationbar.titleLabel.textColor = .black
            foodtextview.textColor = .black
            foodtextview.backgroundColor = .white
            self.setNeedsStatusBarAppearanceUpdate()
        }
        
        var ref: DatabaseReference!
        ref = Database.database().reference()
        
        ref.child("Speiseplan").child("Datum").observeSingleEvent(of: .value) { (datesnap) in
            let FoodDate = datesnap.value as! String
            self.navigationbar.titleLabel.text = "Speiseplan\n(\(FoodDate))"
        }
        
        ref.child("Speiseplan").child("monday").observeSingleEvent(of: .value) { (mondayfood) in
            FoodVC.monday = mondayfood.value as! String
            ref.child("Speiseplan").child("Tuesday").observeSingleEvent(of: .value, with: { (tuesdayfood) in
                FoodVC.tuesday = tuesdayfood.value as! String
                ref.child("Speiseplan").child("Wednesday").observeSingleEvent(of: .value, with: { (wednesdayfood) in
                    FoodVC.wednesday = wednesdayfood.value as! String
                    ref.child("Speiseplan").child("Thursday").observeSingleEvent(of: .value, with: { (thursdayfood) in
                        FoodVC.thursday = thursdayfood.value as! String
                        ref.child("Speiseplan").child("Friday").observeSingleEvent(of: .value, with: { (fridayfood) in
                            FoodVC.friday = fridayfood.value as! String
                            foodtextview.text = "Montag: \(FoodVC.monday)\n\nDienstag: \(FoodVC.tuesday)\n\nMittwoch: \(FoodVC.wednesday)\n\nDonnerstag: \(FoodVC.thursday)\n\nFreitag: \(FoodVC.friday)"
                        })
                    })
                })
            })
        }
        
        
        
        // Do any additional setup after loading the view.
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
    
    struct FoodVC {
        static var monday = ""
        static var tuesday = ""
        static var wednesday = ""
        static var thursday = ""
        static var friday = ""
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
