//
//  EventsViewController.swift
//  KlassenAppD
//
//  Created by Adrian Baumgart on 09.04.18.
//  Copyright © 2018 Adrian Baumgart. All rights reserved.
//

import FirebaseDatabase
import SPStorkController
import UIKit

class EventsViewController: UIViewController {
    @IBOutlet var Arbeit1BtnOut: UIButton!
    @IBOutlet var Arbeit2BtnOut: UIButton!
    @IBOutlet var Arbeit3BtnOut: UIButton!
    @IBOutlet var Arbeit4BtnOut: UIButton!
    @IBOutlet var Arbeit5BtnOut: UIButton!
    @IBOutlet var backgroundTitleView: UIView!
    @IBOutlet var TitleBar: UIView!
    @IBOutlet var TestsLabel: UILabel!
    
    var style = Appearances()
    
    var buttons: [UIButton] = [UIButton]()
    var buttonValues: [ButtonValue] = []
    
    @IBAction func Arbeit1Btn(_ sender: Any) {
        self.presentEvent(eventName: "Arbeit1")
    }
    
    @IBAction func Arbeit2Btn(_ sender: Any) {
        self.presentEvent(eventName: "Arbeit2")
    }
    
    @IBAction func Arbeit3Btn(_ sender: Any) {
        self.presentEvent(eventName: "Arbeit3")
    }
    
    @IBAction func Arbeit4Btn(_ sender: Any) {
        self.presentEvent(eventName: "Arbeit4")
    }
    
    @IBAction func Arbeit5Btn(_ sender: Any) {
        self.presentEvent(eventName: "Arbeit5")
    }
    
    func presentEvent(eventName: String) {
        let impactFeedbackgenerator = UIImpactFeedbackGenerator(style: .light)
        impactFeedbackgenerator.prepare()
        impactFeedbackgenerator.impactOccurred()
        AllTestsViewController.TestVC.selectedTest = eventName
        let controller1 = AllTestsViewController()
        let transitionDelegate = SPStorkTransitioningDelegate()
        controller1.transitioningDelegate = transitionDelegate
        controller1.modalPresentationStyle = .custom
        controller1.modalPresentationCapturesStatusBarAppearance = true
        self.present(controller1, animated: true, completion: nil)
    }
    
    func setArrays() {
        self.buttons = [self.Arbeit1BtnOut, self.Arbeit2BtnOut, self.Arbeit3BtnOut, self.Arbeit4BtnOut, self.Arbeit5BtnOut]
        self.buttonValues = [ButtonValue(child: "Arbeit1", button: Arbeit1BtnOut), ButtonValue(child: "Arbeit2", button: Arbeit2BtnOut), ButtonValue(child: "Arbeit3", button: Arbeit3BtnOut), ButtonValue(child: "Arbeit4", button: Arbeit4BtnOut), ButtonValue(child: "Arbeit5", button: Arbeit5BtnOut)]
    }
    
    func viewLoadSetup() {
        self.setArrays()
        
        if UserDefaults.standard.string(forKey: "ButtonColor") != nil, UserDefaults.standard.string(forKey: "ButtonColor") != "" {
            for button in self.buttons {
                button.backgroundColor = UIColor(red: CGFloat(UserDefaults.standard.integer(forKey: "ButtonRed")) / 255, green: CGFloat(UserDefaults.standard.integer(forKey: "ButtonGreen")) / 255, blue: CGFloat(UserDefaults.standard.integer(forKey: "ButtonBlue")) / 255, alpha: 1)
            }
        }
        if UserDefaults.standard.string(forKey: "TitleBarColor") != nil, UserDefaults.standard.string(forKey: "TitleBarColor") != "" {
            self.TitleBar.backgroundColor = UIColor(red: CGFloat(UserDefaults.standard.integer(forKey: "TitleBarRed")) / 255, green: CGFloat(UserDefaults.standard.integer(forKey: "TitleBarGreen")) / 255, blue: CGFloat(UserDefaults.standard.integer(forKey: "TitleBarBlue")) / 255, alpha: 1)
        }
        self.changeAppearance()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.viewLoadSetup()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func changeAppearance() {
        if UserDefaults.standard.integer(forKey: "AutoAppearance") == 1 {
            if #available(iOS 13.0, *) {
                if traitCollection.userInterfaceStyle == .dark {
                    view.backgroundColor = self.style.darkBackground
                    self.backgroundTitleView.backgroundColor = self.style.darkTitleBackground
                    self.TestsLabel.textColor = self.style.darkText
                    self.tabBarController!.tabBar.barTintColor = self.style.darkBarTintColor
                    self.tabBarController!.tabBar.tintColor = self.style.darkTintColor
                    setNeedsStatusBarAppearanceUpdate()
                }
                else if traitCollection.userInterfaceStyle == .light || traitCollection.userInterfaceStyle == .unspecified {
                    view.backgroundColor = self.style.lightBackground
                    self.backgroundTitleView.backgroundColor = self.style.lightTitleBackground
                    self.TestsLabel.textColor = self.style.lightText
                    self.tabBarController!.tabBar.barTintColor = self.style.lightBarTintColor
                    self.tabBarController!.tabBar.tintColor = self.style.lightTintColor
                    setNeedsStatusBarAppearanceUpdate()
                }
            }
        }
        else {
            if UserDefaults.standard.integer(forKey: "DarkmodeStatus") == 1 {
                view.backgroundColor = self.style.darkBackground
                self.backgroundTitleView.backgroundColor = self.style.darkTitleBackground
                self.TestsLabel.textColor = self.style.darkText
                self.tabBarController!.tabBar.barTintColor = self.style.darkBarTintColor
                self.tabBarController!.tabBar.tintColor = self.style.darkTintColor
                setNeedsStatusBarAppearanceUpdate()
            }
            else if UserDefaults.standard.integer(forKey: "DarkmodeStatus") == 0 {
                view.backgroundColor = self.style.lightBackground
                self.backgroundTitleView.backgroundColor = self.style.lightTitleBackground
                self.TestsLabel.textColor = self.style.lightText
                self.tabBarController!.tabBar.barTintColor = self.style.lightBarTintColor
                self.tabBarController!.tabBar.tintColor = self.style.lightTintColor
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
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        var ref: DatabaseReference!
        
        ref = Database.database().reference()
        
        for value in self.buttonValues {
            ref.child("arbeiten").child(value.child).child("buttonname").observe(.value) { ArbeitButtonSnap in
                let ArbeitLabel = ArbeitButtonSnap.value as? String
                if ArbeitLabel != "-" {
                    value.button.isEnabled = true
                }
                else {
                    value.button.isEnabled = false
                }
                value.button.setTitle(ArbeitLabel, for: .normal)
            }
        }
    }
    
    struct ButtonValue {
        var child: String!
        var button: UIButton!
    }
}
