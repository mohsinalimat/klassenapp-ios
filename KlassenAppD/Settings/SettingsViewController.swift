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
    @IBOutlet var AppearanceControl: UISegmentedControl!
    @IBOutlet var AppearanceLabel: UILabel!
    @IBOutlet var backgroundTitleView: UIView!
    @IBOutlet weak var PrivacyPolicy: UIButton!
    
    var style = Appearances()
    
    var buttons:[UIButton] = [UIButton]()
    
    @IBAction func AppearanceAction(_ sender: Any) {
        switch self.AppearanceControl.selectedSegmentIndex {
        case 0:
            
            UserDefaults.standard.set(1, forKey: "AutoAppearance")
            
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
            }
            
        case 1:
            
            UserDefaults.standard.set(0, forKey: "AutoAppearance")
            UserDefaults.standard.set(0, forKey: "DarkmodeStatus")
            UIView.animate(withDuration: 0.1) {
                self.changeAppearance()
            }
            self.setNeedsStatusBarAppearanceUpdate()
            
        case 2:
            
            UserDefaults.standard.set(0, forKey: "AutoAppearance")
            UserDefaults.standard.set(1, forKey: "DarkmodeStatus")
            UIView.animate(withDuration: 0.1) {
                self.changeAppearance()
            }
            setNeedsStatusBarAppearanceUpdate()
            
        default:
            break
        }
    }
    
    @IBAction func ChangeAppIcon(_ sender: Any) {
           if #available(iOS 10.3, *) {
               presentStork(controller: ChangeAppIconNewViewController())
           }
       }
       
    @IBAction func ChangeColor(_ sender: Any) {
           self.presentStork(controller: ChangeColorFullViewController())
    }

    @IBAction func InformationForRequestsAction(_ sender: Any) {
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(URL(string: "https://github.com/AdriBoy21/klassenapp-ios/wiki/Hausaufgabenanfragen-(de)")!)
        }
        else {
            UIApplication.shared.openURL(URL(string: "https://github.com/AdriBoy21/klassenapp-ios/wiki/Hausaufgabenanfragen-(de)")!)
        }
    }
    
    @IBAction func PrivacyPolicyBtn(_ sender: Any) {
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(URL(string: "https://github.com/AdriBoy21/klassenapp-ios/wiki/Privacy-Policy")!)
        }
        else {
            UIApplication.shared.openURL(URL(string: "https://github.com/AdriBoy21/klassenapp-ios/wiki/Privacy-Policy")!)
        }
    }
    
    @IBAction func AppInformationsAction(_ sender: Any) {
           self.presentStork(controller: AppInfosViewController())
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
    
    func changeAppearance() {
        if UserDefaults.standard.integer(forKey: "AutoAppearance") == 1 {
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
            if UserDefaults.standard.integer(forKey: "AutoAppearance") == 1 {
                UIView.animate(withDuration: 0.1) {
                    self.changeAppearance()
                }
                self.setNeedsStatusBarAppearanceUpdate()
            }
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        var style: UIStatusBarStyle!
        if UserDefaults.standard.integer(forKey: "AutoAppearance") == 1 {
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        buttons = [self.ChangeColorsBtn, self.ChangeAppIconBtn, self.AppInfoBtn, self.InformationForRequests, self.PrivacyPolicy]
        
        if #available(iOS 13.0, *) {
            AppearanceControl.setEnabled(true, forSegmentAt: 0)
        }
        else {
            self.AppearanceControl.setEnabled(false, forSegmentAt: 0)
            UserDefaults.standard.set(0, forKey: "AutoAppearance")
        }
        
        if UserDefaults.standard.integer(forKey: "AutoAppearance") == 0 {
            if UserDefaults.standard.integer(forKey: "DarkmodeStatus") == 1 {
                self.changeAppearance()
                setNeedsStatusBarAppearanceUpdate()
                self.AppearanceControl.selectedSegmentIndex = 2
            }
            if UserDefaults.standard.integer(forKey: "DarkmodeStatus") == 0 {
                self.changeAppearance()
                setNeedsStatusBarAppearanceUpdate()
                self.AppearanceControl.selectedSegmentIndex = 1
            }
        }
        else {
            self.AppearanceControl.selectedSegmentIndex = 0
            self.changeAppearance()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        for button in buttons {
            if UserDefaults.standard.string(forKey: "ButtonColor") != nil, UserDefaults.standard.string(forKey: "ButtonColor") != "" {
                       button.backgroundColor = UIColor(red: CGFloat(UserDefaults.standard.integer(forKey: "ButtonRed")) / 255, green: CGFloat(UserDefaults.standard.integer(forKey: "ButtonGreen")) / 255, blue: CGFloat(UserDefaults.standard.integer(forKey: "ButtonBlue")) / 255, alpha: 1)
                   }
        }
        if UserDefaults.standard.string(forKey: "TitleBarColor") != nil, UserDefaults.standard.string(forKey: "TitleBarColor") != "" {
            self.TItleBar.backgroundColor = UIColor(red: CGFloat(UserDefaults.standard.integer(forKey: "TitleBarRed")) / 255, green: CGFloat(UserDefaults.standard.integer(forKey: "TitleBarGreen")) / 255, blue: CGFloat(UserDefaults.standard.integer(forKey: "TitleBarBlue")) / 255, alpha: 1)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

private func convertToUIApplicationOpenExternalURLOptionsKeyDictionary(_ input: [String: Any]) -> [UIApplication.OpenExternalURLOptionsKey: Any] {
    return Dictionary(uniqueKeysWithValues: input.map { key, value in (UIApplication.OpenExternalURLOptionsKey(rawValue: key), value) })
}
