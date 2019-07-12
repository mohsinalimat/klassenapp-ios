//
//  SettingsViewController.swift
//  KlassenAppD
//
//  Created by Adrian Baumgart on 10.04.18.
//  Copyright © 2018 Adrian Baumgart. All rights reserved.
//

import AVKit
import Crashlytics
import Fabric
import Firebase
import LocalAuthentication
import SPStorkController
import UIKit

class SettingsViewController: UIViewController {
    @IBOutlet var TItleBar: UIView!
    @IBOutlet var ChangeColorsBtn: UIButton!
    @IBOutlet var AppInfoBtn: UIButton!
    @IBOutlet var ChangeAppIconBtn: UIButton!
    @IBOutlet var DarkmodeSwitchOut: UISwitch!
    @IBOutlet var InformationForRequests: UIButton!
    @IBOutlet var SettingsLabel: UILabel!
    @IBOutlet var DarkmodeLabel: UILabel!
    
    @IBOutlet var backgroundTitleView: UIView!
    
    @IBAction func InformationForRequestsAction(_ sender: Any) {
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(URL(string: "https://github.com/AdriBoy21/klassenapp-ios/wiki/Hausaufgabenanfragen-(de)")!)
        } else {
            UIApplication.shared.openURL(URL(string: "https://github.com/AdriBoy21/klassenapp-ios/wiki/Hausaufgabenanfragen-(de)")!)
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        var style: UIStatusBarStyle!
        if UserDefaults.standard.integer(forKey: "DarkmodeStatus") == 1 {
            style = .lightContent
        } else if UserDefaults.standard.integer(forKey: "DarkmodeStatus") == 0 {
            style = .default
        }
        return style
    }
    
    @IBAction func DarkmodeSwitch(_ sender: UISwitch) {
        if sender.isOn == true {
            view.backgroundColor = UIColor(red: 0.05, green: 0.05, blue: 0.05, alpha: 1.0)
            backgroundTitleView.backgroundColor = UIColor(red: 0.13, green: 0.13, blue: 0.13, alpha: 1.0)
            SettingsLabel.textColor = UIColor.white
            DarkmodeLabel.textColor = UIColor.white
            UserDefaults.standard.set(1, forKey: "DarkmodeStatus")
            setNeedsStatusBarAppearanceUpdate()
            tabBarController!.tabBar.barTintColor = .black
            tabBarController!.tabBar.tintColor = UIColor(red: 1.00, green: 0.58, blue: 0.00, alpha: 1.0)
        }
        if sender.isOn != true {
            view.backgroundColor = UIColor.white
            backgroundTitleView.backgroundColor = UIColor(red: 0.95, green: 0.95, blue: 0.95, alpha: 1.0)
            SettingsLabel.textColor = UIColor.black
            DarkmodeLabel.textColor = UIColor.black
            UserDefaults.standard.set(0, forKey: "DarkmodeStatus")
            setNeedsStatusBarAppearanceUpdate()
            tabBarController!.tabBar.barTintColor = .white
            tabBarController!.tabBar.tintColor = UIColor(red: 0.00, green: 0.48, blue: 1.00, alpha: 1.0)
        }
    }
    
    @IBAction func SiriShortcutReadHomework(_ sender: UISwitch) {
        if sender.isOn == true {
            UserDefaults.standard.set("YES", forKey: "ReadSiriShortcutHomework")
        }
        if sender.isOn != true {
            UserDefaults.standard.set("NO", forKey: "ReadSiriShortcutHomework")
        }
    }
    
