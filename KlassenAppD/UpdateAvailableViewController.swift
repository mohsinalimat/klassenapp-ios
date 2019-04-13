//
//  UpdateAvailableViewController.swift
//  KlassenAppD
//
//  Created by Adrian Baumgart on 12.04.19.
//  Copyright © 2019 Adrian Baumgart. All rights reserved.
//

import UIKit
import Panels

class UpdateAvailableViewController: UIViewController, Panelable {
    var headerHeight: NSLayoutConstraint!
     var headerPanel: UIView!
    

    override func viewDidLoad() {
        self.view.addBlurBackground()
        curveTopCorners()
        self.view.layoutIfNeeded()
        super.viewDidLoad()

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
