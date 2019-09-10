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
    
    var HomeworkValues: [String] = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday"]
    
    var style = Appearances()
    
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
        
        changeAppearance()
        
        reloadData()
        
        var ref: DatabaseReference!
        ref = Database.database().reference()
        
        ref.child("homework").observe(.childChanged) { _ in
            self.reloadData()
        }
    }
    
    func changeAppearance() {
        if UserDefaults.standard.integer(forKey: "AutoAppearance") == 1 {
            if #available(iOS 13.0, *) {
                if traitCollection.userInterfaceStyle == .dark {
                    view.backgroundColor = style.darkBackground
                    navigationbar.backgroundColor = style.darkTitleBackground
                    navigationbar.titleLabel.textColor = style.darkText
                    hwtextview.textColor = style.darkText
                    hwtextview.backgroundColor = style.darkBackground
                    setNeedsStatusBarAppearanceUpdate()
                }
                else if traitCollection.userInterfaceStyle == .light || traitCollection.userInterfaceStyle == .unspecified {
                    view.backgroundColor = style.lightBackground
                    navigationbar.backgroundColor = style.lightTitleBackground
                    navigationbar.titleLabel.textColor = style.lightText
                    hwtextview.textColor = style.lightText
                    hwtextview.backgroundColor = style.lightBackground
                    setNeedsStatusBarAppearanceUpdate()
                }
            }
        }
        else {
            if UserDefaults.standard.integer(forKey: "DarkmodeStatus") == 1 {
                view.backgroundColor = style.darkBackground
                navigationbar.backgroundColor = style.darkTitleBackground
                navigationbar.titleLabel.textColor = style.darkText
                hwtextview.textColor = style.darkText
                hwtextview.backgroundColor = style.darkBackground
                setNeedsStatusBarAppearanceUpdate()
            }
            else if UserDefaults.standard.integer(forKey: "DarkmodeStatus") == 0 {
                view.backgroundColor = style.lightBackground
                navigationbar.backgroundColor = style.lightTitleBackground
                navigationbar.titleLabel.textColor = style.lightText
                hwtextview.textColor = style.lightText
                hwtextview.backgroundColor = style.lightBackground
                setNeedsStatusBarAppearanceUpdate()
            }
        }
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        
        if #available(iOS 13.0, *) {
            if UserDefaults.standard.integer(forKey: "AutoAppearance") == 1 {
                UIView.animate(withDuration: 0.1) {
                    self.changeAppearance()
                }
                self.setNeedsStatusBarAppearanceUpdate()
            }
        }
    }
    
    @objc func reloadData() {
        hwtextview.text = ""
        var ref: DatabaseReference!
        ref = Database.database().reference()
        
        ref.child("homework").child(HWWeekVC.selectedWeek).child("Datum").observe(.value) { datesnap in
            let DateLE = datesnap.value as? String
            self.navigationbar.titleLabel.text = DateLE
        }
        
        for day in HomeworkValues {
            ref.child("homework").child(HWWeekVC.selectedWeek).child(day).observeSingleEvent(of: .value) { HwSnap in
                let SnapLE = HwSnap.value as? String
                if self.hwtextview.text == "" {
                    self.hwtextview.text = self.hwtextview.text + SnapLE!
                }
                else {
                    self.hwtextview.text = self.hwtextview.text + "\n\n" + SnapLE!
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
