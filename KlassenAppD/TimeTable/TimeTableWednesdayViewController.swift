//
//  TimeTableWednesdayViewController.swift
//  KlassenAppD
//
//  Created by Adrian Baumgart on 19.09.18.
//  Copyright © 2018 Adrian Baumgart. All rights reserved.
//

import UIKit
import Firebase
import NVActivityIndicatorView

class TimeTableWednesdayViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var TVWednesdayTitle: UILabel!
    
  //  let WednesdayTVarray: [String] = ["1. Std: NwT/Spanisch", "2. Std: NwT/Spanisch", "3. Std: Physik", "4. Std: Physik", "5. Std: Geschichte Bili", "6. Std: Englisch"]
    var wednesdayArray: [String] = []
    var loader : NVActivityIndicatorView!
    
    @IBOutlet weak var TimeTableWednesdayTV: UITableView!
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
            TVWednesdayTitle.textColor = UIColor.white
            TimeTableWednesdayTV.backgroundColor = UIColor(red:0.05, green:0.05, blue:0.05, alpha:1.0)
            self.setNeedsStatusBarAppearanceUpdate()
        }
        
        if UserDefaults.standard.integer(forKey: "DarkmodeStatus") == 0 {
            view.backgroundColor = UIColor.white
            TVWednesdayTitle.textColor = UIColor.black
            TimeTableWednesdayTV.backgroundColor = UIColor.white
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
        ref.child("stundenplan").child("wednesday").observeSingleEvent(of: .value, with: { snapshot in
            for child in snapshot.children {
                let snap = child as! DataSnapshot
                let hours = snap.value as! String
                self.wednesdayArray.append(hours)
            }
            print(self.wednesdayArray)
            self.TimeTableWednesdayTV.reloadData()
            self.loader.stopAnimating()
        })
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return wednesdayArray.count
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
        let cellwed = TimeTableWednesdayTV.dequeueReusableCell(withIdentifier: "cellwednesday", for: indexPath)
        cellwed.textLabel?.text = wednesdayArray[indexPath.row]
        if UserDefaults.standard.integer(forKey: "DarkmodeStatus") == 1 {
            cellwed.backgroundColor = UIColor(red:0.05, green:0.05, blue:0.05, alpha:1.0)
            cellwed.textLabel!.textColor = UIColor.white
        }
        if UserDefaults.standard.integer(forKey: "DarkmodeStatus") == 0 {
            cellwed.backgroundColor = UIColor.white
            cellwed.textLabel!.textColor = UIColor.black
        }
        return cellwed
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
