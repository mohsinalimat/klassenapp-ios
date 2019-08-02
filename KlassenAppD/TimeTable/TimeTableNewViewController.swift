//
//  TimeTableNewViewController.swift
//  KlassenAppD
//
//  Created by Adrian Baumgart on 19.07.19.
//  Copyright © 2019 Adrian Baumgart. All rights reserved.
//

import SPFakeBar
import SPStorkController
import UIKit

class TimeTableNewViewController: UIViewController {
    var navigationbar = SPFakeBarView(style: .stork)
    
    var style = Appearances()
    
    var createdButtons: [crtbutton] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let screenWidth = view.frame.width
        
        let buttonheight = (screenWidth / 100) * 20
        
        createdButtons = [crtbutton(title: "Montag", yfactor: 110), crtbutton(title: "Dienstag", yfactor: 110 + buttonheight + 20), crtbutton(title: "Mittwoch", yfactor: 110 + buttonheight + 20 + buttonheight + 20), crtbutton(title: "Donnerstag", yfactor: 110 + buttonheight + 20 + buttonheight + 20 + buttonheight + 20), crtbutton(title: "Freitag", yfactor: 110 + buttonheight + 20 + buttonheight + 20 + buttonheight + 20 + buttonheight + 20)]
        
        navigationbar.titleLabel.text = "Stundenplan"
        navigationbar.titleLabel.font = navigationbar.titleLabel.font.withSize(23)
        navigationbar.height = 95
        navigationbar.titleLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
        navigationbar.titleLabel.numberOfLines = 3
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
        
        for button in createdButtons {
            let sbutton = UIButton(type: .system)
            sbutton.frame = CGRect(x: 0, y: button.yfactor, width: screenWidth - 60, height: buttonheight)
            sbutton.center.x = view.center.x
            sbutton.setTitle(button.title, for: .normal)
            sbutton.titleLabel?.font = .boldSystemFont(ofSize: 21.0)
            sbutton.setTitleColor(.white, for: .normal)
            sbutton.layer.cornerRadius = 15.0
            sbutton.backgroundColor = UIColor(red: 0.00, green: 0.48, blue: 1.00, alpha: 1.0)
            sbutton.addTarget(self, action: #selector(mainReciever), for: .touchUpInside)
            
            if UserDefaults.standard.string(forKey: "ButtonColor") != nil, UserDefaults.standard.string(forKey: "ButtonColor") != "" {
                sbutton.backgroundColor = UIColor(red: CGFloat(UserDefaults.standard.integer(forKey: "ButtonRed")) / 255, green: CGFloat(UserDefaults.standard.integer(forKey: "ButtonGreen")) / 255, blue: CGFloat(UserDefaults.standard.integer(forKey: "ButtonBlue")) / 255, alpha: 1)
            }
            
            view.addSubview(sbutton)
        }
        
        changeAppearance()
    }
    
    func changeAppearance() {
        if UserDefaults.standard.integer(forKey: "AutoAppearance") == 1 {
            if #available(iOS 13.0, *) {
                if traitCollection.userInterfaceStyle == .dark {
                    view.backgroundColor = style.darkBackground
                    navigationbar.backgroundColor = style.darkTitleBackground
                    navigationbar.titleLabel.textColor = style.darkText
                    setNeedsStatusBarAppearanceUpdate()
                }
                else if traitCollection.userInterfaceStyle == .light || traitCollection.userInterfaceStyle == .unspecified {
                    view.backgroundColor = style.lightBackground
                    navigationbar.backgroundColor = style.lightTitleBackground
                    navigationbar.titleLabel.textColor = style.lightText
                    setNeedsStatusBarAppearanceUpdate()
                }
            }
        }
        else {
            if UserDefaults.standard.integer(forKey: "DarkmodeStatus") == 1 {
                view.backgroundColor = style.darkBackground
                navigationbar.backgroundColor = style.darkTitleBackground
                navigationbar.titleLabel.textColor = style.darkText
                setNeedsStatusBarAppearanceUpdate()
            }
            else if UserDefaults.standard.integer(forKey: "DarkmodeStatus") == 0 {
                view.backgroundColor = style.lightBackground
                navigationbar.backgroundColor = style.lightTitleBackground
                navigationbar.titleLabel.textColor = style.lightText
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
    
    @objc func mainReciever(sender: UIButton) {
        if sender.title(for: .normal) == "Montag" {
            monday()
        }
        if sender.title(for: .normal) == "Dienstag" {
            tuesday()
        }
        if sender.title(for: .normal) == "Mittwoch" {
            wednesday()
        }
        if sender.title(for: .normal) == "Donnerstag" {
            thursday()
        }
        if sender.title(for: .normal) == "Freitag" {
            friday()
        }
    }
    
    @objc func monday() {
        presentStork(day: "monday")
    }
    
    @objc func tuesday() {
        presentStork(day: "tuesday")
    }
    
    @objc func wednesday() {
        presentStork(day: "wednesday")
    }
    
    @objc func thursday() {
        presentStork(day: "thursday")
    }
    
    @objc func friday() {
        presentStork(day: "friday")
    }
    
    func presentStork(day: String) {
        let impactFeedbackgenerator = UIImpactFeedbackGenerator(style: .light)
        impactFeedbackgenerator.prepare()
        impactFeedbackgenerator.impactOccurred()
        TimeTableAllViewController.TimeTableVC.selectedDay = day
        let controller1 = TimeTableAllViewController()
        let transitionDelegate = SPStorkTransitioningDelegate()
        controller1.transitioningDelegate = transitionDelegate
        controller1.modalPresentationStyle = .custom
        controller1.modalPresentationCapturesStatusBarAppearance = true
        present(controller1, animated: true, completion: nil)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    struct crtbutton {
        var title: String
        var yfactor: CGFloat
    }
}
