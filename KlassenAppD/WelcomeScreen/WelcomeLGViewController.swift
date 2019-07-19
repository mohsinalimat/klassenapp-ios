//
//  WelcomeLGViewController.swift
//  KlassenAppD
//
//  Created by Adrian Baumgart on 29.08.18.
//  Copyright © 2018 Adrian Baumgart. All rights reserved.
//

import UIKit

class WelcomeLGViewController: UIViewController {
    @IBOutlet var WelcomeFinishedTitle: UILabel!
    
    var style = Appearances()
    
    @IBAction func WelcomeFinishedBtn(_ sender: UIButton) {
        UserDefaults.standard.set("done", forKey: "WelcomeTour")
        self.performSegue(withIdentifier: "welcomefinishedSegue", sender: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        if UserDefaults.standard.integer(forKey: "DarkmodeStatus") == 1 {
            view.backgroundColor = style.darkBackground
            self.WelcomeFinishedTitle.textColor = style.darkText
            self.setNeedsStatusBarAppearanceUpdate()
        }
        if UserDefaults.standard.integer(forKey: "DarkmodeStatus") == 0 {
            view.backgroundColor = style.lightBackground
            self.WelcomeFinishedTitle.textColor = style.lightText
            self.setNeedsStatusBarAppearanceUpdate()
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
