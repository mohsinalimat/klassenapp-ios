 
//  TimeTableFridayViewController.swift
//  KlassenAppD
//
//  Created by Adrian Baumgart on 19.09.18.
//  Copyright © 2018 Adrian Baumgart. All rights reserved.
//

import UIKit
import Firebase
import NVActivityIndicatorView

class TimeTableFridayViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var TVFridayTitle: UILabel!
    
   // let FridayTVarray: [String] = ["1. Std: Sport", "2. Std: Sport", "3. Std: Mathe", "4. Std: Mathe", "5. Std: Französisch", "6. Std: Französisch"]
    var fridayArray: [String] = []
    var loader : NVActivityIndicatorView!
    
    @IBOutlet weak var TimeTableFridayTV: UITableView!
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
            TVFridayTitle.textColor = UIColor.white
            TimeTableFridayTV.backgroundColor = UIColor(red:0.05, green:0.05, blue:0.05, alpha:1.0)
            UIApplication.shared.statusBarStyle = .lightContent
        }
        
        if UserDefaults.standard.integer(forKey: "DarkmodeStatus") == 0 {
            view.backgroundColor = UIColor.white
            TVFridayTitle.textColor = UIColor.black
            TimeTableFridayTV.backgroundColor = UIColor.white
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
        ref.child("stundenplan").child("friday").observeSingleEvent(of: .value, with: { snapshot in
            var mySongArray = [String]()
            for child in snapshot.children {
                let snap = child as! DataSnapshot
                let hours = snap.value as! String
                self.fridayArray.append(hours)
            }
            print(self.fridayArray)
            self.TimeTableFridayTV.reloadData()
            self.loader.stopAnimating()
        })
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fridayArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellfri = TimeTableFridayTV.dequeueReusableCell(withIdentifier: "cellfriday", for: indexPath)
        cellfri.textLabel?.text = fridayArray[indexPath.row]
        if UserDefaults.standard.integer(forKey: "DarkmodeStatus") == 1 {
            cellfri.backgroundColor = UIColor(red:0.05, green:0.05, blue:0.05, alpha:1.0)
            cellfri.textLabel!.textColor = UIColor.white
        }
        if UserDefaults.standard.integer(forKey: "DarkmodeStatus") == 0 {
            cellfri.backgroundColor = UIColor.white
            cellfri.textLabel!.textColor = UIColor.black
        }
        return cellfri
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
