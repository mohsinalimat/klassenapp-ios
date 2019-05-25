//
//  HomeworkWeekViewController.swift
//  KlassenAppD
//
//  Created by Adrian Baumgart on 25.05.19.
//  Copyright © 2019 Adrian Baumgart. All rights reserved.
//

import UIKit
import SPFakeBar
import Firebase

class HomeworkWeekViewController: UIViewController {
    
    let navigationbar = SPFakeBarView(style: .stork)
    
    override func viewDidLoad() {
        navigationbar.titleLabel.text = "Download..."
        navigationbar.titleLabel.font = navigationbar.titleLabel.font.withSize(23)
        navigationbar.height = 90
        self.view.addSubview(navigationbar)
        for subview in navigationbar.subviews {
            if subview is UIVisualEffectView {
                subview.removeFromSuperview()
            }
        }
       var hwtextview = UITextView(frame: CGRect(x: 8, y: 95, width: self.view.frame.width - 16, height: self.view.frame.height - 100))
        hwtextview.isEditable = false
        hwtextview.text = "Download..."
        hwtextview.font = .systemFont(ofSize: 16)

        self.view.addSubview(hwtextview)
        if UserDefaults.standard.integer(forKey: "DarkmodeStatus") == 1 {
            view.backgroundColor = UIColor(red:0.05, green:0.05, blue:0.05, alpha:1.0)
            navigationbar.backgroundColor = UIColor(red:0.13, green:0.13, blue:0.13, alpha:1.0)
            navigationbar.titleLabel.textColor = .white
            hwtextview.textColor = .white
            hwtextview.backgroundColor = UIColor(red:0.05, green:0.05, blue:0.05, alpha:1.0)
            self.setNeedsStatusBarAppearanceUpdate()
        }
        if UserDefaults.standard.integer(forKey: "DarkmodeStatus") == 0 {
            view.backgroundColor = UIColor.white
            navigationbar.backgroundColor = UIColor(red:0.95, green:0.95, blue:0.95, alpha:1.0)
            navigationbar.titleLabel.textColor = .black
            hwtextview.textColor = .black
            hwtextview.backgroundColor = .white
            self.setNeedsStatusBarAppearanceUpdate()
        }
        
        var ref: DatabaseReference!
        ref = Database.database().reference()
        
        ref.child("homework").child(HWWeekVC.selectedWeek).child("Datum").observeSingleEvent(of: .value) { (datesnap) in
            let DateLE = datesnap.value as? String
            self.navigationbar.titleLabel.text = DateLE
        }
        
        ref.child("homework").child(HWWeekVC.selectedWeek).child("Monday").observeSingleEvent(of: .value) { (MondayWeek1Snap) in
            let MondayWeek1Home = MondayWeek1Snap.value as? String
            HWWeekVC.monday = MondayWeek1Home!
            
            ref.child("homework").child(HWWeekVC.selectedWeek).child("Tuesday").observeSingleEvent(of: .value) { (TuesdayWeek1Snap) in
                let TuesdayWeek1Home = TuesdayWeek1Snap.value as? String
                HWWeekVC.tuesday = TuesdayWeek1Home!
                
                ref.child("homework").child(HWWeekVC.selectedWeek).child("Wednesday").observeSingleEvent(of: .value) { (WednesdayWeek1Snap) in
                    let WednesdayWeek1Home = WednesdayWeek1Snap.value as? String
                    HWWeekVC.wednesday = WednesdayWeek1Home!
                    
                    ref.child("homework").child(HWWeekVC.selectedWeek).child("Thursday").observeSingleEvent(of: .value) { (ThursdayWeek1Snap) in
                        let ThursdayWeek1Home = ThursdayWeek1Snap.value as? String
                        HWWeekVC.thursday = ThursdayWeek1Home!
                        
                        ref.child("homework").child(HWWeekVC.selectedWeek).child("Friday").observeSingleEvent(of: .value) { (FridayWeek1Snap) in
                            let FridayWeek1Home = FridayWeek1Snap.value as? String
                            HWWeekVC.friday = FridayWeek1Home!
                            hwtextview.text = "\(HWWeekVC.monday)\n\n\(HWWeekVC.tuesday)\n\n\(HWWeekVC.wednesday)\n\n\(HWWeekVC.thursday)\n\n\(HWWeekVC.friday)"
                        }
                    }
                }
            }
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
    
    struct HWWeekVC {
        static var selectedWeek = ""
        static var monday = ""
        static var tuesday = ""
        static var wednesday = ""
        static var thursday = ""
        static var friday = ""
    }

}
