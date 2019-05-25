//
//  InformationsViewController.swift
//  KlassenAppD
//
//  Created by Adrian Baumgart on 05.07.18.
//  Copyright © 2018 Adrian Baumgart. All rights reserved.
//

import UIKit

class InformationsViewController: UIViewController {

    @IBOutlet weak var InfoTitle: UILabel!
    @IBOutlet weak var InfoDes: UITextView!
    @IBAction func AcceptInfos(_ sender: Any)
    {
        /*if UserDefaults.standard.string(forKey: "ReadInfos") == "1"
        {
            UserDefaults.standard.set("1", forKey: "ReadInfos")
            FirstViewController.LastVC.LastVCV = "infos"
            
            if UserDefaults.standard.integer(forKey: "Checker") == 1 {
                 self.performSegue(withIdentifier: "infotosettings", sender: nil)
            }
            else if UserDefaults.standard.string(forKey: "TEALOGGER") == "tea" {
                FirstViewController.LastVC.LastVCV = "infos"
                self.performSegue(withIdentifier: "infototea", sender: nil)
            }
            
            else {
                 self.performSegue(withIdentifier: "ihavereadinfos", sender: nil)
            }
            
        }*/
            UserDefaults.standard.set("1", forKey: "ReadInfos")
            self.performSegue(withIdentifier: "ihavereadinfos", sender: nil)
        
    }
    @IBOutlet weak var AcceptInfosOut: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
         self.InfoDes.scrollRangeToVisible(NSMakeRange(0, 0))
        if UserDefaults.standard.integer(forKey: "DarkmodeStatus") == 1 {
            view.backgroundColor = UIColor(red:0.08, green:0.08, blue:0.08, alpha:1.0)
            InfoTitle.textColor = UIColor.white
            InfoDes.textColor = UIColor.white
            InfoDes.backgroundColor = UIColor(red:0.08, green:0.08, blue:0.08, alpha:1.0)
            self.setNeedsStatusBarAppearanceUpdate()
        }
        if UserDefaults.standard.integer(forKey: "DarkmodeStatus") == 0 {
            view.backgroundColor = UIColor.white
            InfoTitle.textColor = UIColor.black
            InfoDes.textColor = UIColor.black
            InfoDes.backgroundColor = UIColor.white
            self.setNeedsStatusBarAppearanceUpdate()
        }

        // Do any additional setup after loading the view.
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
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
    }
}
