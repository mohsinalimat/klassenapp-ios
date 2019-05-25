//
//  ChangeColorPickerViewController.swift
//  KlassenAppD
//
//  Created by Adrian Baumgart on 14.04.19.
//  Copyright © 2019 Adrian Baumgart. All rights reserved.
//

import UIKit
import IGColorPicker

class ChangeColorPickerViewController: UIViewController, ColorPickerViewDelegate, ColorPickerViewDelegateFlowLayout {

    @IBOutlet weak var SelectedColorLabel: UILabel!
    @IBOutlet weak var selectedColorView: UIView!
    @IBOutlet weak var BackgroundTitleView: UIView!
    @IBOutlet weak var ColorSelectorLabel: UILabel!
    @IBOutlet weak var TitleBar: UIView!
    
    @IBOutlet weak var ColorPicker: ColorPickerView!
    override func viewDidLoad() {
        super.viewDidLoad()
        if UserDefaults.standard.integer(forKey: "DarkmodeStatus") == 1 {
            view.backgroundColor = UIColor(red:0.05, green:0.05, blue:0.05, alpha:1.0)
            BackgroundTitleView.backgroundColor = UIColor(red:0.13, green:0.13, blue:0.13, alpha:1.0)
            SelectedColorLabel.textColor = UIColor.white
            ColorSelectorLabel.textColor = UIColor.white
            ColorPicker.backgroundColor = UIColor(red:0.05, green:0.05, blue:0.05, alpha:1.0)
            // TouchIDLabel.textColor = UIColor.white
            self.setNeedsStatusBarAppearanceUpdate()
        }
        if UserDefaults.standard.integer(forKey: "DarkmodeStatus") == 0 {
            view.backgroundColor = UIColor.white
            BackgroundTitleView.backgroundColor = UIColor(red:0.95, green:0.95, blue:0.95, alpha:1.0)
            SelectedColorLabel.textColor = UIColor.black
            ColorSelectorLabel.textColor = UIColor.black
            ColorPicker.backgroundColor = UIColor.white
            self.setNeedsStatusBarAppearanceUpdate()
            
        }
        if UserDefaults.standard.string(forKey: "TitleBarColor") != nil && UserDefaults.standard.string(forKey: "TitleBarColor") != "" {
            self.TitleBar.backgroundColor = UIColor(red: CGFloat(UserDefaults.standard.integer(forKey: "TitleBarRed"))/255, green: CGFloat(UserDefaults.standard.integer(forKey: "TitleBarGreen"))/255, blue: CGFloat(UserDefaults.standard.integer(forKey: "TitleBarBlue"))/255, alpha: 1)
        }
        ColorPicker.layoutDelegate = self
        ColorPicker.delegate = self
        ColorPicker.layoutDelegate = self
        ColorPicker.style = .circle
        ColorPicker.selectionStyle = .check
        ColorPicker.isSelectedColorTappable = false
        selectedColorView.layer.cornerRadius = selectedColorView.frame.width/2
        if UserDefaults.standard.string(forKey: "ColorChangeObject") == "TitleBar" {
            SelectedColorLabel.text = "Farbe für Titelleisten:"
        }
        else if UserDefaults.standard.string(forKey: "ColorChangeObject") == "Button" {
            SelectedColorLabel.text = "Farbe für Knöpfe:"
        }
        // Do any additional setup after loading the view.
    }
    
    func colorPickerView(_ colorPickerView: ColorPickerView, didSelectItemAt indexPath: IndexPath) {
        print("Selected color: \(colorPickerView.colors[indexPath.item])")
        //Colors in UIColor:
        //0,0: r: 255 g: 138 b: 128 a: 1
        self.selectedColorView.backgroundColor = colorPickerView.colors[indexPath.item]
        if UserDefaults.standard.string(forKey: "ColorChangeObject") == "TitleBar" {
            UserDefaults.standard.set("\(colorPickerView.colors[indexPath.item])", forKey: "TitleBarColor")
            //UserDefaults.standard.set("\(self.selectedColorView.backgroundColor!)", forKey: "TitleBarColor")
        }
        else if UserDefaults.standard.string(forKey: "ColorChangeObject") == "Button" {
            UserDefaults.standard.set("\(colorPickerView.colors[indexPath.item])", forKey: "ButtonColor")
        }
        let colorTypeTitleBar = UserDefaults.standard.string(forKey: "TitleBarColor")
        let colorTypeButton = UserDefaults.standard.string(forKey: "ButtonColor")
        guard let path = Bundle.main.path(forResource: "colors", ofType: "json") else { return }
        let url = URL(fileURLWithPath: path)
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if error != nil {
                print("ERROR JSON!")
            }
            else {
                if let content = data {
                    do {
                        let jsonColor = try JSONSerialization.jsonObject(with: content, options: JSONSerialization.ReadingOptions.mutableContainers) as AnyObject
                        
                        if let colors = jsonColor["colors"] as? NSDictionary {
                            if UserDefaults.standard.string(forKey: "TitleBarColor") != nil && UserDefaults.standard.string(forKey: "TitleBarColor") != "" {
                                if let colorType = colors[colorTypeTitleBar!] as? NSDictionary {
                                    UserDefaults.standard.set(colorType["red"], forKey: "TitleBarRed")
                                    UserDefaults.standard.set(colorType["green"], forKey: "TitleBarGreen")
                                    UserDefaults.standard.set(colorType["blue"], forKey: "TitleBarBlue")
                                    /*CustomColors.tbred = colorType["red"] as! Int
                                    CustomColors.tbgreen = colorType["green"] as! Int
                                    CustomColors.tbblue = colorType["blue"] as! Int*/
                                    //self.TitleBarOut.backgroundColor = UIColor(red: CGFloat(colorTypeRed), green: CGFloat(colorTypeGreen), blue: CGFloat(colorTypeBlue), alpha: 1)
                                }
                            }
                            if UserDefaults.standard.string(forKey: "ButtonColor") != nil && UserDefaults.standard.string(forKey: "ButtonColor") != "" {
                                if let colorType = colors[colorTypeButton!] as? NSDictionary {
                                    UserDefaults.standard.set(colorType["red"], forKey: "ButtonRed")
                                    UserDefaults.standard.set(colorType["green"], forKey: "ButtonGreen")
                                    UserDefaults.standard.set(colorType["blue"], forKey: "ButtonBlue")
                                   /* CustomColors.bred = colorType["red"] as! Int
                                    CustomColors.bgreen = colorType["green"] as! Int
                                    CustomColors.bblue = colorType["blue"] as! Int*/
                                    //self.TitleBarOut.backgroundColor = UIColor(red: CGFloat(colorTypeRed), green: CGFloat(colorTypeGreen), blue: CGFloat(colorTypeBlue), alpha: 1)
                                }
                            }
                        }
                    }
                    catch {
                        
                    }
                }
            }
        }
        task.resume()
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
    
    /* func colorPickerView(_ colorPickerView: ColorPickerView, sizeForItemAt indexPath: IndexPath) -> CGSize {
     // The size for each cell
     // 👉🏻 WIDTH AND HEIGHT MUST BE EQUALS!
     return CGSize(width: 50, height: 50)
     }*/
    
    func colorPickerView(_ colorPickerView: ColorPickerView, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        // Space between cells
        return 10
        
    }
    
    /*func colorPickerView(_ colorPickerView: ColorPickerView, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
     // Space between rows
     }
     
     func colorPickerView(_ colorPickerView: ColorPickerView, insetForSectionAt section: Int) -> UIEdgeInsets {
     // Inset used aroud the view
     }*/
    
}
