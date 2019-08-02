//
//  ChangeColorFullViewController.swift
//  KlassenAppD
//
//  Created by Adrian Baumgart on 19.07.19.
//  Copyright © 2019 Adrian Baumgart. All rights reserved.
//

import EZAlertController
import IGColorPicker
import SPAlert
import SPFakeBar
import UIKit

class ChangeColorFullViewController: UIViewController, ColorPickerViewDelegate, ColorPickerViewDelegateFlowLayout {
    let navigationbar = SPFakeBarView(style: .stork)
    
    var style = Appearances()
    
    var ColorPicker: ColorPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tempColorSave.red = nil
        tempColorSave.green = nil
        tempColorSave.blue = nil
        
        navigationbar.titleLabel.text = "Farben ändern"
        navigationbar.titleLabel.font = navigationbar.titleLabel.font.withSize(23)
        navigationbar.rightButton.setTitle("Reset", for: .normal)
        navigationbar.rightButton.titleLabel?.font = .boldSystemFont(ofSize: 17)
        navigationbar.rightButton.addTarget(self, action: #selector(resetColors), for: .touchUpInside)
        navigationbar.height = 95
        navigationbar.titleLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
        navigationbar.titleLabel.numberOfLines = 3
        view.addSubview(navigationbar)
        for subview in navigationbar.subviews {
            if subview is UIVisualEffectView {
                subview.removeFromSuperview()
            }
        }
        
        let titlebar = UIView(frame: CGRect(x: 0, y: navigationbar.height - 1, width: view.frame.width, height: 3))
        titlebar.backgroundColor = UIColor(red: 0.61, green: 0.32, blue: 0.88, alpha: 1.0)
        
        if UserDefaults.standard.string(forKey: "TitleBarColor") != nil, UserDefaults.standard.string(forKey: "TitleBarColor") != "" {
            titlebar.backgroundColor = UIColor(red: CGFloat(UserDefaults.standard.integer(forKey: "TitleBarRed")) / 255, green: CGFloat(UserDefaults.standard.integer(forKey: "TitleBarGreen")) / 255, blue: CGFloat(UserDefaults.standard.integer(forKey: "TitleBarBlue")) / 255, alpha: 1)
        }
        view.addSubview(titlebar)
        
        ColorPicker = ColorPickerView(frame: CGRect(x: 0, y: 110, width: view.frame.width, height: view.frame.height - 300)) // x: 10, y: 110
        
        ColorPicker.center.x = view.center.x
        // ColorPicker.layoutDelegate = self as! ColorPickerViewDelegateFlowLayout
        ColorPicker.delegate = self
        ColorPicker.layoutDelegate = self
        // ColorPicker.layoutDelegate = self as! ColorPickerViewDelegateFlowLayout
        ColorPicker.style = .circle
        ColorPicker.selectionStyle = .check
        ColorPicker.isSelectedColorTappable = false
        view.addSubview(ColorPicker)
        
        let TitleBarButton = UIButton(type: .system)
        TitleBarButton.frame = CGRect(x: 10, y: view.frame.height - 180, width: (view.frame.width / 2) - 20, height: 80) // y: view.frame.height - 140
        TitleBarButton.setTitle("Titelleiste", for: .normal)
        TitleBarButton.titleLabel?.font = .boldSystemFont(ofSize: 21.0)
        TitleBarButton.setTitleColor(.white, for: .normal)
        TitleBarButton.layer.cornerRadius = 15.0
        TitleBarButton.backgroundColor = UIColor(red: 0.00, green: 0.48, blue: 1.00, alpha: 1.0)
        TitleBarButton.addTarget(self, action: #selector(setTitleBarColor), for: .touchUpInside)
        
        if UserDefaults.standard.string(forKey: "ButtonColor") != nil, UserDefaults.standard.string(forKey: "ButtonColor") != "" {
            TitleBarButton.backgroundColor = UIColor(red: CGFloat(UserDefaults.standard.integer(forKey: "ButtonRed")) / 255, green: CGFloat(UserDefaults.standard.integer(forKey: "ButtonGreen")) / 255, blue: CGFloat(UserDefaults.standard.integer(forKey: "ButtonBlue")) / 255, alpha: 1)
        }
        
        view.addSubview(TitleBarButton)
        
        let ButtonChangeBtn = UIButton(type: .system)
        ButtonChangeBtn.frame = CGRect(x: view.frame.width - (view.frame.width / 2) + 10, y: view.frame.height - 180, width: (view.frame.width / 2) - 20, height: 80) // y: view.frame.height - 140
        ButtonChangeBtn.setTitle("Knöpfe", for: .normal)
        ButtonChangeBtn.titleLabel?.font = .boldSystemFont(ofSize: 21.0)
        ButtonChangeBtn.setTitleColor(.white, for: .normal)
        ButtonChangeBtn.layer.cornerRadius = 15.0
        ButtonChangeBtn.backgroundColor = UIColor(red: 0.00, green: 0.48, blue: 1.00, alpha: 1.0)
        ButtonChangeBtn.addTarget(self, action: #selector(setButtonColor), for: .touchUpInside)
        
        if UserDefaults.standard.string(forKey: "ButtonColor") != nil, UserDefaults.standard.string(forKey: "ButtonColor") != "" {
            ButtonChangeBtn.backgroundColor = UIColor(red: CGFloat(UserDefaults.standard.integer(forKey: "ButtonRed")) / 255, green: CGFloat(UserDefaults.standard.integer(forKey: "ButtonGreen")) / 255, blue: CGFloat(UserDefaults.standard.integer(forKey: "ButtonBlue")) / 255, alpha: 1)
        }
        
        view.addSubview(ButtonChangeBtn)
        
        changeAppearance()
        /* if UserDefaults.standard.integer(forKey: "DarkmodeStatus") == 1 {
             view.backgroundColor = style.darkBackground
             navigationbar.backgroundColor = style.darkTitleBackground
             navigationbar.titleLabel.textColor = style.darkText
             setNeedsStatusBarAppearanceUpdate()
         }
         if UserDefaults.standard.integer(forKey: "DarkmodeStatus") == 0 {
             view.backgroundColor = style.lightBackground
             navigationbar.backgroundColor = style.lightTitleBackground
             navigationbar.titleLabel.textColor = style.lightText
             setNeedsStatusBarAppearanceUpdate()
         } */
        
        // Do any additional setup after loading the view.
    }
    
    func changeAppearance() {
        if UserDefaults.standard.integer(forKey: "AutoAppearance") == 1 {
            if #available(iOS 13.0, *) {
                if traitCollection.userInterfaceStyle == .dark {
                    view.backgroundColor = style.darkBackground
                    navigationbar.backgroundColor = style.darkTitleBackground
                    navigationbar.titleLabel.textColor = style.darkText
                    setNeedsStatusBarAppearanceUpdate()
                }
                else if traitCollection.userInterfaceStyle == .light || traitCollection.userInterfaceStyle == .unspecified {
                    view.backgroundColor = style.lightBackground
                    navigationbar.backgroundColor = style.lightTitleBackground
                    navigationbar.titleLabel.textColor = style.lightText
                    setNeedsStatusBarAppearanceUpdate()
                }
            }
        }
        else {
            if UserDefaults.standard.integer(forKey: "DarkmodeStatus") == 1 {
                view.backgroundColor = style.darkBackground
                navigationbar.backgroundColor = style.darkTitleBackground
                navigationbar.titleLabel.textColor = style.darkText
                setNeedsStatusBarAppearanceUpdate()
            }
            else if UserDefaults.standard.integer(forKey: "DarkmodeStatus") == 0 {
                view.backgroundColor = style.lightBackground
                navigationbar.backgroundColor = style.lightTitleBackground
                navigationbar.titleLabel.textColor = style.lightText
                setNeedsStatusBarAppearanceUpdate()
            }
        }
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        
        if #available(iOS 13.0, *) {
            if UserDefaults.standard.integer(forKey: "AutoAppearance") == 1 {
                UIView.animate(withDuration: 0.1) {
                    self.changeAppearance()
                }
                self.setNeedsStatusBarAppearanceUpdate()
            }
        }
        else {
            // Fallback on earlier versions
        }
    }
    
