//
//  ChangeColorMenuViewController.swift
//  KlassenAppD
//
//  Created by Adrian Baumgart on 14.04.19.
//  Copyright © 2019 Adrian Baumgart. All rights reserved.
//

import UIKit

class ChangeColorMenuViewController: UIViewController {
    @IBOutlet var BackgroundTitleView: UIView!
    @IBOutlet var ChangeColorTitle: UILabel!
    @IBOutlet var ChangeButtonColorBTN: UIButton!
    @IBOutlet var ChangeTitleBarColorBTN: UIButton!
    @IBOutlet var TitleBar: UIView!
    @IBAction func BackBtn(_ sender: Any) {
        HomeViewController.AutomaticMover.LastVisitedView = "settings"
        self.performSegue(withIdentifier: "backfromcolor", sender: nil)
    }

    @IBAction func ResetColors(_ sender: Any) {
        UserDefaults.standard.set("", forKey: "TitleBarColor")
        UserDefaults.standard.set("", forKey: "ButtonColor")
        HomeViewController.AutomaticMover.LastVisitedView = "settings"
        self.performSegue(withIdentifier: "backfromcolor", sender: nil)
    }

    @IBAction func ChangeButtonColorACTION(_ sender: Any) {
        UserDefaults.standard.set("Button", forKey: "ColorChangeObject")
        performSegue(withIdentifier: "gotoColorPicker", sender: nil)
    }

    @IBAction func ChangeTitleBarColorACTION(_ sender: Any) {
        UserDefaults.standard.set("TitleBar", forKey: "ColorChangeObject")
        performSegue(withIdentifier: "gotoColorPicker", sender: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        if UserDefaults.standard.integer(forKey: "DarkmodeStatus") == 1 {
            view.backgroundColor = UIColor(red: 0.05, green: 0.05, blue: 0.05, alpha: 1.0)
            self.BackgroundTitleView.backgroundColor = UIColor(red: 0.13, green: 0.13, blue: 0.13, alpha: 1.0)
            self.ChangeColorTitle.textColor = UIColor.white
            self.setNeedsStatusBarAppearanceUpdate()
        }
        if UserDefaults.standard.integer(forKey: "DarkmodeStatus") == 0 {
            view.backgroundColor = UIColor.white
            self.BackgroundTitleView.backgroundColor = UIColor(red: 0.95, green: 0.95, blue: 0.95, alpha: 1.0)
            self.ChangeColorTitle.textColor = UIColor.black
            self.setNeedsStatusBarAppearanceUpdate()
        }
        if UserDefaults.standard.string(forKey: "ButtonColor") != nil, UserDefaults.standard.string(forKey: "ButtonColor") != "" {
            self.ChangeButtonColorBTN.backgroundColor = UIColor(red: CGFloat(UserDefaults.standard.integer(forKey: "ButtonRed")) / 255, green: CGFloat(UserDefaults.standard.integer(forKey: "ButtonGreen")) / 255, blue: CGFloat(UserDefaults.standard.integer(forKey: "ButtonBlue")) / 255, alpha: 1)

            self.ChangeTitleBarColorBTN.backgroundColor = UIColor(red: CGFloat(UserDefaults.standard.integer(forKey: "ButtonRed")) / 255, green: CGFloat(UserDefaults.standard.integer(forKey: "ButtonGreen")) / 255, blue: CGFloat(UserDefaults.standard.integer(forKey: "ButtonBlue")) / 255, alpha: 1)
        }
        if UserDefaults.standard.string(forKey: "TitleBarColor") != nil, UserDefaults.standard.string(forKey: "TitleBarColor") != "" {
            self.TitleBar.backgroundColor = UIColor(red: CGFloat(UserDefaults.standard.integer(forKey: "TitleBarRed")) / 255, green: CGFloat(UserDefaults.standard.integer(forKey: "TitleBarGreen")) / 255, blue: CGFloat(UserDefaults.standard.integer(forKey: "TitleBarBlue")) / 255, alpha: 1)
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
