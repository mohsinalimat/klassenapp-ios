//
//  DDMViewController.swift
//  KlassenAppD
//
//  Created by Adrian Baumgart on 02.11.18.
//  Copyright © 2018 Adrian Baumgart. All rights reserved.
//

import UIKit

class DDMViewController: UIViewController {

    @IBOutlet weak var DDMTitleBackground: UIView!
    @IBOutlet weak var DDMTitle: UILabel!
    @IBOutlet weak var ActivateDDM: UILabel!
    @IBOutlet weak var DDMActiveTimeLabel: UILabel!
    @IBOutlet weak var DDMActivateSwitchOut: UISwitch!
    @IBOutlet weak var DDMActiveTime: UIDatePicker!
    @IBOutlet weak var DDMDeactiveTime: UIDatePicker!
    @IBAction func DDMBackBtn(_ sender: Any)
    {
        var dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        var ActiveTimer = dateFormatter.string(from: DDMActiveTime.date)
       // self.TESTLABEL.text = strDate
        UserDefaults.standard.set(ActiveTimer, forKey: "DDMActiveTime")
        var InActiveTimer = dateFormatter.string(from: DDMDeactiveTime.date)
        UserDefaults.standard.set(InActiveTimer, forKey: "DDMInactiveTime")
        
    }
    @IBAction func DDMActiveSwitch(_ sender: UISwitch)
    {
        if (sender.isOn == true) {
            UserDefaults.standard.set("on", forKey: "DDMActive")
        }
        if (sender.isOn != true) {
            UserDefaults.standard.set("off", forKey: "DDMActive")
        }
    }
    @IBOutlet weak var TESTLABEL: UILabel!
    @IBAction func TESTBTN(_ sender: Any)
    {
        var dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        var ActiveTimer = dateFormatter.string(from: DDMActiveTime.date)
        // self.TESTLABEL.text = strDate
        UserDefaults.standard.set(ActiveTimer, forKey: "DDMActiveTime")
        var InActiveTimer = dateFormatter.string(from: DDMDeactiveTime.date)
        UserDefaults.standard.set(InActiveTimer, forKey: "DDMInactiveTime")
        let date = Date()
        let calender = Calendar.current
        let components = calender.dateComponents([.year,.month,.day,.hour,.minute,.second], from: date)
        
        //let year = components.year
        //let month = components.month
        //let day = components.day
        let hour = components.hour
        let minute = components.minute
        //let second = components.second
        
        let today_string = String(hour!)  + ":" + String(minute!)
        TESTLABEL.text = today_string
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        if UserDefaults.standard.string(forKey: "DDMActive") == "on" {
            DDMActivateSwitchOut.setOn(true, animated: false)
        }
        if UserDefaults.standard.string(forKey: "DDMActive") != "on" {
            DDMActivateSwitchOut.setOn(false, animated: false)
        }
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
