//
//  RememberViewController.swift
//  KlassenAppD
//
//  Created by Adrian Baumgart on 27.09.18.
//  Copyright © 2018 Adrian Baumgart. All rights reserved.
//

import SPFakeBar
import UIKit

class RememberViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    let navigationbar = SPFakeBarView(style: .stork)
    private var TableViewRemember: UITableView!
    
    var LIST: [String] = []
    
    var style = Appearances()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return LIST.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "listcell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier)
        cell?.textLabel?.numberOfLines = 0
        cell?.textLabel?.lineBreakMode = .byTruncatingTail
        
        if UserDefaults.standard.integer(forKey: "ManualAppearance") == 0 {
                   if #available(iOS 13.0, *) {
                       if traitCollection.userInterfaceStyle == .dark {
                        cell!.textLabel!.textColor = style.darkText
                        cell!.backgroundColor = style.darkBackground
                       }
                       else if traitCollection.userInterfaceStyle == .light || traitCollection.userInterfaceStyle == .unspecified {
                          cell!.textLabel!.textColor = style.lightText
                          cell!.backgroundColor = style.lightBackground
                       }
                   }
               }
               else {
                   if UserDefaults.standard.integer(forKey: "DarkmodeStatus") == 1 {
                       cell!.textLabel!.textColor = style.darkText
                       cell!.backgroundColor = style.darkBackground
                   }
                   else if UserDefaults.standard.integer(forKey: "DarkmodeStatus") == 0 {
                       cell!.textLabel!.textColor = style.lightText
                       cell!.backgroundColor = style.lightBackground
                   }
               }
        
        
        cell!.textLabel?.text = LIST[indexPath.row]
        return cell!
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            LIST.remove(at: indexPath.row)
            UserDefaults.standard.set(LIST, forKey: "RememberList")
            TableViewRemember!.reloadData()
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    @objc func addItemFunction() {
        AddITEM(title: "Hinzufügen", message: "Gib hier etwas ein")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationbar.titleLabel.text = "Liste"
        navigationbar.titleLabel.font = navigationbar.titleLabel.font.withSize(23)
        navigationbar.height = 95
        navigationbar.titleLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
        navigationbar.titleLabel.numberOfLines = 3
        navigationbar.rightButton.setTitle("+", for: .normal)
        navigationbar.rightButton.titleLabel?.font = .boldSystemFont(ofSize: 30)
        navigationbar.rightButton.addTarget(self, action: #selector(addItemFunction), for: .touchUpInside)
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
        
        TableViewRemember = UITableView(frame: CGRect(x: 8, y: 100, width: view.frame.width - 16, height: view.frame.height - 150))
        TableViewRemember.register(UITableViewCell.self, forCellReuseIdentifier: "listcell")
        TableViewRemember.dataSource = self
        TableViewRemember.delegate = self
        view.addSubview(TableViewRemember!)
        
        LIST.removeAll()
        LIST = UserDefaults.standard.stringArray(forKey: "RememberList") ?? [String]()
        
       /* if UserDefaults.standard.integer(forKey: "DarkmodeStatus") == 1 {
            view.backgroundColor = style.darkBackground
            navigationbar.backgroundColor = style.darkTitleBackground
            navigationbar.titleLabel.textColor = style.darkText
            TableViewRemember!.backgroundColor = style.darkBackground
            setNeedsStatusBarAppearanceUpdate()
        }
        if UserDefaults.standard.integer(forKey: "DarkmodeStatus") == 0 {
            view.backgroundColor = style.lightBackground
            navigationbar.backgroundColor = style.lightTitleBackground
            navigationbar.titleLabel.textColor = style.lightText
            TableViewRemember!.backgroundColor = style.lightBackground
            setNeedsStatusBarAppearanceUpdate()
        }*/
        changeAppearance()
    }
    
    func changeAppearance() {
           if UserDefaults.standard.integer(forKey: "ManualAppearance") == 0 {
               if #available(iOS 13.0, *) {
                   if traitCollection.userInterfaceStyle == .dark {
                    view.backgroundColor = style.darkBackground
                    navigationbar.backgroundColor = style.darkTitleBackground
                    navigationbar.titleLabel.textColor = style.darkText
                    TableViewRemember!.backgroundColor = style.darkBackground
                    setNeedsStatusBarAppearanceUpdate()
                   }
                   else if traitCollection.userInterfaceStyle == .light || traitCollection.userInterfaceStyle == .unspecified {
                      view.backgroundColor = style.lightBackground
                      navigationbar.backgroundColor = style.lightTitleBackground
                      navigationbar.titleLabel.textColor = style.lightText
                      TableViewRemember!.backgroundColor = style.lightBackground
                      setNeedsStatusBarAppearanceUpdate()
                   }
               }
           }
           else {
               if UserDefaults.standard.integer(forKey: "DarkmodeStatus") == 1 {
                   view.backgroundColor = style.darkBackground
                   navigationbar.backgroundColor = style.darkTitleBackground
                   navigationbar.titleLabel.textColor = style.darkText
                   TableViewRemember!.backgroundColor = style.darkBackground
                   setNeedsStatusBarAppearanceUpdate()
               }
               else if UserDefaults.standard.integer(forKey: "DarkmodeStatus") == 0 {
                   view.backgroundColor = style.lightBackground
                   navigationbar.backgroundColor = style.lightTitleBackground
                   navigationbar.titleLabel.textColor = style.lightText
                   TableViewRemember!.backgroundColor = style.lightBackground
                   setNeedsStatusBarAppearanceUpdate()
               }
           }
       }
       
       override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
           super.traitCollectionDidChange(previousTraitCollection)
           
           if #available(iOS 12.0, *) {
               
               if UserDefaults.standard.integer(forKey: "ManualAppearance") == 0 {
                       self.changeAppearance()
                   self.setNeedsStatusBarAppearanceUpdate()
                TableViewRemember.reloadData()
               }
               
           } else {
               // Fallback on earlier versions
           }
           
           
       }
    
    override func viewDidAppear(_ animated: Bool) {}
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func AddITEM(title: String, message: String) {
        let AI = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        AI.addTextField(
            configurationHandler: { (textField: UITextField!) in
                textField.placeholder = "Neu"
        })
        AI.addAction(UIAlertAction(title: "Hinzufügen", style: UIAlertAction.Style.default, handler: { _ in
            if let textFields = AI.textFields {
                let theTextFields = textFields as [UITextField]
                let enteredText = theTextFields[0].text
                if enteredText != "" {
                    self.LIST.append(enteredText ?? "")
                    UserDefaults.standard.set(self.LIST, forKey: "RememberList")
                    self.TableViewRemember!.reloadData()
                    AI.dismiss(animated: true, completion: nil)
                }
            }
            
        }))
        AI.addAction(UIAlertAction(title: "Abbrechen", style: UIAlertAction.Style.default, handler: { _ in
            AI.dismiss(animated: true, completion: nil)
        }))
        present(AI, animated: true, completion: nil)
    }
}
