//
//  TimeTableThursdayViewController.swift
//  KlassenAppD
//
//  Created by Adrian Baumgart on 19.09.18.
//  Copyright © 2018 Adrian Baumgart. All rights reserved.
//

import UIKit

class TimeTableThursdayViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var TVThursdayTitle: UILabel!
    let ThursdayTVarray: [String] = ["1. Std: Deutsch", "2. Std: Deutsch", "3. Std: Chemie", "4. Std: Chemie", "5. Std: Mathe", "6. Std: Mathe", "PAUSE", "8. Std: Musik", "9. Std: Musik"]
    
    @IBOutlet weak var TimeTableThursdayTV: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        if UserDefaults.standard.integer(forKey: "DarkmodeStatus") == 1 {
            view.backgroundColor = UIColor(red:0.05, green:0.05, blue:0.05, alpha:1.0)
            TVThursdayTitle.textColor = UIColor.white
            TimeTableThursdayTV.backgroundColor = UIColor(red:0.05, green:0.05, blue:0.05, alpha:1.0)
            UIApplication.shared.statusBarStyle = .lightContent
        }
        
        if UserDefaults.standard.integer(forKey: "DarkmodeStatus") == 0 {
            view.backgroundColor = UIColor.white
            TVThursdayTitle.textColor = UIColor.black
            TimeTableThursdayTV.backgroundColor = UIColor.white
            UIApplication.shared.statusBarStyle = .default
        }

        
        // Do any additional setup after loading the view.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ThursdayTVarray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellthu = TimeTableThursdayTV.dequeueReusableCell(withIdentifier: "cellthursday", for: indexPath)
        cellthu.textLabel?.text = ThursdayTVarray[indexPath.row]
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
