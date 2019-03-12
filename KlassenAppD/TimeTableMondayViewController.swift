//
//  TimeTableMondayViewController.swift
//  KlassenAppD
//
//  Created by Adrian Baumgart on 19.09.18.
//  Copyright © 2018 Adrian Baumgart. All rights reserved.
//

import UIKit

class TimeTableMondayViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var TVMondayTitle: UILabel!
    
    var MondayTVarray: [String] = ["1. Std: Deutsch", "2.Std: Klassenlehrer", "3. Std: Geschichte Bili", "4. Std: Geschichte Bili", "5. Std: Englisch", "6. Std: Englisch", "PAUSE", "8. Std: Geografie Bili", "9. Std: Geografie Bili"]

    @IBOutlet weak var TimeTableMondayTV: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        if UserDefaults.standard.integer(forKey: "DarkmodeStatus") == 1 {
            view.backgroundColor = UIColor(red:0.05, green:0.05, blue:0.05, alpha:1.0)
            TVMondayTitle.textColor = UIColor.white
            TimeTableMondayTV.backgroundColor = UIColor(red:0.05, green:0.05, blue:0.05, alpha:1.0)
            UIApplication.shared.statusBarStyle = .lightContent
        }
        
        if UserDefaults.standard.integer(forKey: "DarkmodeStatus") == 0 {
            view.backgroundColor = UIColor.white
            TVMondayTitle.textColor = UIColor.black
            TimeTableMondayTV.backgroundColor = UIColor.white
            UIApplication.shared.statusBarStyle = .default
        }

        // Do any additional setup after loading the view.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MondayTVarray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellmon = TimeTableMondayTV.dequeueReusableCell(withIdentifier: "cellmonday", for: indexPath)
        cellmon.textLabel?.text = MondayTVarray[indexPath.row]
        if UserDefaults.standard.integer(forKey: "DarkmodeStatus") == 1 {
            cellmon.backgroundColor = UIColor(red:0.05, green:0.05, blue:0.05, alpha:1.0)
            cellmon.textLabel!.textColor = UIColor.white
        }
        if UserDefaults.standard.integer(forKey: "DarkmodeStatus") == 0 {
            cellmon.backgroundColor = UIColor.white
            cellmon.textLabel!.textColor = UIColor.black
        }
        return cellmon
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
