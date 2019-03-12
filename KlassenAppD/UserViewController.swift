//
//  UserViewController.swift
//  KlassenAppD
//
//  Created by Adrian Baumgart on 05.10.18.
//  Copyright © 2018 Adrian Baumgart. All rights reserved.
//

import UIKit

class UserViewController: UIViewController {

    @IBOutlet weak var UsernameTitle: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UsernameTitle.text = "Hallo, \(UserDefaults.standard.string(forKey: "currentUsername"))"

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
