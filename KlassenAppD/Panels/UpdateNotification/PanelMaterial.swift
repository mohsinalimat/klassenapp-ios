//
//  PanelMaterial.swit
//  KlassenAppD
//
//  Created by Adrian Baumgart on 13.04.19.
//  Copyright © 2019 Adrian Baumgart. All rights reserved.
//


import UIKit
import FirebaseDatabase

class PanelMaterial: UIViewController {
    @IBOutlet var headerHeight: NSLayoutConstraint!
    @IBOutlet var headerPanel: UIView!
    @IBOutlet weak var VersionLabel: UILabel!
    @IBOutlet weak var UpdateTitle: UILabel!
    @IBOutlet weak var downloadImage: UIImageView!

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
        //panelManager.dismiss()
    }
    override func viewDidLoad() {
        
        var blur: UIBlurEffect!
        
        if UserDefaults.standard.integer(forKey: "DarkmodeStatus") == 1 {
            blur = UIBlurEffect(style: .dark)
            UpdateTitle.textColor = .white
            VersionLabel.textColor = .white
            downloadImage.image = UIImage(named: "downloadcloudnew")
        }
        
        if UserDefaults.standard.integer(forKey: "DarkmodeStatus") == 0 {
            blur = UIBlurEffect(style: .light)
            self.view.backgroundColor = .white
            UpdateTitle.textColor = .black
            VersionLabel.textColor = .black
            downloadImage.image = UIImage(named: "downloadcloudnewdark")
        }
        
        let blurView = UIVisualEffectView(effect: blur)
        
        blurView.frame = view.bounds
        blurView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        self.view.insertSubview(blurView, at: 0)
        
        
        //self.view.addBlurBackground()
        curveTopCorners()
        self.view.layoutIfNeeded()
        super.viewDidLoad()
        VersionLabel.text = "Version: \(HomeViewController.HomeVar.NewestVersion)"
        
    }
    
}
