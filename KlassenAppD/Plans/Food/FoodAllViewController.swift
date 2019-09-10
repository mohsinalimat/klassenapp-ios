//
//  FoodAllViewController.swift
//  KlassenAppD
//
//  Created by Adrian Baumgart on 25.05.19.
//  Copyright © 2019 Adrian Baumgart. All rights reserved.
//

import Firebase
import SPFakeBar
import UIKit

class FoodAllViewController: UIViewController {
    let navigationbar = SPFakeBarView(style: .stork)
    private var foodtextview: UITextView!
    
    var style = Appearances()
    
    override func viewDidLoad() {
        navigationbar.titleLabel.text = "Download..."
        navigationbar.titleLabel.font = navigationbar.titleLabel.font.withSize(23)
        navigationbar.height = 100
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
        
        foodtextview = UITextView(frame: CGRect(x: 8, y: 105, width: view.frame.width - 16, height: view.frame.height - 150))
        foodtextview.isEditable = false
        foodtextview.text = "Download..."
        foodtextview.font = .systemFont(ofSize: 16)
        
        view.addSubview(foodtextview)
        
        changeAppearance()
        reloadData()
    }
    
    func changeAppearance() {
        if UserDefaults.standard.integer(forKey: "AutoAppearance") == 1 {
            if #available(iOS 13.0, *) {
                if traitCollection.userInterfaceStyle == .dark {
                    view.backgroundColor = style.darkBackground
                    navigationbar.backgroundColor = style.darkTitleBackground
                    navigationbar.titleLabel.textColor = style.darkText
                    foodtextview.textColor = style.darkText
                    foodtextview.backgroundColor = style.darkBackground
                    setNeedsStatusBarAppearanceUpdate()
                }
                else if traitCollection.userInterfaceStyle == .light || traitCollection.userInterfaceStyle == .unspecified {
                    view.backgroundColor = style.lightBackground
                    navigationbar.backgroundColor = style.lightTitleBackground
                    navigationbar.titleLabel.textColor = style.lightText
                    foodtextview.textColor = style.lightText
                    foodtextview.backgroundColor = style.lightBackground
                    setNeedsStatusBarAppearanceUpdate()
                }
            }
        }
        else {
            if UserDefaults.standard.integer(forKey: "DarkmodeStatus") == 1 {
                view.backgroundColor = style.darkBackground
                navigationbar.backgroundColor = style.darkTitleBackground
                navigationbar.titleLabel.textColor = style.darkText
                foodtextview.textColor = style.darkText
                foodtextview.backgroundColor = style.darkBackground
                setNeedsStatusBarAppearanceUpdate()
            }
            else if UserDefaults.standard.integer(forKey: "DarkmodeStatus") == 0 {
                view.backgroundColor = style.lightBackground
                navigationbar.backgroundColor = style.lightTitleBackground
                navigationbar.titleLabel.textColor = style.lightText
                foodtextview.textColor = style.lightText
                foodtextview.backgroundColor = style.lightBackground
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
    }
    
    @objc func reloadData() {
        var ref: DatabaseReference!
        ref = Database.database().reference()
        
        ref.child("Speiseplan").child("Datum").observe(.value) { datesnap in
            let FoodDate = datesnap.value as! String
            self.navigationbar.titleLabel.text = "Speiseplan\n(\(FoodDate))"
        }
        
        ref.child("Speiseplan").child("monday").observe(.value) { mondayfood in
            FoodVC.monday = mondayfood.value as! String
            ref.child("Speiseplan").child("Tuesday").observe(.value) { tuesdayfood in
                FoodVC.tuesday = tuesdayfood.value as! String
                ref.child("Speiseplan").child("Wednesday").observe(.value) { wednesdayfood in
                    FoodVC.wednesday = wednesdayfood.value as! String
                    ref.child("Speiseplan").child("Thursday").observe(.value) { thursdayfood in
                        FoodVC.thursday = thursdayfood.value as! String
                        ref.child("Speiseplan").child("Friday").observe(.value) { fridayfood in
                            FoodVC.friday = fridayfood.value as! String
                            self.foodtextview.text = "Montag: \(FoodVC.monday)\n\nDienstag: \(FoodVC.tuesday)\n\nMittwoch: \(FoodVC.wednesday)\n\nDonnerstag: \(FoodVC.thursday)\n\nFreitag: \(FoodVC.friday)"
                        }
                    }
                }
            }
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    struct FoodVC {
        static var monday = ""
        static var tuesday = ""
        static var wednesday = ""
        static var thursday = ""
        static var friday = ""
    }
}
