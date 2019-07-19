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
    
    var style = Appearances()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if UserDefaults.standard.integer(forKey: "DarkmodeStatus") == 1 {
            view.backgroundColor = style.darkBackground
            EvenMoreInformations.textColor = style.darkText
            EvenMoreInformationsNote1.textColor = style.darkText
            EvenMoreInformationsNote1.backgroundColor = style.darkBackground
            EvenMoreInformationsNote2.textColor = style.darkText
            EvenMoreInformationsNote2.backgroundColor = style.darkBackground
            setNeedsStatusBarAppearanceUpdate()
        }

        if UserDefaults.standard.integer(forKey: "DarkmodeStatus") == 0 {
            view.backgroundColor = style.lightBackground
            EvenMoreInformations.textColor = style.lightText
            EvenMoreInformationsNote1.textColor = style.lightText
            EvenMoreInformationsNote1.backgroundColor = style.lightBackground
            EvenMoreInformationsNote2.textColor = style.lightText
            EvenMoreInformationsNote2.backgroundColor = style.lightBackground
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
