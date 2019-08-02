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

    var style = Appearances()

    override func viewDidLoad() {
        super.viewDidLoad()
        FunctionsDes.scrollRangeToVisible(NSMakeRange(0, 0))
        if UserDefaults.standard.integer(forKey: "DarkmodeStatus") == 1 {
            view.backgroundColor = style.darkBackground
            FuncTitle.textColor = style.darkText
            FunctionsMore.textColor = style.darkText
            FunctionsDes.textColor = style.darkText
            FunctionsDes.backgroundColor = style.darkBackground
            setNeedsStatusBarAppearanceUpdate()
        }

        if UserDefaults.standard.integer(forKey: "DarkmodeStatus") == 0 {
            view.backgroundColor = style.lightBackground
            FuncTitle.textColor = style.lightText
            FunctionsMore.textColor = style.lightText
            FunctionsDes.textColor = style.lightText
            FunctionsDes.backgroundColor = style.lightBackground
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
