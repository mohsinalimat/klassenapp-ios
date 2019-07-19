//
//  PlansViewController.swift
//  KlassenAppD
//
//  Created by Adrian Baumgart on 24.05.19.
//  Copyright © 2019 Adrian Baumgart. All rights reserved.
//

import SPStorkController
import UIKit

class PlansViewController: UIViewController {
    @IBOutlet var backgroundTitleView: UIView!
    @IBOutlet var TitleBar: UIView!
    @IBOutlet var MainTitle: UILabel!
    @IBOutlet var TimeTableBtn: UIButton!
    @IBOutlet var FoodBtn: UIButton!
    @IBOutlet var ListBtn: UIButton!
    
    var buttons: [UIButton] = [UIButton]()
    
    var style = Appearances()
    
    @IBAction func ListBtnAction(_ sender: Any) {
        presentStork(controller: RememberViewController())
    }
    
    @IBAction func FoodBtnAction(_ sender: Any) {
        presentStork(controller: FoodAllViewController())
    }
    
    @IBAction func TimeTableBtnAction(_ sender: Any) {
        presentStork(controller: TimeTableNewViewController())
    }
    
    func presentStork(controller: UIViewController) {
        let impactFeedbackgenerator = UIImpactFeedbackGenerator(style: .light)
        impactFeedbackgenerator.prepare()
        impactFeedbackgenerator.impactOccurred()
        let controller1 = controller
        let transitionDelegate = SPStorkTransitioningDelegate()
        controller1.transitioningDelegate = transitionDelegate
        controller1.modalPresentationStyle = .custom
        controller1.modalPresentationCapturesStatusBarAppearance = true
        present(controller1, animated: true, completion: nil)
    }
    
    func setArrays() {
        buttons = [self.TimeTableBtn, self.FoodBtn, self.ListBtn]
    }
    
    func viewLoadSetup() {
        setArrays()
        if UserDefaults.standard.string(forKey: "ButtonColor") != nil, UserDefaults.standard.string(forKey: "ButtonColor") != "" {
            for button in buttons {
                button.backgroundColor = UIColor(red: CGFloat(UserDefaults.standard.integer(forKey: "ButtonRed")) / 255, green: CGFloat(UserDefaults.standard.integer(forKey: "ButtonGreen")) / 255, blue: CGFloat(UserDefaults.standard.integer(forKey: "ButtonBlue")) / 255, alpha: 1)
            }
        }
        if UserDefaults.standard.string(forKey: "TitleBarColor") != nil, UserDefaults.standard.string(forKey: "TitleBarColor") != "" {
            TitleBar.backgroundColor = UIColor(red: CGFloat(UserDefaults.standard.integer(forKey: "TitleBarRed")) / 255, green: CGFloat(UserDefaults.standard.integer(forKey: "TitleBarGreen")) / 255, blue: CGFloat(UserDefaults.standard.integer(forKey: "TitleBarBlue")) / 255, alpha: 1)
        }
        
        if UserDefaults.standard.integer(forKey: "DarkmodeStatus") == 1 {
            view.backgroundColor = style.darkBackground
            backgroundTitleView.backgroundColor = style.darkTitleBackground
            MainTitle.textColor = style.darkText
            setNeedsStatusBarAppearanceUpdate()
        }
        if UserDefaults.standard.integer(forKey: "DarkmodeStatus") == 0 {
            view.backgroundColor = style.lightBackground
            backgroundTitleView.backgroundColor = style.lightTitleBackground
            MainTitle.textColor = style.lightText
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
    
    override func viewWillAppear(_ animated: Bool) {
        viewLoadSetup()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
