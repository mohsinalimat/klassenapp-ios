//
//  TimeTableThursdayViewController.swift
//  KlassenAppD
//
//  Created by Adrian Baumgart on 19.09.18.
//  Copyright © 2018 Adrian Baumgart. All rights reserved.
//

import UIKit
import Firebase
import NVActivityIndicatorView

class TimeTableThursdayViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var TVThursdayTitle: UILabel!
  //  let ThursdayTVarray: [String] = ["1. Std: Deutsch", "2. Std: Deutsch", "3. Std: Chemie", "4. Std: Chemie", "5. Std: Mathe", "6. Std: Mathe", "PAUSE", "8. Std: Musik", "9. Std: Musik"]
    var thursdayArray: [String] = []
    var loader : NVActivityIndicatorView!
    
    @IBOutlet weak var TimeTableThursdayTV: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        loader = NVActivityIndicatorView(frame: CGRect(x: self.view.center.x-25, y: self.view.center.y-25, width: 50, height: 50))
        //loader.type = .ballRotateChase
        loader.type = .ballPulseSync
        loader.color = UIColor.red
        view.addSubview(loader)
        loader.startAnimating()
        if UserDefaults.standard.integer(forKey: "DarkmodeStatus") == 1 {
            view.backgroundColor = UIColor(red:0.05, green:0.05, blue:0.05, alpha:1.0)
            TVThursdayTitle.textColor = UIColor.white
            TimeTableThursdayTV.backgroundColor = UIColor(red:0.05, green:0.05, blue:0.05, alpha:1.0)
            self.setNeedsStatusBarAppearanceUpdate()
        }
        
        if UserDefaults.standard.integer(forKey: "DarkmodeStatus") == 0 {
            view.backgroundColor = UIColor.white
            TVThursdayTitle.textColor = UIColor.black
            TimeTableThursdayTV.backgroundColor = UIColor.white
            self.setNeedsStatusBarAppearanceUpdate()
        }

        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        loadData()
    }
    
    func loadData() {
        let ref: DatabaseReference
        ref = Database.database().reference()
        ref.child("stundenplan").child("thursday").observeSingleEvent(of: .value, with: { snapshot in
            for child in snapshot.children {
                let snap = child as! DataSnapshot
                let hours = snap.value as! String
                self.thursdayArray.append(hours)
            }
            print(self.thursdayArray)
            self.TimeTableThursdayTV.reloadData()
            self.loader.stopAnimating()
        })
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return thursdayArray.count
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
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellthu = TimeTableThursdayTV.dequeueReusableCell(withIdentifier: "cellthursday", for: indexPath)
        cellthu.textLabel?.text = thursdayArray[indexPath.row]
        if UserDefaults.standard.integer(forKey: "DarkmodeStatus") == 1 {
            cellthu.backgroundColor = UIColor(red:0.05, green:0.05, blue:0.05, alpha:1.0)
            cellthu.textLabel!.textColor = UIColor.white
        }
        if UserDefaults.standard.integer(forKey: "DarkmodeStatus") == 0 {
            cellthu.backgroundColor = UIColor.white
            cellthu.textLabel!.textColor = UIColor.black
        }
        return cellthu
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
