//
//  PanelMaterial.swit
//  KlassenAppD
//
//  Created by Adrian Baumgart on 13.04.19.
//  Copyright © 2019 Adrian Baumgart. All rights reserved.
//


import UIKit
import Panels
import FirebaseDatabase

class PanelMaterial: UIViewController, Panelable {
    @IBOutlet var headerHeight: NSLayoutConstraint!
    @IBOutlet var headerPanel: UIView!
    @IBOutlet weak var VersionLabel: UILabel!
    
    lazy var panelManager = Panels(target: self)

    @IBAction func installbtn(_ sender: Any)
    {
        VersionLabel.text = "Bitte warten..."
        HomeViewController.HomeVar.UpdateReminderSession = "1"
        var ref: DatabaseReference!
        
        ref = Database.database().reference()
        
        ref.child("standardData").child("iosCurrentVer").child("UpdateLink").observeSingleEvent(of: .value) { (linksnap) in
            let linksnapLE = linksnap.value as! String
            UIApplication.shared.open(URL(string: linksnapLE)!)
        }
    }
    @IBAction func notnowbtn(_ sender: Any)
    {
        HomeViewController.HomeVar.UpdateReminderSession = "1"
    }
    override func viewDidLoad() {
        self.view.addBlurBackground()
        curveTopCorners()
        self.view.layoutIfNeeded()
        super.viewDidLoad()
        VersionLabel.text = "Version: \(HomeViewController.HomeVar.NewestVersion)"
        
    }
    
}
