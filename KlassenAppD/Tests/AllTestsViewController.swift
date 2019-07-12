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
        if UserDefaults.standard.integer(forKey: "DarkmodeStatus") == 1 {
            view.backgroundColor = UIColor(red: 0.05, green: 0.05, blue: 0.05, alpha: 1.0)
            navigationbar.backgroundColor = UIColor(red: 0.13, green: 0.13, blue: 0.13, alpha: 1.0)
            navigationbar.titleLabel.textColor = .white
            teststextview.textColor = .white
            teststextview.backgroundColor = UIColor(red: 0.05, green: 0.05, blue: 0.05, alpha: 1.0)
            setNeedsStatusBarAppearanceUpdate()
        }
        if UserDefaults.standard.integer(forKey: "DarkmodeStatus") == 0 {
            view.backgroundColor = UIColor.white
            navigationbar.backgroundColor = UIColor(red: 0.95, green: 0.95, blue: 0.95, alpha: 1.0)
            navigationbar.titleLabel.textColor = .black
            teststextview.textColor = .black
            teststextview.backgroundColor = .white
            setNeedsStatusBarAppearanceUpdate()
        }
        reloadData()
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
