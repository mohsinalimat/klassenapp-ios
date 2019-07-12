//
//  HomeworkWeekViewController.swift
//  KlassenAppD
//
//  Created by Adrian Baumgart on 25.05.19.
//  Copyright © 2019 Adrian Baumgart. All rights reserved.
//

import Firebase
import SPFakeBar
import UIKit

class HomeworkWeekViewController: UIViewController {
    let navigationbar = SPFakeBarView(style: .stork)
    private var hwtextview: UITextView!
    
    override func viewDidLoad() {
        navigationbar.titleLabel.text = "Download..."
        navigationbar.titleLabel.font = navigationbar.titleLabel.font.withSize(23)
        navigationbar.height = 90
        view.addSubview(navigationbar)
        for subview in navigationbar.subviews {
            if subview is UIVisualEffectView {
                subview.removeFromSuperview()
            }
        }
        
        let titlebar = UIView(frame: CGRect(x: 0, y: navigationbar.height - 1, width: view.frame.width, height: 3))
        titlebar.backgroundColor = UIColor(red: 0.61, green: 0.32, blue: 0.88, alpha: 1.0)
        
        if UserDefaults.standard.string(forKey: "TitleBarColor") != nil, UserDefaults.standard.string(forKey: "TitleBarColor") != "" {
            titlebar.backgroundColor = UIColor(red: CGFloat(UserDefaults.standard.integer(forKey: "TitleBarRed")) / 255, green: CGFloat(UserDefaults.standard.integer(forKey: "TitleBarGreen")) / 255, blue: CGFloat(UserDefaults.standard.integer(forKey: "TitleBarBlue")) / 255, alpha: 1)
        }
        view.addSubview(titlebar)
        
        hwtextview = UITextView(frame: CGRect(x: 8, y: 95, width: view.frame.width - 16, height: view.frame.height - 150))
        hwtextview.isEditable = false
        hwtextview.text = "Download..."
        hwtextview.font = .systemFont(ofSize: 16)
        
        view.addSubview(hwtextview)
        if UserDefaults.standard.integer(forKey: "DarkmodeStatus") == 1 {
            view.backgroundColor = UIColor(red: 0.05, green: 0.05, blue: 0.05, alpha: 1.0)
            navigationbar.backgroundColor = UIColor(red: 0.13, green: 0.13, blue: 0.13, alpha: 1.0)
            navigationbar.titleLabel.textColor = .white
            hwtextview.textColor = .white
            hwtextview.backgroundColor = UIColor(red: 0.05, green: 0.05, blue: 0.05, alpha: 1.0)
            setNeedsStatusBarAppearanceUpdate()
        }
        if UserDefaults.standard.integer(forKey: "DarkmodeStatus") == 0 {
            view.backgroundColor = UIColor.white
            navigationbar.backgroundColor = UIColor(red: 0.95, green: 0.95, blue: 0.95, alpha: 1.0)
            navigationbar.titleLabel.textColor = .black
            hwtextview.textColor = .black
            hwtextview.backgroundColor = .white
            setNeedsStatusBarAppearanceUpdate()
        }
        
        reloadData()
    }
    
    @objc func reloadData() {
        var ref: DatabaseReference!
        ref = Database.database().reference()
        
        ref.child("homework").child(HWWeekVC.selectedWeek).child("Datum").observe(.value) { datesnap in
            let DateLE = datesnap.value as? String
            self.navigationbar.titleLabel.text = DateLE
        }
        
        ref.child("homework").child(HWWeekVC.selectedWeek).child("Monday").observe(.value) { MondayWeek1Snap in
            let MondayWeek1Home = MondayWeek1Snap.value as? String
            HWWeekVC.monday = MondayWeek1Home!
            
            ref.child("homework").child(HWWeekVC.selectedWeek).child("Tuesday").observe(.value) { TuesdayWeek1Snap in
                let TuesdayWeek1Home = TuesdayWeek1Snap.value as? String
                HWWeekVC.tuesday = TuesdayWeek1Home!
                
                ref.child("homework").child(HWWeekVC.selectedWeek).child("Wednesday").observe(.value) { WednesdayWeek1Snap in
                    let WednesdayWeek1Home = WednesdayWeek1Snap.value as? String
                    HWWeekVC.wednesday = WednesdayWeek1Home!
                    
                    ref.child("homework").child(HWWeekVC.selectedWeek).child("Thursday").observe(.value) { ThursdayWeek1Snap in
                        let ThursdayWeek1Home = ThursdayWeek1Snap.value as? String
                        HWWeekVC.thursday = ThursdayWeek1Home!
                        
                        ref.child("homework").child(HWWeekVC.selectedWeek).child("Friday").observe(.value) { FridayWeek1Snap in
                            let FridayWeek1Home = FridayWeek1Snap.value as? String
                            HWWeekVC.friday = FridayWeek1Home!
                            self.hwtextview.text = "\(HWWeekVC.monday)\n\n\(HWWeekVC.tuesday)\n\n\(HWWeekVC.wednesday)\n\n\(HWWeekVC.thursday)\n\n\(HWWeekVC.friday)"
                        }
                    }
                }
            }
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    struct HWWeekVC {
        static var selectedWeek = ""
        static var monday = ""
        static var tuesday = ""
        static var wednesday = ""
        static var thursday = ""
        static var friday = ""
    }
}
