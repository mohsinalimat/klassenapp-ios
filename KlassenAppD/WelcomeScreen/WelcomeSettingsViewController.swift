//
//  WelcomeSettingsViewController.swift
//  KlassenAppD
//
//  Created by Adrian Baumgart on 29.08.18.
//  Copyright © 2018 Adrian Baumgart. All rights reserved.
//

import UIKit

class WelcomeSettingsViewController: UIViewController {
    @IBOutlet weak var WelcomeSettingsTitle: UILabel!
    @IBOutlet weak var SettingsMessage: UILabel!
    @IBOutlet weak var WelcomeDarkmodeLabel: UILabel!
    @IBOutlet weak var WelcomeDarkmodeOut: UISwitch!
    @IBAction func WelcomeDarkmodeSwitch(_ sender: UISwitch)
    {
        if (sender.isOn == true) {
            view.backgroundColor = UIColor(red:0.05, green:0.05, blue:0.05, alpha:1.0)
            WelcomeSettingsTitle.textColor = UIColor.white
            SettingsMessage.textColor = UIColor.white
            WelcomeDarkmodeLabel.textColor = UIColor.white
            // WelcomeTouchIDNote.textColor = UIColor.white
            UIApplication.shared.statusBarStyle = .lightContent
            UserDefaults.standard.set(1, forKey: "DarkmodeStatus")
        }
        if (sender.isOn != true) {
            view.backgroundColor = UIColor.white
            WelcomeSettingsTitle.textColor = UIColor.black
            SettingsMessage.textColor = UIColor.black
            WelcomeDarkmodeLabel.textColor = UIColor.black
           // WelcomeTouchIDNote.textColor = UIColor.black
            UIApplication.shared.statusBarStyle = .default
            UserDefaults.standard.set(0, forKey: "DarkmodeStatus")
            
        }
    }
    @IBOutlet weak var WelcomeTouchIDNote: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if UserDefaults.standard.integer(forKey: "DarkmodeStatus") == 1 {
            view.backgroundColor = UIColor(red:0.05, green:0.05, blue:0.05, alpha:1.0)
            WelcomeSettingsTitle.textColor = UIColor.white
            SettingsMessage.textColor = UIColor.white
            WelcomeDarkmodeLabel.textColor = UIColor.white
            // WelcomeTouchIDNote.textColor = UIColor.white
            WelcomeDarkmodeOut.setOn(true, animated: false)
            UIApplication.shared.statusBarStyle = .lightContent
        }
        
        if UserDefaults.standard.integer(forKey: "DarkmodeStatus") == 0 {
            view.backgroundColor = UIColor.white
            WelcomeSettingsTitle.textColor = UIColor.black
            SettingsMessage.textColor = UIColor.black
            WelcomeDarkmodeLabel.textColor = UIColor.black
           // WelcomeTouchIDNote.textColor = UIColor.black
            WelcomeDarkmodeOut.setOn(false, animated: false)
            UIApplication.shared.statusBarStyle = .default
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return UIStatusBarStyle(rawValue: UserDefaults.standard.integer(forKey: "DarkmodeStatus"))!
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
