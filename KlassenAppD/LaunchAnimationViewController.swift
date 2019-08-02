//
//  LaunchAnimationViewController.swift
//  KlassenAppD
//
//  Created by Adrian Baumgart on 04.10.18.
//  Copyright © 2018 Adrian Baumgart. All rights reserved.
//

import RevealingSplashView
import UIKit

class LaunchAnimationViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        if UserDefaults.standard.integer(forKey: "DarkmodeStatus") == 1 {
            view.backgroundColor = UIColor(red: 0.05, green: 0.05, blue: 0.05, alpha: 1.0)
            self.setNeedsStatusBarAppearanceUpdate()
        }
        if UserDefaults.standard.integer(forKey: "DarkmodeStatus") == 0 {
            view.backgroundColor = UIColor.white
            self.setNeedsStatusBarAppearanceUpdate()
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
            self.performSegue(withIdentifier: "directtotb", sender: nil)
        }
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        var style: UIStatusBarStyle!
        if UserDefaults.standard.integer(forKey: "DarkmodeStatus") == 1 {
            style = .lightContent
        }
        else if UserDefaults.standard.integer(forKey: "DarkmodeStatus") == 0 {
            style = .default
        }
        return style
    }
}
