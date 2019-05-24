//
//  ChangeIconViewController.swift
//  KlassenAppD
//
//  Created by Adrian Baumgart on 24.01.19.
//  Copyright © 2019 Adrian Baumgart. All rights reserved.
//

import UIKit

class ChangeIconViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var TitleBar: UIView!
    @IBOutlet weak var TitleBackground: UIView!
    @IBOutlet weak var TItle: UILabel!
    @IBOutlet weak var InfoTV: UITableView!
    @IBAction func BackBtn(_ sender: Any)
    {
        FirstViewController.LastVC.LastVCV = "settings"
        self.performSegue(withIdentifier: "backfromicon", sender: nil)
    }
    // var icons:[String] = ["AppIcon", "AppIconGray", "AppIconGold", "AppIconGreen", "AppIconPink"]
    
    var icons = [UIImage(named: "AppIconCurrentIco"),UIImage(named: "AppIconRedGoldIco"),UIImage(named: "AppIconGrayIco"),UIImage(named: "AppIconGoldIco"),UIImage(named: "AppIconGreenIco"),UIImage(named: "AppIconPinkIco"),UIImage(named: "AppIconBlueIco")]
    
    var numicon = ["1", "2", "3", "4", "5", "6", "7"]
    override func viewDidLoad() {
        super.viewDidLoad()
        if UserDefaults.standard.string(forKey: "TitleBarColor") != nil && UserDefaults.standard.string(forKey: "TitleBarColor") != "" {
            self.TitleBar.backgroundColor = UIColor(red: CGFloat(UserDefaults.standard.integer(forKey: "TitleBarRed"))/255, green: CGFloat(UserDefaults.standard.integer(forKey: "TitleBarGreen"))/255, blue: CGFloat(UserDefaults.standard.integer(forKey: "TitleBarBlue"))/255, alpha: 1)
        }
        if UserDefaults.standard.integer(forKey: "DarkmodeStatus") == 1 {
            view.backgroundColor = UIColor(red:0.05, green:0.05, blue:0.05, alpha:1.0)
            TitleBackground.backgroundColor = UIColor(red:0.13, green:0.13, blue:0.13, alpha:1.0)
            TItle.textColor = UIColor.white
            InfoTV.backgroundColor = UIColor(red:0.05, green:0.05, blue:0.05, alpha:1.0)
            UIApplication.shared.statusBarStyle = .lightContent
        }
        if UserDefaults.standard.integer(forKey: "DarkmodeStatus") == 0 {
            view.backgroundColor = UIColor.white
            TitleBackground.backgroundColor = UIColor(red:0.95, green:0.95, blue:0.95, alpha:1.0)
            TItle.textColor = UIColor.black
            InfoTV.backgroundColor = UIColor.white
            UIApplication.shared.statusBarStyle = .default
        }
       //  self.tableView.rowHeight = 80.0
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 80.0;//Choose your custom row height
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return icons.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "iconcell", for: indexPath) as! ChangeAppIconTableViewCell
        //var image : UIImage = UIImage(named: icons[indexPath.row])!
       // var image : UIImage = icons[indexPath.row]!
        cell.ImageCe.image = icons[indexPath.row]
        cell.NumberCell.text = numicon[indexPath.row]
        if UserDefaults.standard.integer(forKey: "DarkmodeStatus") == 1 {
            cell.backgroundColor = UIColor(red:0.05, green:0.05, blue:0.05, alpha:1.0)
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
        print(cellnum)
        if cellnum == "1" {
            if #available(iOS 10.3, *) {
                if UIApplication.shared.supportsAlternateIcons {
                    print("you can change this app's icon")
                }else {
                    print("you cannot change this app's icon")
                    return
                }
                if let name = UIApplication.shared.alternateIconName {
                    // CHANGE TO PRIMARY ICON
                    UIApplication.shared.setAlternateIconName(nil) { (err:Error?) in
                        print("set icon error：\(String(describing: err))")
                    }
                    print("the alternate icon's name is \(name)")
                }
            } else {
                // Fallback on earlier versions
            }
        }
            //AppIconRedGoldIco
        else if cellnum == "2" {
            if #available(iOS 10.3, *) {
                if UIApplication.shared.supportsAlternateIcons {
                    print("you can change this app's icon")
                }else {
                    print("you cannot change this app's icon")
                    return
                }
                UIApplication.shared.setAlternateIconName("AppIconRedGoldIco") { (err:Error?) in
                    print("set icon error：\(String(describing: err))")
                }
            } else {
                // Fallback on earlier versions
            }
        }
        else if cellnum == "3" {
            if #available(iOS 10.3, *) {
                if UIApplication.shared.supportsAlternateIcons {
                    print("you can change this app's icon")
                }else {
                    print("you cannot change this app's icon")
                    return
                }
                UIApplication.shared.setAlternateIconName("AppIconGrayIco") { (err:Error?) in
                    print("set icon error：\(String(describing: err))")
                }
            } else {
                // Fallback on earlier versions
            }
        }
        else if cellnum == "4" {
            if #available(iOS 10.3, *) {
                if UIApplication.shared.supportsAlternateIcons {
                    print("you can change this app's icon")
                }else {
                    print("you cannot change this app's icon")
                    return
                }
                UIApplication.shared.setAlternateIconName("AppIconGoldIco") { (err:Error?) in
                    print("set icon error：\(String(describing: err))")
                }
            } else {
                // Fallback on earlier versions
            }
        }
        else if cellnum == "5" {
            if #available(iOS 10.3, *) {
                if UIApplication.shared.supportsAlternateIcons {
                    print("you can change this app's icon")
                }else {
                    print("you cannot change this app's icon")
                    return
                }
                UIApplication.shared.setAlternateIconName("AppIconGreenIco") { (err:Error?) in
                    print("set icon error：\(String(describing: err))")
                }
            } else {
                // Fallback on earlier versions
            }
        }
        else if cellnum == "6" {
            if #available(iOS 10.3, *) {
                if UIApplication.shared.supportsAlternateIcons {
                    print("you can change this app's icon")
                }else {
                    print("you cannot change this app's icon")
                    return
                }
                UIApplication.shared.setAlternateIconName("AppIconPinkIco") { (err:Error?) in
                    print("set icon error：\(String(describing: err))")
                }
            } else {
                // Fallback on earlier versions
            }
        }
        else if cellnum == "7" {
            if #available(iOS 10.3, *) {
                if UIApplication.shared.supportsAlternateIcons {
                    print("you can change this app's icon")
                }else {
                    print("you cannot change this app's icon")
                    return
                }
                UIApplication.shared.setAlternateIconName("AppIconBlueIco") { (err:Error?) in
                    print("set icon error：\(String(describing: err))")
                }
            } else {
                // Fallback on earlier versions
            }
        }
    }

    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
}
