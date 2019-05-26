//
//  RememberViewController.swift
//  KlassenAppD
//
//  Created by Adrian Baumgart on 27.09.18.
//  Copyright © 2018 Adrian Baumgart. All rights reserved.
//

import UIKit
import SPFakeBar

class RememberViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let navigationbar = SPFakeBarView(style: .stork)
    private var TableViewRemember: UITableView!
    //@IBOutlet weak var TableViewRemember: UITableView!
    
    var LIST: [String] = []
    
    @IBAction func BackBtn(_ sender: Any)
    {
        FirstViewController.LastVC.LastVCV = "plans"
        self.performSegue(withIdentifier: "backfromlist", sender: nil)
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return LIST.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "listcell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier)
        cell?.textLabel?.numberOfLines = 0
        cell?.textLabel?.lineBreakMode = .byTruncatingTail
        if UserDefaults.standard.integer(forKey: "DarkmodeStatus") == 1 {
            cell!.textLabel!.textColor = UIColor.white
            cell!.backgroundColor = UIColor(red:0.05, green:0.05, blue:0.05, alpha:1.0)
        }
        if UserDefaults.standard.integer(forKey: "DarkmodeStatus") == 0 {
            cell!.textLabel!.textColor = UIColor.black
            cell!.backgroundColor = UIColor.white
        }
        //if itemNames.count != 0 {
        // let cell = UITableViewCell(style: .default, reuseIdentifier: "listcell")
        cell!.textLabel?.text = LIST[indexPath.row]
        // }
        return cell!
    }
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            LIST.remove(at: indexPath.row)
            UserDefaults.standard.set(self.LIST, forKey: "RememberList")
            //  print(self.LIST)
            self.TableViewRemember!.reloadData()
            // handle delete (by removing the data from your array and updating the tableview)
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    @objc func addItemFunction()
    {
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
        self.view.addSubview(navigationbar)
        for subview in navigationbar.subviews {
            if subview is UIVisualEffectView {
                subview.removeFromSuperview()
            }
        }
        
        let titlebar = UIView(frame: CGRect(x: 0, y: navigationbar.height - 1, width: self.view.frame.width, height: 3))
        titlebar.backgroundColor = UIColor(red:0.61, green:0.32, blue:0.88, alpha:1.0)
        
        if UserDefaults.standard.string(forKey: "TitleBarColor") != nil && UserDefaults.standard.string(forKey: "TitleBarColor") != "" {
            titlebar.backgroundColor = UIColor(red: CGFloat(UserDefaults.standard.integer(forKey: "TitleBarRed"))/255, green: CGFloat(UserDefaults.standard.integer(forKey: "TitleBarGreen"))/255, blue: CGFloat(UserDefaults.standard.integer(forKey: "TitleBarBlue"))/255, alpha: 1)
        }
        self.view.addSubview(titlebar)
        
        TableViewRemember = UITableView(frame: CGRect(x: 8, y: 100, width: self.view.frame.width - 16, height: self.view.frame.height - 150))
        TableViewRemember.register(UITableViewCell.self, forCellReuseIdentifier: "listcell")
        TableViewRemember.dataSource = self
        TableViewRemember.delegate = self
        self.view.addSubview(TableViewRemember!)
        
        LIST.removeAll()
        LIST = (UserDefaults.standard.stringArray(forKey: "RememberList"))  ?? [String]()
        
        if UserDefaults.standard.integer(forKey: "DarkmodeStatus") == 1 {
            view.backgroundColor = UIColor(red:0.05, green:0.05, blue:0.05, alpha:1.0)
            navigationbar.backgroundColor = UIColor(red:0.13, green:0.13, blue:0.13, alpha:1.0)
            navigationbar.titleLabel.textColor = .white
            TableViewRemember!.backgroundColor = UIColor(red:0.05, green:0.05, blue:0.05, alpha:1.0)
            // ChatMSGTF.tintColor = UIColor.white
            self.setNeedsStatusBarAppearanceUpdate()
        }
        if UserDefaults.standard.integer(forKey: "DarkmodeStatus") == 0 {
            view.backgroundColor = UIColor.white
            navigationbar.backgroundColor = UIColor(red:0.95, green:0.95, blue:0.95, alpha:1.0)
            navigationbar.titleLabel.textColor = .black
            TableViewRemember!.backgroundColor = UIColor.white
            // ChatMSGTF.tintColor = UIColor.black
            self.setNeedsStatusBarAppearanceUpdate()
        }
        
    }
    
    
    
    override func viewDidAppear(_ animated: Bool) {

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    
    func AddITEM (title: String, message: String) { //Adds a item
        let AI = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        AI.addTextField(
            configurationHandler: {(textField: UITextField!) in
                textField.placeholder = "Neu"
        })
        AI.addAction(UIAlertAction(title: "Hinzufügen", style: UIAlertAction.Style.default, handler: { (AIAdd) in //Adds new item to list
            if let textFields = AI.textFields {
                let theTextFields = textFields as [UITextField]
                let enteredText = theTextFields[0].text
                if enteredText != "" {
                    self.LIST.append(enteredText ?? "")
                    UserDefaults.standard.set(self.LIST, forKey: "RememberList")
                  //  print(self.LIST)
                    self.TableViewRemember!.reloadData()
                    
                    print(self.LIST)
                    AI.dismiss(animated: true, completion: nil)
                }
            }
            
        }))
        AI.addAction(UIAlertAction(title: "Abbrechen", style: UIAlertAction.Style.default, handler: { (AIdismiss) in //Cancel action and dismiss alert
            AI.dismiss(animated: true, completion: nil)
        }))
        self.present(AI, animated: true, completion: nil)
    }
    

}


