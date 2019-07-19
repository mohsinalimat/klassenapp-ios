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
    
    var style = Appearances()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        InformationsDes.scrollRangeToVisible(NSMakeRange(0, 0))
        if UserDefaults.standard.integer(forKey: "DarkmodeStatus") == 1 {
            view.backgroundColor = style.darkBackground
            InformationsTitle.textColor = style.darkText
            InformationsDes.textColor = style.darkText
            InformationsDes.backgroundColor = style.darkBackground
            setNeedsStatusBarAppearanceUpdate()
        }

        if UserDefaults.standard.integer(forKey: "DarkmodeStatus") == 0 {
            view.backgroundColor = style.lightBackground
            InformationsTitle.textColor = style.lightText
            InformationsDes.textColor = style.lightText
            InformationsDes.backgroundColor = style.lightBackground
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
