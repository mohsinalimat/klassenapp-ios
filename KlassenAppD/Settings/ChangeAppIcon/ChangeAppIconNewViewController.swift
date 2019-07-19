//
//  ChangeAppIconNewViewController.swift
//  KlassenAppD
//
//  Created by Adrian Baumgart on 19.07.19.
//  Copyright © 2019 Adrian Baumgart. All rights reserved.
//

import SPFakeBar
import UIKit

@available(iOS 10.3, *)
class ChangeAppIconNewViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    let navigationbar = SPFakeBarView(style: .stork)
    
    var ImageTV: UITableView!
    
    var style = Appearances()
    
    var icons = [UIImage(named: "AppIconCurrentIco"), UIImage(named: "AppIconRedGoldIco"), UIImage(named: "AppIconGrayIco"), UIImage(named: "AppIconGoldIco"), UIImage(named: "AppIconGreenIco"), UIImage(named: "AppIconPinkIco"), UIImage(named: "AppIconBlueIco")]
    
    var numicon = ["1", "2", "3", "4", "5", "6", "7"]
    
    var allIcons: [SingleImage] = [SingleImage(Image: UIImage(named: "AppIconCurrentIco") ?? UIImage(named: "AppIconCurrentIco")!, Number: "1"), SingleImage(Image: UIImage(named: "AppIconRedGoldIco")!, Number: "2"), SingleImage(Image: UIImage(named: "AppIconGrayIco")!, Number: "3"), SingleImage(Image: UIImage(named: "AppIconGoldIco")!, Number: "4"), SingleImage(Image: UIImage(named: "AppIconGreenIco")!, Number: "5"), SingleImage(Image: UIImage(named: "AppIconPinkIco")!, Number: "6"), SingleImage(Image: UIImage(named: "AppIconBlueIco")!, Number: "7")]
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return icons.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "imagecell", for: indexPath)
        cell.imageView!.image = allIcons[indexPath.row].Image
        
        if UserDefaults.standard.integer(forKey: "DarkmodeStatus") == 1 {
            cell.backgroundColor = style.darkBackground
        }
        else if UserDefaults.standard.integer(forKey: "DarkmodeStatus") == 0 {
            cell.backgroundColor = style.lightBackground
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let number = allIcons[indexPath.row].Number
        
        print(number)
        
        if number == "1" {
            //    setAppIcon(selectedImage: "AppIconCurrentIco")
            changeIcon(to: nil)
        }
        else if number == "2" {
            //   setAppIcon(selectedImage: "AppIconRedGoldIco")
            changeIcon(to: "AppIconRedGoldIco")
        }
        else if number == "3" {
            //  setAppIcon(selectedImage: "AppIconGrayIco")
            changeIcon(to: "AppIconGrayIco")
        }
        else if number == "4" {
            // setAppIcon(selectedImage: "AppIconGoldIco")
            changeIcon(to: "AppIconGoldIco")
        }
        else if number == "5" {
            // setAppIcon(selectedImage: "AppIconGreenIco")
            changeIcon(to: "AppIconGreenIco")
        }
        else if number == "6" {
            // setAppIcon(selectedImage: "AppIconPinkIco")
            changeIcon(to: "AppIconPinkIco")
        }
        else if number == "7" {
            changeIcon(to: "AppIconBlueIco")
            /*    if #available(iOS 10.3, *) {
                 if UIApplication.shared.supportsAlternateIcons {
                 } else {
                     return
                 }
                 if let name = UIApplication.shared.alternateIconName {
                     UIApplication.shared.setAlternateIconName("AppIconBlueIco") { (_: Error?) in
                     }
                 }
             } else {}*/
        }
    }
    
    func changeIcon(to name: String?) {
        // Check if the app supports alternating icons
        guard UIApplication.shared.supportsAlternateIcons else {
            return
        }
        
        // Change the icon to a specific image with given name
        UIApplication.shared.setAlternateIconName(name) { error in
            // After app icon changed, print our error or success message
            if let error = error {
                print("App icon failed to due to \(error.localizedDescription)")
            }
            else {
                print("App icon changed successfully.")
            }
        }
    }
    
    func setAppIcon(selectedImage: String) {
        if #available(iOS 10.3, *) {
            if UIApplication.shared.supportsAlternateIcons {
            }
            else {
                return
            }
            if let name = UIApplication.shared.alternateIconName {
                UIApplication.shared.setAlternateIconName(selectedImage) { (_: Error?) in
                }
            }
        }
        else {}
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationbar.titleLabel.text = "Appicon ändern"
        navigationbar.titleLabel.font = navigationbar.titleLabel.font.withSize(23)
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
        
        ImageTV = UITableView(frame: CGRect(x: 8, y: 100, width: view.frame.width - 16, height: view.frame.height - 150))
        ImageTV.register(UITableViewCell.self, forCellReuseIdentifier: "imagecell")
        ImageTV.dataSource = self
        ImageTV.delegate = self
        view.addSubview(ImageTV!)
        
        if UserDefaults.standard.integer(forKey: "DarkmodeStatus") == 1 {
            view.backgroundColor = style.darkBackground
            navigationbar.backgroundColor = style.darkTitleBackground
            navigationbar.titleLabel.textColor = style.darkText
            ImageTV.backgroundColor = style.darkBackground
            setNeedsStatusBarAppearanceUpdate()
        }
        if UserDefaults.standard.integer(forKey: "DarkmodeStatus") == 0 {
            view.backgroundColor = style.lightBackground
            navigationbar.backgroundColor = style.lightTitleBackground
            navigationbar.titleLabel.textColor = style.lightText
            ImageTV.backgroundColor = style.lightBackground
            setNeedsStatusBarAppearanceUpdate()
        }
        ImageTV.allowsSelection = true
        ImageTV.rowHeight = 80
        // ImageTV.rowHeight = UITableView.automaticDimension
        
        // Do any additional setup after loading the view.
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    struct SingleImage {
        var Image: UIImage
        var Number: String
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
