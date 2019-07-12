//
//  ChangeIconViewController.swift
//  KlassenAppD
//
//  Created by Adrian Baumgart on 24.01.19.
//  Copyright © 2019 Adrian Baumgart. All rights reserved.
//

import UIKit

class ChangeIconViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet var TitleBar: UIView!
    @IBOutlet var TitleBackground: UIView!
    @IBOutlet var TItle: UILabel!
    @IBOutlet var InfoTV: UITableView!
    @IBAction func BackBtn(_ sender: Any) {
        HomeViewController.AutomaticMover.LastVisitedView = "settings"
        performSegue(withIdentifier: "backfromicon", sender: nil)
    }
    
    var icons = [UIImage(named: "AppIconCurrentIco"), UIImage(named: "AppIconRedGoldIco"), UIImage(named: "AppIconGrayIco"), UIImage(named: "AppIconGoldIco"), UIImage(named: "AppIconGreenIco"), UIImage(named: "AppIconPinkIco"), UIImage(named: "AppIconBlueIco")]
    
    var numicon = ["1", "2", "3", "4", "5", "6", "7"]
    override func viewDidLoad() {
        super.viewDidLoad()
        if UserDefaults.standard.string(forKey: "TitleBarColor") != nil, UserDefaults.standard.string(forKey: "TitleBarColor") != "" {
            TitleBar.backgroundColor = UIColor(red: CGFloat(UserDefaults.standard.integer(forKey: "TitleBarRed")) / 255, green: CGFloat(UserDefaults.standard.integer(forKey: "TitleBarGreen")) / 255, blue: CGFloat(UserDefaults.standard.integer(forKey: "TitleBarBlue")) / 255, alpha: 1)
        }
        if UserDefaults.standard.integer(forKey: "DarkmodeStatus") == 1 {
            view.backgroundColor = UIColor(red: 0.05, green: 0.05, blue: 0.05, alpha: 1.0)
            TitleBackground.backgroundColor = UIColor(red: 0.13, green: 0.13, blue: 0.13, alpha: 1.0)
            TItle.textColor = UIColor.white
            InfoTV.backgroundColor = UIColor(red: 0.05, green: 0.05, blue: 0.05, alpha: 1.0)
            setNeedsStatusBarAppearanceUpdate()
        }
        if UserDefaults.standard.integer(forKey: "DarkmodeStatus") == 0 {
            view.backgroundColor = UIColor.white
            TitleBackground.backgroundColor = UIColor(red: 0.95, green: 0.95, blue: 0.95, alpha: 1.0)
            TItle.textColor = UIColor.black
            InfoTV.backgroundColor = UIColor.white
            setNeedsStatusBarAppearanceUpdate()
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        var style: UIStatusBarStyle!
        if UserDefaults.standard.integer(forKey: "DarkmodeStatus") == 1 {
            style = .lightContent
        } else if UserDefaults.standard.integer(forKey: "DarkmodeStatus") == 0 {
            style = .default
        }
        return style
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80.0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return icons.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "iconcell", for: indexPath) as! ChangeAppIconTableViewCell
        cell.ImageCe.image = icons[indexPath.row]
        cell.NumberCell.text = numicon[indexPath.row]
        if UserDefaults.standard.integer(forKey: "DarkmodeStatus") == 1 {
            cell.backgroundColor = UIColor(red: 0.05, green: 0.05, blue: 0.05, alpha: 1.0)
            cell.NumberCell.textColor = UIColor.white
        }
        if UserDefaults.standard.integer(forKey: "DarkmodeStatus") == 0 {
            cell.backgroundColor = UIColor.white
            cell.NumberCell.textColor = UIColor.black
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! ChangeAppIconTableViewCell
        let cellnum = cell.NumberCell.text!
        if cellnum == "1" {
            if #available(iOS 10.3, *) {
                if UIApplication.shared.supportsAlternateIcons {
                } else {
                    return
                }
                if let name = UIApplication.shared.alternateIconName {
                    UIApplication.shared.setAlternateIconName(nil) { (_: Error?) in
                    }
                }
            } else {}
        } else if cellnum == "2" {
            if #available(iOS 10.3, *) {
                if UIApplication.shared.supportsAlternateIcons {
                } else {
                    return
                }
                UIApplication.shared.setAlternateIconName("AppIconRedGoldIco") { (_: Error?) in
                }
            } else {}
        } else if cellnum == "3" {
            if #available(iOS 10.3, *) {
                if UIApplication.shared.supportsAlternateIcons {
                } else {
                    return
                }
                UIApplication.shared.setAlternateIconName("AppIconGrayIco") { (_: Error?) in
                }
            } else {}
        } else if cellnum == "4" {
            if #available(iOS 10.3, *) {
                if UIApplication.shared.supportsAlternateIcons {
                } else {
                    return
                }
                UIApplication.shared.setAlternateIconName("AppIconGoldIco") { (_: Error?) in
                }
            } else {}
        } else if cellnum == "5" {
            if #available(iOS 10.3, *) {
                if UIApplication.shared.supportsAlternateIcons {
                } else {
                    return
                }
                UIApplication.shared.setAlternateIconName("AppIconGreenIco") { (_: Error?) in
                }
            } else {}
        } else if cellnum == "6" {
            if #available(iOS 10.3, *) {
                if UIApplication.shared.supportsAlternateIcons {
                } else {
                    return
                }
                UIApplication.shared.setAlternateIconName("AppIconPinkIco") { (_: Error?) in
                }
            } else {}
        } else if cellnum == "7" {
            if #available(iOS 10.3, *) {
                if UIApplication.shared.supportsAlternateIcons {
                } else {
                    return
                }
                UIApplication.shared.setAlternateIconName("AppIconBlueIco") { (_: Error?) in
                }
            } else {}
        }
    }
}
