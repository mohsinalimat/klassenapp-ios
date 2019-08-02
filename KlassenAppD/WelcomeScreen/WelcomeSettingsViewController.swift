//
//  WelcomeSettingsViewController.swift
//  KlassenAppD
//
//  Created by Adrian Baumgart on 29.08.18.
//  Copyright © 2018 Adrian Baumgart. All rights reserved.
//

import UIKit

class WelcomeSettingsViewController: UIViewController {
    @IBOutlet var WelcomeSettingsTitle: UILabel!
    @IBOutlet var SettingsMessage: UILabel!
    @IBOutlet var WelcomeDarkmodeLabel: UILabel!
    @IBOutlet var WelcomeDarkmodeOut: UISwitch!

    var style = Appearances()

    @IBAction func WelcomeDarkmodeSwitch(_ sender: UISwitch) {
        if sender.isOn == true {
            view.backgroundColor = style.darkBackground
            WelcomeSettingsTitle.textColor = style.darkText
            SettingsMessage.textColor = style.darkText
            WelcomeDarkmodeLabel.textColor = style.darkText
            setNeedsStatusBarAppearanceUpdate()
            UserDefaults.standard.set(1, forKey: "DarkmodeStatus")
        }
        if sender.isOn != true {
            view.backgroundColor = style.lightBackground
            WelcomeSettingsTitle.textColor = style.lightText
            SettingsMessage.textColor = style.lightText
            WelcomeDarkmodeLabel.textColor = style.lightText
            setNeedsStatusBarAppearanceUpdate()
            UserDefaults.standard.set(0, forKey: "DarkmodeStatus")
        }
    }

    @IBOutlet var WelcomeTouchIDNote: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        if UserDefaults.standard.integer(forKey: "DarkmodeStatus") == 1 {
            view.backgroundColor = UIColor(red: 0.05, green: 0.05, blue: 0.05, alpha: 1.0)
            WelcomeSettingsTitle.textColor = UIColor.white
            SettingsMessage.textColor = UIColor.white
            WelcomeDarkmodeLabel.textColor = UIColor.white
            WelcomeDarkmodeOut.setOn(true, animated: false)
            setNeedsStatusBarAppearanceUpdate()
        }

        if UserDefaults.standard.integer(forKey: "DarkmodeStatus") == 0 {
            view.backgroundColor = UIColor.white
            WelcomeSettingsTitle.textColor = UIColor.black
            SettingsMessage.textColor = UIColor.black
            WelcomeDarkmodeLabel.textColor = UIColor.black
            WelcomeDarkmodeOut.setOn(false, animated: false)
            setNeedsStatusBarAppearanceUpdate()
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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
