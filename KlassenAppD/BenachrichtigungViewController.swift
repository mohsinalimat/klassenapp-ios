//
//  BenachrichtigungViewController.swift
//  KlassenAppD
//
//  Created by Adrian Baumgart on 02.10.18.
//  Copyright © 2018 Adrian Baumgart. All rights reserved.
//

import UIKit
import FirebaseDatabase

class BenachrichtigungViewController: UIViewController {

    @IBOutlet weak var BenachrichtigungTitle: UILabel!
    @IBOutlet weak var BenachrichtigungMessage: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        if UserDefaults.standard.integer(forKey: "DarkmodeStatus") == 1 {
            view.backgroundColor = UIColor(red:0.08, green:0.08, blue:0.08, alpha:1.0)
            BenachrichtigungTitle.textColor = UIColor.white
            BenachrichtigungMessage.textColor = UIColor.white
            BenachrichtigungMessage.backgroundColor = UIColor(red:0.08, green:0.08, blue:0.08, alpha:1.0)
            self.setNeedsStatusBarAppearanceUpdate()
        }
        if UserDefaults.standard.integer(forKey: "DarkmodeStatus") == 0 {
            view.backgroundColor = UIColor.white
            BenachrichtigungTitle.textColor = UIColor.black
            BenachrichtigungMessage.textColor = UIColor.black
            BenachrichtigungMessage.backgroundColor = UIColor.white
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
    
    override func viewDidAppear(_ animated: Bool) {
        let ref: DatabaseReference = Database.database().reference()
        ref.child("warnings").child("custom").child("message_long").observeSingleEvent(of: .value) { (warningmessagelongcontent) in
            let warningmessagelongcontentLE = warningmessagelongcontent.value as? String
            self.BenachrichtigungMessage.text = warningmessagelongcontentLE
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
