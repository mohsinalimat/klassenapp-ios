//
//  WelcomeFunc1ViewController.swift
//  KlassenAppD
//
//  Created by Adrian Baumgart on 29.08.18.
//  Copyright © 2018 Adrian Baumgart. All rights reserved.
//

import UIKit

class WelcomeFunc1ViewController: UIViewController {
    @IBOutlet var FuncTitle: UILabel!
    @IBOutlet var FunctionsDes: UITextView!
    @IBOutlet var FunctionsMore: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        FunctionsDes.scrollRangeToVisible(NSMakeRange(0, 0))
        if UserDefaults.standard.integer(forKey: "DarkmodeStatus") == 1 {
            view.backgroundColor = UIColor(red: 0.05, green: 0.05, blue: 0.05, alpha: 1.0)
            FuncTitle.textColor = UIColor.white
            FunctionsMore.textColor = UIColor.white
            FunctionsDes.textColor = UIColor.white
            FunctionsDes.backgroundColor = UIColor(red: 0.05, green: 0.05, blue: 0.05, alpha: 1.0)
            setNeedsStatusBarAppearanceUpdate()
        }

        if UserDefaults.standard.integer(forKey: "DarkmodeStatus") == 0 {
            view.backgroundColor = UIColor.white
            FuncTitle.textColor = UIColor.black
            FunctionsMore.textColor = UIColor.black
            FunctionsDes.textColor = UIColor.black
            FunctionsDes.backgroundColor = UIColor.white
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
