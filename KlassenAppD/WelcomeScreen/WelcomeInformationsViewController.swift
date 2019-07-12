//
//  WelcomeInformationsViewController.swift
//  KlassenAppD
//
//  Created by Adrian Baumgart on 29.08.18.
//  Copyright © 2018 Adrian Baumgart. All rights reserved.
//

import UIKit

class WelcomeInformationsViewController: UIViewController {
    @IBOutlet var InformationsTitle: UILabel!
    @IBOutlet var InformationsDes: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        InformationsDes.scrollRangeToVisible(NSMakeRange(0, 0))
        if UserDefaults.standard.integer(forKey: "DarkmodeStatus") == 1 {
            view.backgroundColor = UIColor(red: 0.05, green: 0.05, blue: 0.05, alpha: 1.0)
            InformationsTitle.textColor = UIColor.white
            InformationsDes.textColor = UIColor.white
            InformationsDes.backgroundColor = UIColor(red: 0.05, green: 0.05, blue: 0.05, alpha: 1.0)
            setNeedsStatusBarAppearanceUpdate()
        }

        if UserDefaults.standard.integer(forKey: "DarkmodeStatus") == 0 {
            view.backgroundColor = UIColor.white
            InformationsTitle.textColor = UIColor.black
            InformationsDes.textColor = UIColor.black
            InformationsDes.backgroundColor = UIColor.white
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
