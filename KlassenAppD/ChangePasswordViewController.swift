//
//  ChangePasswordViewController.swift
//  KlassenAppD
//
//  Created by Adrian Baumgart on 05.10.18.
//  Copyright © 2018 Adrian Baumgart. All rights reserved.
//

import UIKit

class ChangePasswordViewController: UIViewController {

    @IBOutlet weak var currentUser: UILabel!
    @IBOutlet weak var CPWEO: UILabel!
    @IBOutlet weak var NewPW: UITextField!
    @IBOutlet weak var NewPWCheck: UITextField!
    
    @IBAction func ChangePW(_ sender: Any) {
        if NewPW.text != "" && NewPWCheck.text != "" {
            if NewPWCheck.text == NewPW.text {
                UserDefaults.standard.set(NewPWCheck.text, forKey: "\(UserDefaults.standard.string(forKey: "currentUsername"))PW")
                CPWEO.text = "Passwortänderung erfolgreich. Du wist in 3 Sekunden zurückgebracht"
                sleep(3)
                self.performSegue(withIdentifier: "changepwback", sender: nil)
            }
        }
        else {
            CPWEO.text = "Fülle bitte alle Felder aus"
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        currentUser.text = "Benutzer: \(UserDefaults.standard.string(forKey: "currentUsername"))"
        // Do any additional setup after loading the view.
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
