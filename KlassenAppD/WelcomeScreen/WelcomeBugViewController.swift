//
//  WelcomeBugViewController.swift
//  KlassenAppD
//
//  Created by Adrian Baumgart on 29.08.18.
//  Copyright © 2018 Adrian Baumgart. All rights reserved.
//

import UIKit

class WelcomeBugViewController: UIViewController {

    @IBOutlet weak var EvenMoreInformations: UILabel!
    @IBOutlet weak var EvenMoreInformationsNote1: UITextView!
    @IBOutlet weak var EvenMoreInformationsNote2: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        if UserDefaults.standard.integer(forKey: "DarkmodeStatus") == 1 {
            view.backgroundColor = UIColor(red:0.05, green:0.05, blue:0.05, alpha:1.0)
            EvenMoreInformations.textColor = UIColor.white
            EvenMoreInformationsNote1.textColor = UIColor.white
            EvenMoreInformationsNote1.backgroundColor = UIColor(red:0.05, green:0.05, blue:0.05, alpha:1.0)
            EvenMoreInformationsNote2.textColor = UIColor.white
            EvenMoreInformationsNote2.backgroundColor = UIColor(red:0.05, green:0.05, blue:0.05, alpha:1.0)
            UIApplication.shared.statusBarStyle = .lightContent
        }
        
        if UserDefaults.standard.integer(forKey: "DarkmodeStatus") == 0 {
            view.backgroundColor = UIColor.white
            EvenMoreInformations.textColor = UIColor.black
            EvenMoreInformationsNote1.textColor = UIColor.black
            EvenMoreInformationsNote1.backgroundColor = UIColor.white
            EvenMoreInformationsNote2.textColor = UIColor.black
            EvenMoreInformationsNote2.backgroundColor = UIColor.white
            UIApplication.shared.statusBarStyle = .default
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return UIStatusBarStyle(rawValue: UserDefaults.standard.integer(forKey: "DarkmodeStatus"))!
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
