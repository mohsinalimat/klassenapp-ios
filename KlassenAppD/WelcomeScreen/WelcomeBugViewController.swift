//
//  WelcomeBugViewController.swift
//  KlassenAppD
//
//  Created by Adrian Baumgart on 29.08.18.
//  Copyright © 2018 Adrian Baumgart. All rights reserved.
//

import UIKit

class WelcomeBugViewController: UIViewController {
    @IBOutlet var EvenMoreInformations: UILabel!
    @IBOutlet var EvenMoreInformationsNote1: UITextView!
    @IBOutlet var EvenMoreInformationsNote2: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        if UserDefaults.standard.integer(forKey: "DarkmodeStatus") == 1 {
            view.backgroundColor = UIColor(red: 0.05, green: 0.05, blue: 0.05, alpha: 1.0)
            EvenMoreInformations.textColor = UIColor.white
            EvenMoreInformationsNote1.textColor = UIColor.white
            EvenMoreInformationsNote1.backgroundColor = UIColor(red: 0.05, green: 0.05, blue: 0.05, alpha: 1.0)
            EvenMoreInformationsNote2.textColor = UIColor.white
            EvenMoreInformationsNote2.backgroundColor = UIColor(red: 0.05, green: 0.05, blue: 0.05, alpha: 1.0)
            setNeedsStatusBarAppearanceUpdate()
        }

        if UserDefaults.standard.integer(forKey: "DarkmodeStatus") == 0 {
            view.backgroundColor = UIColor.white
            EvenMoreInformations.textColor = UIColor.black
            EvenMoreInformationsNote1.textColor = UIColor.black
            EvenMoreInformationsNote1.backgroundColor = UIColor.white
            EvenMoreInformationsNote2.textColor = UIColor.black
            EvenMoreInformationsNote2.backgroundColor = UIColor.white
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
