//
//  AllTestsViewController.swift
//  KlassenAppD
//
//  Created by Adrian Baumgart on 25.05.19.
//  Copyright © 2019 Adrian Baumgart. All rights reserved.
//

import Firebase
import SPFakeBar
import UIKit

class AllTestsViewController: UIViewController {
    let navigationbar = SPFakeBarView(style: .stork)
    private var teststextview: UITextView!
    
    var style = Appearances()
    
    override func viewDidLoad() {
        navigationbar.titleLabel.text = "Download..."
        navigationbar.titleLabel.font = navigationbar.titleLabel.font.withSize(23)
        navigationbar.height = 95
        navigationbar.titleLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
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
        
        teststextview = UITextView(frame: CGRect(x: 8, y: 100, width: view.frame.width - 16, height: view.frame.height - 150))
        teststextview.isEditable = false
        teststextview.text = "Download..."
        teststextview.font = .systemFont(ofSize: 16)
        
        view.addSubview(teststextview)
       /* if UserDefaults.standard.integer(forKey: "DarkmodeStatus") == 1 {
            view.backgroundColor = style.darkBackground
            navigationbar.backgroundColor = style.darkTitleBackground
            navigationbar.titleLabel.textColor = style.darkText
            teststextview.textColor = style.darkText
            teststextview.backgroundColor = style.darkBackground
            setNeedsStatusBarAppearanceUpdate()
        }
        if UserDefaults.standard.integer(forKey: "DarkmodeStatus") == 0 {
            view.backgroundColor = style.lightBackground
            navigationbar.backgroundColor = style.lightTitleBackground
            navigationbar.titleLabel.textColor = style.lightText
            teststextview.textColor = style.lightText
            teststextview.backgroundColor = style.lightBackground
            setNeedsStatusBarAppearanceUpdate()
        }*/
        changeAppearance()
        reloadData()
    }
    
    func changeAppearance() {
        if UserDefaults.standard.integer(forKey: "ManualAppearance") == 0 {
            if #available(iOS 13.0, *) {
                if traitCollection.userInterfaceStyle == .dark {
                 view.backgroundColor = style.darkBackground
                 navigationbar.backgroundColor = style.darkTitleBackground
                 navigationbar.titleLabel.textColor = style.darkText
                 teststextview.textColor = style.darkText
                 teststextview.backgroundColor = style.darkBackground
                 setNeedsStatusBarAppearanceUpdate()
                }
                else if traitCollection.userInterfaceStyle == .light || traitCollection.userInterfaceStyle == .unspecified {
                    view.backgroundColor = style.lightBackground
                    navigationbar.backgroundColor = style.lightTitleBackground
                    navigationbar.titleLabel.textColor = style.lightText
                    teststextview.textColor = style.lightText
                    teststextview.backgroundColor = style.lightBackground
                    setNeedsStatusBarAppearanceUpdate()
                }
            }
        }
        else {
            if UserDefaults.standard.integer(forKey: "DarkmodeStatus") == 1 {
                view.backgroundColor = style.darkBackground
                navigationbar.backgroundColor = style.darkTitleBackground
                navigationbar.titleLabel.textColor = style.darkText
                teststextview.textColor = style.darkText
                teststextview.backgroundColor = style.darkBackground
                setNeedsStatusBarAppearanceUpdate()
            }
            else if UserDefaults.standard.integer(forKey: "DarkmodeStatus") == 0 {
                view.backgroundColor = style.lightBackground
                navigationbar.backgroundColor = style.lightTitleBackground
                navigationbar.titleLabel.textColor = style.lightText
                teststextview.textColor = style.lightText
                teststextview.backgroundColor = style.lightBackground
                setNeedsStatusBarAppearanceUpdate()
            }
        }
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        
        if #available(iOS 12.0, *) {
            
            if UserDefaults.standard.integer(forKey: "ManualAppearance") == 0 {
                    self.changeAppearance()
                self.setNeedsStatusBarAppearanceUpdate()
            }
            
        } else {
            // Fallback on earlier versions
        }
        
        
    }
    
    @objc func reloadData() {
        var ref: DatabaseReference!
        ref = Database.database().reference()
        
        ref.child("arbeiten").child(TestVC.selectedTest).child("label").observe(.value) { datesnap in
            let DateLE = datesnap.value as? String
            self.navigationbar.titleLabel.text = DateLE
        }
        
        ref.child("arbeiten").child(TestVC.selectedTest).child("beschreibung").observe(.value) { TestsSnap in
            let TestsLE = TestsSnap.value as? String
            self.teststextview.text = TestsLE
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    struct TestVC {
        static var selectedTest = ""
    }
}
