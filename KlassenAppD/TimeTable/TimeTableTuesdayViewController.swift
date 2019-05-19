//
//  TimeTableTuesdayViewController.swift
//  KlassenAppD
//
//  Created by Adrian Baumgart on 19.09.18.
//  Copyright © 2018 Adrian Baumgart. All rights reserved.
//

import UIKit
import Firebase
import NVActivityIndicatorView

class TimeTableTuesdayViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var TVTuesdayTitle: UILabel!
    
   // let TuesdayTVarray: [String] = ["1. Std: Religion", "2. Std: Religion", "3. Std: NwT/Spanisch", "4. Std: NwT/Spanisch", "5. Std: Französisch", "6. Std: Französisch", "PAUSE", "8. Std: Gemeinschaftskunde", "9. Std: WBS"]
    var tuesdayArray : [String] = []
    var loader : NVActivityIndicatorView!
    
    @IBOutlet weak var TimeTableTuesdayTV: UITableView!
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
            TVTuesdayTitle.textColor = UIColor.white
            TimeTableTuesdayTV.backgroundColor = UIColor(red:0.05, green:0.05, blue:0.05, alpha:1.0)
            UIApplication.shared.statusBarStyle = .lightContent
        }
        
        if UserDefaults.standard.integer(forKey: "DarkmodeStatus") == 0 {
            view.backgroundColor = UIColor.white
            TVTuesdayTitle.textColor = UIColor.black
            TimeTableTuesdayTV.backgroundColor = UIColor.white
            UIApplication.shared.statusBarStyle = .default
        }


        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        loadData()
    }
    
    func loadData() {
        let ref: DatabaseReference
        ref = Database.database().reference()
        ref.child("stundenplan").child("tuesday").observeSingleEvent(of: .value, with: { snapshot in
            var mySongArray = [String]()
            for child in snapshot.children {
                let snap = child as! DataSnapshot
                let hours = snap.value as! String
                self.tuesdayArray.append(hours)
            }
            print(self.tuesdayArray)
            self.TimeTableTuesdayTV.reloadData()
            self.loader.stopAnimating()
        })
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tuesdayArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let celltue = TimeTableTuesdayTV.dequeueReusableCell(withIdentifier: "celltuesday", for: indexPath)
        celltue.textLabel?.text = tuesdayArray[indexPath.row]
        if UserDefaults.standard.integer(forKey: "DarkmodeStatus") == 1 {
            celltue.backgroundColor = UIColor(red:0.05, green:0.05, blue:0.05, alpha:1.0)
            celltue.textLabel!.textColor = UIColor.white
        }
        if UserDefaults.standard.integer(forKey: "DarkmodeStatus") == 0 {
            celltue.backgroundColor = UIColor.white
            celltue.textLabel!.textColor = UIColor.black
        }
        return celltue
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
