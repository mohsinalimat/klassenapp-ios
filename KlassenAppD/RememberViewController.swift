//
//  RememberViewController.swift
//  KlassenAppD
//
//  Created by Adrian Baumgart on 27.09.18.
//  Copyright © 2018 Adrian Baumgart. All rights reserved.
//

import UIKit
import ExpandingMenu
import FirebaseAuth

class RememberViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var TitleBar: UIView!
    @IBOutlet weak var backgroundTitleView: UIView!
    @IBOutlet weak var TitleLabel: UILabel!
    
    var LIST: [String] = []
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return LIST.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "listcell"
        var cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier)
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
            self.TableViewRemember.reloadData()
            // handle delete (by removing the data from your array and updating the tableview)
        }
    }
    
    
    @IBOutlet weak var TableViewRemember: UITableView!
    
    @IBAction func AddBtn(_ sender: Any)
    {
        AddITEM(title: "Hinzufügen", message: "Gib hier etwas ein")
       // bulletinManager.showBulletin(above: self)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        if UserDefaults.standard.string(forKey: "TitleBarColor") != nil && UserDefaults.standard.string(forKey: "TitleBarColor") != "" {
            self.TitleBar.backgroundColor = UIColor(red: CGFloat(UserDefaults.standard.integer(forKey: "TitleBarRed"))/255, green: CGFloat(UserDefaults.standard.integer(forKey: "TitleBarGreen"))/255, blue: CGFloat(UserDefaults.standard.integer(forKey: "TitleBarBlue"))/255, alpha: 1)
        }
        let menuButtonSize: CGSize = CGSize(width: 64.0, height: 50.0)
        print(self.view.frame.height)
        let menuButton = ExpandingMenuButton(frame: CGRect(origin: CGPoint.zero, size: menuButtonSize), image: UIImage(named: "menulines")!, rotatedImage: UIImage(named: "menulines")!)
        menuButton.foldingAnimations = .all
        menuButton.menuItemMargin = 1
        if UserDefaults.standard.integer(forKey: "DarkmodeStatus") == 1 {
            menuButton.bottomViewColor = UIColor.darkGray
        }
        else if UserDefaults.standard.integer(forKey: "DarkmodeStatus") != 1 {
            menuButton.bottomViewColor = UIColor.darkGray
        }
        menuButton.center = CGPoint(x: self.view.bounds.width - 32.0, y: self.view.bounds.height - 30.0)
        view.addSubview(menuButton)
        //HomeWorkShortID
        let item00 = ExpandingMenuItem(size: menuButtonSize, title: "Home", image: UIImage(named: "homeicon")!, highlightedImage: UIImage(named: "homeicon")!, backgroundImage: UIImage(named: "homeicon"), backgroundHighlightedImage: UIImage(named: "homeicon")) { () -> Void in
            // Do some action
            //self.performSegue(withIdentifier: "hw2arbeiten", sender: nil)
            if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "homeID") as? HomeViewController
            {
                self.present(vc, animated: true, completion: nil)
            }
            print("btn1")
        }
        let item0 = ExpandingMenuItem(size: menuButtonSize, title: "Hausaufgaben", image: UIImage(named: "book")!, highlightedImage: UIImage(named: "book")!, backgroundImage: UIImage(named: "book"), backgroundHighlightedImage: UIImage(named: "book")) { () -> Void in
            // Do some action
            //self.performSegue(withIdentifier: "hw2arbeiten", sender: nil)
            if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "HomeWorkShortID") as? FirstViewController
            {
                self.present(vc, animated: true, completion: nil)
            }
            print("btn1")
        }
        let item1 = ExpandingMenuItem(size: menuButtonSize, title: "Arbeiten", image: UIImage(named: "ball_point_pen")!, highlightedImage: UIImage(named: "ball_point_pen")!, backgroundImage: UIImage(named: "ball_point_pen"), backgroundHighlightedImage: UIImage(named: "ball_point_pen")) { () -> Void in
            // Do some action
            //self.performSegue(withIdentifier: "hw2arbeiten", sender: nil)
            if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TestsShortID") as? SecondViewController
            {
                self.present(vc, animated: true, completion: nil)
            }
            print("btn1")
        }
        let item2 = ExpandingMenuItem(size: menuButtonSize, title: "Hausaufgaben bis morgen", image: UIImage(named: "clock")!, highlightedImage: UIImage(named: "clock")!, backgroundImage: UIImage(named: "clock"), backgroundHighlightedImage: UIImage(named: "clock")) { () -> Void in
            // Do some action
            if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "habmID") as? HABMViewController
            {
                self.present(vc, animated: true, completion: nil)
            }
            print("btn2")
        }
        let item3 = ExpandingMenuItem(size: menuButtonSize, title: "Neuigkeiten", image: UIImage(named: "news")!, highlightedImage: UIImage(named: "news")!, backgroundImage: UIImage(named: "news"), backgroundHighlightedImage: UIImage(named: "news")) { () -> Void in
            // Do some action
            if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "newsID") as? NewsViewController
            {
                self.present(vc, animated: true, completion: nil)
            }
            print("btn3")
        }
        let item4 = ExpandingMenuItem(size: menuButtonSize, title: "Einstellungen", image: UIImage(named: "settings")!, highlightedImage: UIImage(named: "settings")!, backgroundImage: UIImage(named: "settings"), backgroundHighlightedImage: UIImage(named: "settings")) { () -> Void in
            // Do some action
            if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "settingsID") as? SettingsViewController
            {
                self.present(vc, animated: true, completion: nil)
            }
            print("btn4")
        }
        let item5 = ExpandingMenuItem(size: menuButtonSize, title: "Speiseplan", image: UIImage(named: "icons8-restaurant-filled-50")!, highlightedImage: UIImage(named: "icons8-restaurant-filled-50")!, backgroundImage: UIImage(named: "icons8-restaurant-filled-50"), backgroundHighlightedImage: UIImage(named: "icons8-restaurant-filled-50")) { () -> Void in
            // Do some action
            if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "FOODID") as? FoodViewController
            {
                self.present(vc, animated: true, completion: nil)
            }
            print("btn5")
        }
        let item6 = ExpandingMenuItem(size: menuButtonSize, title: "Stundenplan", image: UIImage(named: "icon_menu")!, highlightedImage: UIImage(named: "icon_menu")!, backgroundImage: UIImage(named: "icon_menu"), backgroundHighlightedImage: UIImage(named: "icon_menu")) { () -> Void in
            // Do some action
            if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "planID") as? TimeTableViewController
            {
                self.present(vc, animated: true, completion: nil)
            }
            print("btn6")
        }
        let item9 = ExpandingMenuItem(size: menuButtonSize, title: "Liste", image: UIImage(named: "checked")!, highlightedImage: UIImage(named: "checked")!, backgroundImage: UIImage(named: "checked"), backgroundHighlightedImage: UIImage(named: "checked")) { () -> Void in
            if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "rememberID") as? RememberViewController
            {
                self.present(vc, animated: true, completion: nil)
            }
            // Do some action
            print("btn8")
        }
        
        
        if Auth.auth().currentUser != nil {
            menuButton.addMenuItems([item00, item0, item1, item2, item3, item4, item5, item6])
        }
        else {
            menuButton.addMenuItems([item00, item0, item1, item2, item3, item4, item5, item6])
        }
        if UserDefaults.standard.integer(forKey: "DarkmodeStatus") == 1 {
            view.backgroundColor = UIColor(red:0.05, green:0.05, blue:0.05, alpha:1.0)
            backgroundTitleView.backgroundColor = UIColor(red:0.13, green:0.13, blue:0.13, alpha:1.0)
            TitleLabel.textColor = UIColor.white
            TableViewRemember.backgroundColor = UIColor(red:0.05, green:0.05, blue:0.05, alpha:1.0)
            // ChatMSGTF.tintColor = UIColor.white
            UIApplication.shared.statusBarStyle = .lightContent
        }
        if UserDefaults.standard.integer(forKey: "DarkmodeStatus") == 0 {
            view.backgroundColor = UIColor.white
            backgroundTitleView.backgroundColor = UIColor(red:0.97, green:0.97, blue:0.97, alpha:0.8)
            TitleLabel.textColor = UIColor.black
            TableViewRemember.backgroundColor = UIColor.white
            // ChatMSGTF.tintColor = UIColor.black
            UIApplication.shared.statusBarStyle = .default
        }
        LIST.removeAll()
        LIST = (UserDefaults.standard.stringArray(forKey: "RememberList"))  ?? [String]()
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
                var enteredText = theTextFields[0].text
                if enteredText != "" {
                    self.LIST.append(enteredText ?? "")
                    UserDefaults.standard.set(self.LIST, forKey: "RememberList")
                  //  print(self.LIST)
                    self.TableViewRemember.reloadData()
                    
                    
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