    @IBAction func AppInformationsAction(_ sender: Any) {
        let impactFeedbackgenerator = UIImpactFeedbackGenerator(style: .light)
        impactFeedbackgenerator.prepare()
        impactFeedbackgenerator.impactOccurred()
        let controller1 = AppInfosViewController()
        let transitionDelegate = SPStorkTransitioningDelegate()
        controller1.transitioningDelegate = transitionDelegate
        controller1.modalPresentationStyle = .custom
        controller1.modalPresentationCapturesStatusBarAppearance = true
        present(controller1, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if UserDefaults.standard.string(forKey: "ButtonColor") != nil, UserDefaults.standard.string(forKey: "ButtonColor") != "" {
            ChangeColorsBtn.backgroundColor = UIColor(red: CGFloat(UserDefaults.standard.integer(forKey: "ButtonRed")) / 255, green: CGFloat(UserDefaults.standard.integer(forKey: "ButtonGreen")) / 255, blue: CGFloat(UserDefaults.standard.integer(forKey: "ButtonBlue")) / 255, alpha: 1)
            
            ChangeAppIconBtn.backgroundColor = UIColor(red: CGFloat(UserDefaults.standard.integer(forKey: "ButtonRed")) / 255, green: CGFloat(UserDefaults.standard.integer(forKey: "ButtonGreen")) / 255, blue: CGFloat(UserDefaults.standard.integer(forKey: "ButtonBlue")) / 255, alpha: 1)
            
            AppInfoBtn.backgroundColor = UIColor(red: CGFloat(UserDefaults.standard.integer(forKey: "ButtonRed")) / 255, green: CGFloat(UserDefaults.standard.integer(forKey: "ButtonGreen")) / 255, blue: CGFloat(UserDefaults.standard.integer(forKey: "ButtonBlue")) / 255, alpha: 1)
            
            InformationForRequests.backgroundColor = UIColor(red: CGFloat(UserDefaults.standard.integer(forKey: "ButtonRed")) / 255, green: CGFloat(UserDefaults.standard.integer(forKey: "ButtonGreen")) / 255, blue: CGFloat(UserDefaults.standard.integer(forKey: "ButtonBlue")) / 255, alpha: 1)
        }
        if UserDefaults.standard.string(forKey: "TitleBarColor") != nil, UserDefaults.standard.string(forKey: "TitleBarColor") != "" {
            TItleBar.backgroundColor = UIColor(red: CGFloat(UserDefaults.standard.integer(forKey: "TitleBarRed")) / 255, green: CGFloat(UserDefaults.standard.integer(forKey: "TitleBarGreen")) / 255, blue: CGFloat(UserDefaults.standard.integer(forKey: "TitleBarBlue")) / 255, alpha: 1)
        }
        
        if UserDefaults.standard.integer(forKey: "DarkmodeStatus") == 1 {
            view.backgroundColor = UIColor(red: 0.05, green: 0.05, blue: 0.05, alpha: 1.0)
            backgroundTitleView.backgroundColor = UIColor(red: 0.13, green: 0.13, blue: 0.13, alpha: 1.0)
            SettingsLabel.textColor = UIColor.white
            DarkmodeLabel.textColor = UIColor.white
            setNeedsStatusBarAppearanceUpdate()
            
            DarkmodeSwitchOut.setOn(true, animated: false)
        }
        if UserDefaults.standard.integer(forKey: "DarkmodeStatus") == 0 {
            view.backgroundColor = UIColor.white
            backgroundTitleView.backgroundColor = UIColor(red: 0.95, green: 0.95, blue: 0.95, alpha: 1.0)
            SettingsLabel.textColor = UIColor.black
            DarkmodeLabel.textColor = UIColor.black
            setNeedsStatusBarAppearanceUpdate()
            
            DarkmodeSwitchOut.setOn(false, animated: false)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

// Helper function inserted by Swift 4.2 migrator.
private func convertToUIApplicationOpenExternalURLOptionsKeyDictionary(_ input: [String: Any]) -> [UIApplication.OpenExternalURLOptionsKey: Any] {
    return Dictionary(uniqueKeysWithValues: input.map { key, value in (UIApplication.OpenExternalURLOptionsKey(rawValue: key), value) })
}
