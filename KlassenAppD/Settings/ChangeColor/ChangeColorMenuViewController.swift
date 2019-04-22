//
//  ChangeColorMenuViewController.swift
//  KlassenAppD
//
//  Created by Adrian Baumgart on 14.04.19.
//  Copyright © 2019 Adrian Baumgart. All rights reserved.
//

import UIKit

class ChangeColorMenuViewController: UIViewController {

    @IBOutlet weak var BackgroundTitleView: UIView!
    @IBOutlet weak var ChangeColorTitle: UILabel!
    @IBOutlet weak var ChangeButtonColorBTN: UIButton!
    @IBOutlet weak var ChangeTitleBarColorBTN: UIButton!
    @IBOutlet weak var TitleBar: UIView!
    @IBAction func ResetColors(_ sender: Any)
    {
        UserDefaults.standard.set("", forKey: "TitleBarColor")
        UserDefaults.standard.set("", forKey: "ButtonColor")
    }
    @IBAction func ChangeButtonColorACTION(_ sender: Any)
    {
        UserDefaults.standard.set("Button", forKey: "ColorChangeObject")
        performSegue(withIdentifier: "gotoColorPicker", sender: nil)
    }
    @IBAction func ChangeTitleBarColorACTION(_ sender: Any)
    {
        UserDefaults.standard.set("TitleBar", forKey: "ColorChangeObject")
        performSegue(withIdentifier: "gotoColorPicker", sender: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        if UserDefaults.standard.integer(forKey: "DarkmodeStatus") == 1 {
            view.backgroundColor = UIColor(red:0.05, green:0.05, blue:0.05, alpha:1.0)
            BackgroundTitleView.backgroundColor = UIColor(red:0.13, green:0.13, blue:0.13, alpha:1.0)
            ChangeColorTitle.textColor = UIColor.white
            // TouchIDLabel.textColor = UIColor.white
            UIApplication.shared.statusBarStyle = .lightContent
        }
        if UserDefaults.standard.integer(forKey: "DarkmodeStatus") == 0 {
            view.backgroundColor = UIColor.white
            BackgroundTitleView.backgroundColor = UIColor(red:0.97, green:0.97, blue:0.97, alpha:0.8)
            ChangeColorTitle.textColor = UIColor.black
            UIApplication.shared.statusBarStyle = .default
            
        }
        if UserDefaults.standard.string(forKey: "ButtonColor") != nil && UserDefaults.standard.string(forKey: "ButtonColor") != "" {
            self.ChangeButtonColorBTN.backgroundColor = UIColor(red: CGFloat(UserDefaults.standard.integer(forKey: "ButtonRed"))/255, green: CGFloat(UserDefaults.standard.integer(forKey: "ButtonGreen"))/255, blue: CGFloat(UserDefaults.standard.integer(forKey: "ButtonBlue"))/255, alpha: 1)
            
            self.ChangeTitleBarColorBTN.backgroundColor = UIColor(red: CGFloat(UserDefaults.standard.integer(forKey: "ButtonRed"))/255, green: CGFloat(UserDefaults.standard.integer(forKey: "ButtonGreen"))/255, blue: CGFloat(UserDefaults.standard.integer(forKey: "ButtonBlue"))/255, alpha: 1)
        }
        if UserDefaults.standard.string(forKey: "TitleBarColor") != nil && UserDefaults.standard.string(forKey: "TitleBarColor") != "" {
            self.TitleBar.backgroundColor = UIColor(red: CGFloat(UserDefaults.standard.integer(forKey: "TitleBarRed"))/255, green: CGFloat(UserDefaults.standard.integer(forKey: "TitleBarGreen"))/255, blue: CGFloat(UserDefaults.standard.integer(forKey: "TitleBarBlue"))/255, alpha: 1)
        }
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