    @objc func setTitleBarColor() {
        if tempColorSave.red != nil, tempColorSave.green != nil, tempColorSave.blue != nil {
            UserDefaults.standard.set("active", forKey: "TitleBarColor")
            UserDefaults.standard.set(tempColorSave.red, forKey: "TitleBarRed")
            UserDefaults.standard.set(tempColorSave.green, forKey: "TitleBarGreen")
            UserDefaults.standard.set(tempColorSave.blue, forKey: "TitleBarBlue")
            
            let doneAlert = SPAlertView(title: "Gespeichert", message: "Neustart wird durchgeführt...", preset: .done)
            
            for subview in doneAlert.subviews {
                if subview is UIVisualEffectView {
                    subview.removeFromSuperview()
                }
            }
            
            /*   if UserDefaults.standard.integer(forKey: "DarkmodeStatus") == 1 {
                 doneAlert.backgroundColor = .black
                 let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.dark)
                 let blurEffectView = UIVisualEffectView(effect: blurEffect)
                 blurEffectView.frame = view.bounds
                 blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
                 doneAlert.insertSubview(blurEffectView, at: 0)
             }
             if UserDefaults.standard.integer(forKey: "DarkmodeStatus") == 0 {
                 doneAlert.backgroundColor = .white
                 let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.extraLight)
                 let blurEffectView = UIVisualEffectView(effect: blurEffect)
                 blurEffectView.frame = view.bounds
                 blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
                 doneAlert.insertSubview(blurEffectView, at: 0)
             }*/
            
            if UserDefaults.standard.integer(forKey: "AutoAppearance") == 1 {
                if #available(iOS 13.0, *) {
                    if traitCollection.userInterfaceStyle == .dark {
                        doneAlert.backgroundColor = .black
                        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.dark)
                        let blurEffectView = UIVisualEffectView(effect: blurEffect)
                        blurEffectView.frame = view.bounds
                        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
                        doneAlert.insertSubview(blurEffectView, at: 0)
                    }
                    else if traitCollection.userInterfaceStyle == .light || traitCollection.userInterfaceStyle == .unspecified {
                        doneAlert.backgroundColor = .white
                        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.extraLight)
                        let blurEffectView = UIVisualEffectView(effect: blurEffect)
                        blurEffectView.frame = view.bounds
                        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
                        doneAlert.insertSubview(blurEffectView, at: 0)
                    }
                }
            }
            else {
                if UserDefaults.standard.integer(forKey: "DarkmodeStatus") == 1 {
                    doneAlert.backgroundColor = .black
                    let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.dark)
                    let blurEffectView = UIVisualEffectView(effect: blurEffect)
                    blurEffectView.frame = view.bounds
                    blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
                    doneAlert.insertSubview(blurEffectView, at: 0)
                }
                else if UserDefaults.standard.integer(forKey: "DarkmodeStatus") == 0 {
                    doneAlert.backgroundColor = .white
                    let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.extraLight)
                    let blurEffectView = UIVisualEffectView(effect: blurEffect)
                    blurEffectView.frame = view.bounds
                    blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
                    doneAlert.insertSubview(blurEffectView, at: 0)
                }
            }
            
            doneAlert.duration = 1
            doneAlert.present()
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                self.children.forEach { vc in
                    vc.dismiss(animated: false, completion: nil)
                }
                
                let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let settingsc = storyboard.instantiateViewController(withIdentifier: "launch") as! LaunchAnimationViewController
                self.present(settingsc, animated: false, completion: nil)
            }
        }
        else {
            EZAlertController.alert("Fehler", message: "Bitte wähle eine Farbe aus.")
        }
    }
    
    @objc func setButtonColor() {
        if tempColorSave.red != nil, tempColorSave.green != nil, tempColorSave.blue != nil {
            UserDefaults.standard.set("active", forKey: "ButtonColor")
            UserDefaults.standard.set(tempColorSave.red, forKey: "ButtonRed")
            UserDefaults.standard.set(tempColorSave.green, forKey: "ButtonGreen")
            UserDefaults.standard.set(tempColorSave.blue, forKey: "ButtonBlue")
            
            let doneAlert = SPAlertView(title: "Gespeichert", message: "Neustart wird durchgeführt...", preset: .done)
            
            for subview in doneAlert.subviews {
                if subview is UIVisualEffectView {
                    subview.removeFromSuperview()
                }
            }
            
            /*  if UserDefaults.standard.integer(forKey: "DarkmodeStatus") == 1 {
                 doneAlert.backgroundColor = .black
                 let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.dark)
                 let blurEffectView = UIVisualEffectView(effect: blurEffect)
                 blurEffectView.frame = view.bounds
                 blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
                 doneAlert.insertSubview(blurEffectView, at: 0)
             }
             if UserDefaults.standard.integer(forKey: "DarkmodeStatus") == 0 {
                 doneAlert.backgroundColor = .white
                 let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.extraLight)
                 let blurEffectView = UIVisualEffectView(effect: blurEffect)
                 blurEffectView.frame = view.bounds
                 blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
                 doneAlert.insertSubview(blurEffectView, at: 0)
             }*/
            
            if UserDefaults.standard.integer(forKey: "AutoAppearance") == 1 {
                if #available(iOS 13.0, *) {
                    if traitCollection.userInterfaceStyle == .dark {
                        doneAlert.backgroundColor = .black
                        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.dark)
                        let blurEffectView = UIVisualEffectView(effect: blurEffect)
                        blurEffectView.frame = view.bounds
                        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
                        doneAlert.insertSubview(blurEffectView, at: 0)
                    }
                    else if traitCollection.userInterfaceStyle == .light || traitCollection.userInterfaceStyle == .unspecified {
                        doneAlert.backgroundColor = .white
                        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.extraLight)
                        let blurEffectView = UIVisualEffectView(effect: blurEffect)
                        blurEffectView.frame = view.bounds
                        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
                        doneAlert.insertSubview(blurEffectView, at: 0)
                    }
                }
            }
            else {
                if UserDefaults.standard.integer(forKey: "DarkmodeStatus") == 1 {
                    doneAlert.backgroundColor = .black
                    let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.dark)
                    let blurEffectView = UIVisualEffectView(effect: blurEffect)
                    blurEffectView.frame = view.bounds
                    blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
                    doneAlert.insertSubview(blurEffectView, at: 0)
                }
                else if UserDefaults.standard.integer(forKey: "DarkmodeStatus") == 0 {
                    doneAlert.backgroundColor = .white
                    let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.extraLight)
                    let blurEffectView = UIVisualEffectView(effect: blurEffect)
                    blurEffectView.frame = view.bounds
                    blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
                    doneAlert.insertSubview(blurEffectView, at: 0)
                }
            }
            
            doneAlert.duration = 1
            doneAlert.present()
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                self.children.forEach { vc in
                    vc.dismiss(animated: false, completion: nil)
                }
                
                let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let settingsc = storyboard.instantiateViewController(withIdentifier: "launch") as! LaunchAnimationViewController
                self.present(settingsc, animated: false, completion: nil)
            }
        }
        else {
            EZAlertController.alert("Fehler", message: "Bitte wähle eine Farbe aus.")
        }
    }
    
    @objc func resetColors() {
        UserDefaults.standard.set("", forKey: "TitleBarColor")
        UserDefaults.standard.set("", forKey: "ButtonColor")
        
        let doneAlert = SPAlertView(title: "Zurückgesetzt", message: "Neustart wird durchgeführt...", preset: .done)
        
        for subview in doneAlert.subviews {
            if subview is UIVisualEffectView {
                subview.removeFromSuperview()
            }
        }
        
        /*   if UserDefaults.standard.integer(forKey: "DarkmodeStatus") == 1 {
             doneAlert.backgroundColor = .black
             let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.dark)
             let blurEffectView = UIVisualEffectView(effect: blurEffect)
             blurEffectView.frame = view.bounds
             blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
             doneAlert.insertSubview(blurEffectView, at: 0)
         }
         if UserDefaults.standard.integer(forKey: "DarkmodeStatus") == 0 {
             doneAlert.backgroundColor = .white
             let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.extraLight)
             let blurEffectView = UIVisualEffectView(effect: blurEffect)
             blurEffectView.frame = view.bounds
             blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
             doneAlert.insertSubview(blurEffectView, at: 0)
         }*/
        
        if UserDefaults.standard.integer(forKey: "AutoAppearance") == 1 {
            if #available(iOS 13.0, *) {
                if traitCollection.userInterfaceStyle == .dark {
                    doneAlert.backgroundColor = .black
                    let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.dark)
                    let blurEffectView = UIVisualEffectView(effect: blurEffect)
                    blurEffectView.frame = view.bounds
                    blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
                    doneAlert.insertSubview(blurEffectView, at: 0)
                }
                else if traitCollection.userInterfaceStyle == .light || traitCollection.userInterfaceStyle == .unspecified {
                    doneAlert.backgroundColor = .white
                    let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.extraLight)
                    let blurEffectView = UIVisualEffectView(effect: blurEffect)
                    blurEffectView.frame = view.bounds
                    blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
                    doneAlert.insertSubview(blurEffectView, at: 0)
                }
            }
        }
        else {
            if UserDefaults.standard.integer(forKey: "DarkmodeStatus") == 1 {
                doneAlert.backgroundColor = .black
                let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.dark)
                let blurEffectView = UIVisualEffectView(effect: blurEffect)
                blurEffectView.frame = view.bounds
                blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
                doneAlert.insertSubview(blurEffectView, at: 0)
            }
            else if UserDefaults.standard.integer(forKey: "DarkmodeStatus") == 0 {
                doneAlert.backgroundColor = .white
                let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.extraLight)
                let blurEffectView = UIVisualEffectView(effect: blurEffect)
                blurEffectView.frame = view.bounds
                blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
                doneAlert.insertSubview(blurEffectView, at: 0)
            }
        }
        
        doneAlert.duration = 1
        doneAlert.present()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            self.children.forEach { vc in
                vc.dismiss(animated: false, completion: nil)
            }
            
            let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let settingsc = storyboard.instantiateViewController(withIdentifier: "launch") as! LaunchAnimationViewController
            self.present(settingsc, animated: false, completion: nil)
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    func colorPickerView(_ colorPickerView: ColorPickerView, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func colorPickerView(_ colorPickerView: ColorPickerView, didSelectItemAt indexPath: IndexPath) {
        let colorTypeTitleBar = UserDefaults.standard.string(forKey: "TitleBarColor")
        let colorTypeButton = UserDefaults.standard.string(forKey: "ButtonColor")
        guard let path = Bundle.main.path(forResource: "colors", ofType: "json") else { return }
        let url = URL(fileURLWithPath: path)
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            if error != nil {
            }
            else {
                if let content = data {
                    do {
                        let jsonColor = try JSONSerialization.jsonObject(with: content, options: JSONSerialization.ReadingOptions.mutableContainers) as AnyObject
                        
                        if let colors = jsonColor["colors"] as? NSDictionary {
                            if let colorType = colors["\(colorPickerView.colors[indexPath.item])"] as? NSDictionary {
                                tempColorSave.red = colorType["red"]
                                tempColorSave.green = colorType["green"]
                                tempColorSave.blue = colorType["blue"]
                            }
                        }
                        else {}
                    }
                    catch {}
                }
                else {}
            }
        }
        task.resume()
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         // Get the new view controller using segue.destination.
         // Pass the selected object to the new view controller.
     }
     */
    
    struct tempColorSave {
        static var red: Any?
        static var green: Any?
        static var blue: Any?
    }
}
