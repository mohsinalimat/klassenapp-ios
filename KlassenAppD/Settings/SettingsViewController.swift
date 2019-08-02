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
    @IBOutlet weak var AppearanceControl: UISegmentedControl!
    @IBOutlet weak var AppearanceLabel: UILabel!
    @IBOutlet var backgroundTitleView: UIView!
    
    var style = Appearances()
    
    @IBAction func AppearanceAction(_ sender: Any) {
        
        switch AppearanceControl.selectedSegmentIndex {
            
        case 0: // Automatic
            
            UserDefaults.standard.set(0, forKey: "ManualAppearance")
            
            if #available(iOS 12.0, *) {
                let status = traitCollection.userInterfaceStyle
                
                if status == .dark {
                    UserDefaults.standard.set(1, forKey: "DarkmodeStatus")
                }
                else if status == .light {
                    UserDefaults.standard.set(0, forKey: "DarkmodeStatus")
                }
                
                UIView.animate(withDuration: 0.1) {
                    self.changeAppearance()
                }
                self.setNeedsStatusBarAppearanceUpdate()
                
            } else {
                // Fallback on earlier versions
            }
            
            
        case 1: //Light
            
            UserDefaults.standard.set(1, forKey: "ManualAppearance")
            UserDefaults.standard.set(0, forKey: "DarkmodeStatus")
            UIView.animate(withDuration: 0.1) {
                self.changeAppearance()
            }
            self.setNeedsStatusBarAppearanceUpdate()
            
        case 2: //Dark
            
            UserDefaults.standard.set(1, forKey: "ManualAppearance")
            UserDefaults.standard.set(1, forKey: "DarkmodeStatus")
            UIView.animate(withDuration: 0.1) {
                self.changeAppearance()
            }
            setNeedsStatusBarAppearanceUpdate()
            
        default:
            break
            
        }
    }
    
    func changeAppearance() {
        if UserDefaults.standard.integer(forKey: "ManualAppearance") == 0 {
            if #available(iOS 13.0, *) {
                if traitCollection.userInterfaceStyle == .dark {
                    self.view.backgroundColor = self.style.darkBackground
                    self.backgroundTitleView.backgroundColor = self.style.darkTitleBackground
                    self.SettingsLabel.textColor = self.style.darkText
                    self.DarkmodeLabel.textColor = self.style.darkText
                    self.AppearanceLabel.textColor = self.style.darkText
                    self.tabBarController!.tabBar.barTintColor = self.style.darkBarTintColor
                    self.tabBarController!.tabBar.tintColor = self.style.darkTintColor
                    setNeedsStatusBarAppearanceUpdate()
                }
                else if traitCollection.userInterfaceStyle == .light || traitCollection.userInterfaceStyle == .unspecified {
                    self.view.backgroundColor = self.style.lightBackground
                    self.backgroundTitleView.backgroundColor = self.style.lightTitleBackground
                    self.SettingsLabel.textColor = self.style.lightText
                    self.DarkmodeLabel.textColor = self.style.lightText
                    self.AppearanceLabel.textColor = self.style.lightText
                    self.tabBarController!.tabBar.barTintColor = self.style.lightBarTintColor
                    self.tabBarController!.tabBar.tintColor = self.style.lightTintColor
                    setNeedsStatusBarAppearanceUpdate()
                }
            }
        }
        else {
            if UserDefaults.standard.integer(forKey: "DarkmodeStatus") == 1 {
                self.view.backgroundColor = self.style.darkBackground
                self.backgroundTitleView.backgroundColor = self.style.darkTitleBackground
                self.SettingsLabel.textColor = self.style.darkText
                self.DarkmodeLabel.textColor = self.style.darkText
                self.AppearanceLabel.textColor = self.style.darkText
                self.tabBarController!.tabBar.barTintColor = self.style.darkBarTintColor
                self.tabBarController!.tabBar.tintColor = self.style.darkTintColor
                setNeedsStatusBarAppearanceUpdate()
            }
            else if UserDefaults.standard.integer(forKey: "DarkmodeStatus") == 0 {
                self.view.backgroundColor = self.style.lightBackground
                self.backgroundTitleView.backgroundColor = self.style.lightTitleBackground
                self.SettingsLabel.textColor = self.style.lightText
                self.DarkmodeLabel.textColor = self.style.lightText
                self.AppearanceLabel.textColor = self.style.lightText
                self.tabBarController!.tabBar.barTintColor = self.style.lightBarTintColor
                self.tabBarController!.tabBar.tintColor = self.style.lightTintColor
                setNeedsStatusBarAppearanceUpdate()
            }
        }
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        
        if #available(iOS 12.0, *) {
            
            if UserDefaults.standard.integer(forKey: "ManualAppearance") == 0 {
                UIView.animate(withDuration: 0.1) {
                    self.changeAppearance()
                }
                self.setNeedsStatusBarAppearanceUpdate()
            }
            
        } else {
            // Fallback on earlier versions
        }
        
        
    }
    
  override var preferredStatusBarStyle: UIStatusBarStyle {
        var style: UIStatusBarStyle!
    if UserDefaults.standard.integer(forKey: "ManualAppearance") == 0 {
        if #available(iOS 13.0, *) {
            if traitCollection.userInterfaceStyle == .dark {
            style = .lightContent
        }
        else if traitCollection.userInterfaceStyle == .light || traitCollection.userInterfaceStyle == .unspecified {
                style = .darkContent
        }
        }
    }
    else {
        if #available(iOS 13.0, *) {
            if UserDefaults.standard.integer(forKey: "DarkmodeStatus") == 1 {
                       style = .lightContent
                   }
                   else if UserDefaults.standard.integer(forKey: "DarkmodeStatus") == 0 {
                           style = .darkContent
                   }
        }
        else {
            if UserDefaults.standard.integer(forKey: "DarkmodeStatus") == 1 {
                style = .lightContent
            }
            else if UserDefaults.standard.integer(forKey: "DarkmodeStatus") == 0 {
                    style = .default
            }
        }
    }
        return style
    }
    
    @IBAction func InformationForRequestsAction(_ sender: Any) {
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(URL(string: "https://github.com/AdriBoy21/klassenapp-ios/wiki/Hausaufgabenanfragen-(de)")!)
        } else {
            UIApplication.shared.openURL(URL(string: "https://github.com/AdriBoy21/klassenapp-ios/wiki/Hausaufgabenanfragen-(de)")!)
        }
    }
    
   /* @IBAction func DarkmodeSwitch(_ sender: UISwitch) {
        if sender.isOn == true {
                self.view.backgroundColor = UIColor(red: 0.05, green: 0.05, blue: 0.05, alpha: 1.0)
                self.backgroundTitleView.backgroundColor = UIColor(red: 0.13, green: 0.13, blue: 0.13, alpha: 1.0)
                self.SettingsLabel.textColor = UIColor.white
                self.DarkmodeLabel.textColor = UIColor.white
                UserDefaults.standard.set(1, forKey: "DarkmodeStatus")
                self.setNeedsStatusBarAppearanceUpdate()
                self.tabBarController!.tabBar.barTintColor = .black
                self.tabBarController!.tabBar.tintColor = UIColor(red: 1.00, green: 0.58, blue: 0.00, alpha: 1.0)
        }
        if sender.isOn != true {
                self.view.backgroundColor = UIColor.white
                self.backgroundTitleView.backgroundColor = UIColor(red: 0.95, green: 0.95, blue: 0.95, alpha: 1.0)
                self.SettingsLabel.textColor = UIColor.black
                self.DarkmodeLabel.textColor = UIColor.black
                UserDefaults.standard.set(0, forKey: "DarkmodeStatus")
                self.setNeedsStatusBarAppearanceUpdate()
                self.tabBarController!.tabBar.barTintColor = .white
                self.tabBarController!.tabBar.tintColor = UIColor(red: 0.00, green: 0.48, blue: 1.00, alpha: 1.0)
        }
    }*/
    
    @IBAction func SiriShortcutReadHomework(_ sender: UISwitch) {
        if sender.isOn == true {
            UserDefaults.standard.set("YES", forKey: "ReadSiriShortcutHomework")
        }
        if sender.isOn != true {
            UserDefaults.standard.set("NO", forKey: "ReadSiriShortcutHomework")
        }
    }
    
    @IBAction func AppInformationsAction(_ sender: Any) {
        presentStork(controller: AppInfosViewController())
    }
    @IBAction func ChangeAppIcon(_ sender: Any) {
        if #available(iOS 10.3, *) {
            presentStork(controller: ChangeAppIconNewViewController())
        } else {
            // Fallback on earlier versions
        }
    }
    @IBAction func ChangeColor(_ sender: Any) {
        presentStork(controller: ChangeColorFullViewController())
    }
    
    func presentStork(controller: UIViewController) {
        let impactFeedbackgenerator = UIImpactFeedbackGenerator(style: .light)
        impactFeedbackgenerator.prepare()
        impactFeedbackgenerator.impactOccurred()
        let controller1 = controller
        let transitionDelegate = SPStorkTransitioningDelegate()
        controller1.transitioningDelegate = transitionDelegate
        controller1.modalPresentationStyle = .custom
        controller1.modalPresentationCapturesStatusBarAppearance = true
        present(controller1, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if #available(iOS 13.0, *) {
            AppearanceControl.setEnabled(true, forSegmentAt: 0)
        }
        else {
            AppearanceControl.setEnabled(false, forSegmentAt: 0)
            UserDefaults.standard.set(1, forKey: "ManualAppearance")
        }
        
        if UserDefaults.standard.integer(forKey: "ManualAppearance") == 1 {
            if UserDefaults.standard.integer(forKey: "DarkmodeStatus") == 1 {
                /*view.backgroundColor = style.darkBackground
                backgroundTitleView.backgroundColor = style.darkTitleBackground
                SettingsLabel.textColor = style.darkText
                DarkmodeLabel.textColor = style.darkText
                AppearanceLabel.textColor = style.darkText*/
                changeAppearance()
                setNeedsStatusBarAppearanceUpdate()
                AppearanceControl.selectedSegmentIndex = 2
            }
            if UserDefaults.standard.integer(forKey: "DarkmodeStatus") == 0 {
                /*view.backgroundColor = style.lightBackground
                backgroundTitleView.backgroundColor = style.lightTitleBackground
                SettingsLabel.textColor = style.lightText
                DarkmodeLabel.textColor = style.lightText
                AppearanceLabel.textColor = style.lightText*/
                changeAppearance()
                setNeedsStatusBarAppearanceUpdate()
                AppearanceControl.selectedSegmentIndex = 1
            }
        }
        else {
            AppearanceControl.selectedSegmentIndex = 0
            changeAppearance()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if UserDefaults.standard.string(forKey: "ButtonColor") != nil, UserDefaults.standard.string(forKey: "ButtonColor") != "" {
            ChangeColorsBtn.backgroundColor = UIColor(red: CGFloat(UserDefaults.standard.integer(forKey: "ButtonRed")) / 255, green: CGFloat(UserDefaults.standard.integer(forKey: "ButtonGreen")) / 255, blue: CGFloat(UserDefaults.standard.integer(forKey: "ButtonBlue")) / 255, alpha: 1)
            
            ChangeAppIconBtn.backgroundColor = UIColor(red: CGFloat(UserDefaults.standard.integer(forKey: "ButtonRed")) / 255, green: CGFloat(UserDefaults.standard.integer(forKey: "ButtonGreen")) / 255, blue: CGFloat(UserDefaults.standard.integer(forKey: "ButtonBlue")) / 255, alpha: 1)
            
            AppInfoBtn.backgroundColor = UIColor(red: CGFloat(UserDefaults.standard.integer(forKey: "ButtonRed")) / 255, green: CGFloat(UserDefaults.standard.integer(forKey: "ButtonGreen")) / 255, blue: CGFloat(UserDefaults.standard.integer(forKey: "ButtonBlue")) / 255, alpha: 1)
            
            InformationForRequests.backgroundColor = UIColor(red: CGFloat(UserDefaults.standard.integer(forKey: "ButtonRed")) / 255, green: CGFloat(UserDefaults.standard.integer(forKey: "ButtonGreen")) / 255, blue: CGFloat(UserDefaults.standard.integer(forKey: "ButtonBlue")) / 255, alpha: 1)
        }
        if UserDefaults.standard.string(forKey: "TitleBarColor") != nil, UserDefaults.standard.string(forKey: "TitleBarColor") != "" {
            TItleBar.backgroundColor = UIColor(red: CGFloat(UserDefaults.standard.integer(forKey: "TitleBarRed")) / 255, green: CGFloat(UserDefaults.standard.integer(forKey: "TitleBarGreen")) / 255, blue: CGFloat(UserDefaults.standard.integer(forKey: "TitleBarBlue")) / 255, alpha: 1)
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
