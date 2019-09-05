//
//  LaunchAnimationViewController.swift
//  KlassenAppD
//
//  Created by Adrian Baumgart on 04.10.18.
//  Copyright © 2018 Adrian Baumgart. All rights reserved.
//

import RevealingSplashView
import UIKit
import Firebase
import FirebaseDatabase
import FirebaseFunctions
import FirebaseInstanceID
import FirebaseMessaging
import AppCenter
import AppCenterAnalytics
import AppCenterCrashes
import Crashlytics
import Fabric

class LaunchAnimationViewController: UIViewController {
    
    var style = Appearances()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        changeAppearance()
       /* if UserDefaults.standard.integer(forKey: "DarkmodeStatus") == 1 {
            view.backgroundColor = UIColor(red: 0.05, green: 0.05, blue: 0.05, alpha: 1.0)
            self.setNeedsStatusBarAppearanceUpdate()
        }
        if UserDefaults.standard.integer(forKey: "DarkmodeStatus") == 0 {
            view.backgroundColor = UIColor.white
            self.setNeedsStatusBarAppearanceUpdate()
        }*/
    }
    
    func changeAppearance() {
        if UserDefaults.standard.integer(forKey: "AutoAppearance") == 1 {
            if #available(iOS 13.0, *) {
                if traitCollection.userInterfaceStyle == .dark {
                    view.backgroundColor = style.darkBackground
                    setNeedsStatusBarAppearanceUpdate()
                }
                else if traitCollection.userInterfaceStyle == .light || traitCollection.userInterfaceStyle == .unspecified {
                    view.backgroundColor = style.lightBackground
                    setNeedsStatusBarAppearanceUpdate()
                }
            }
        }
        else {
            if UserDefaults.standard.integer(forKey: "DarkmodeStatus") == 1 {
                view.backgroundColor = style.darkBackground
                setNeedsStatusBarAppearanceUpdate()
            }
            else if UserDefaults.standard.integer(forKey: "DarkmodeStatus") == 0 {
                view.backgroundColor = style.lightBackground
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

    override func viewDidAppear(_ animated: Bool) {
        UserDefaults.standard.set(1, forKey: "Checker")

        if #available(iOS 13.0, *) {
            if UserDefaults.standard.integer(forKey: "LaunchedBefore") == 0 {
                UserDefaults.standard.set(1, forKey: "AutoAppearance")
                UserDefaults.standard.set(1, forKey: "LaunchedBefore")
            }
        }

        let revealingSplashView = RevealingSplashView(iconImage: UIImage(named: "LaunchScreenW")!, iconInitialSize: CGSize(width: 300, height: 300), backgroundColor: UIColor(red: 0, green: 0, blue: 0, alpha: 1.0))
        revealingSplashView.duration = 1
        self.view.addSubview(revealingSplashView)
        revealingSplashView.startAnimation {
            FirebaseApp.configure()
            Database.database().isPersistenceEnabled = true
            Fabric.with([Crashlytics.self])
            MSAppCenter.start("1859318b-9a51-4324-baf1-f7dc7bea9f52", withServices: [
                MSAnalytics.self,
                MSCrashes.self
            ])
            self.performSegue(withIdentifier: "directtotb", sender: nil)
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
                if UserDefaults.standard.integer(forKey: "DarkmodeStatus") == 0 {
                    style = .default
                }
            }
        }
        return style
    }
}
