//
//  CreateHomeworkRequestViewController.swift
//  KlassenAppD
//
//  Created by Adrian Baumgart on 10.05.19.
//  Copyright © 2019 Adrian Baumgart. All rights reserved.
//

import UIKit
import FirebaseDatabase
import UITextView_Placeholder
import EZAlertController

class CreateHomeworkRequestViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    var DatabaseDay:String!
    var Coloro: UIColor!
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return days[row]
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return days.count
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let selectedDay = days[row]
        if selectedDay == "Montag" {
            self.DatabaseDay = "Monday"
        }
        if selectedDay == "Dienstag" {
            self.DatabaseDay = "Tuesday"
        }
        if selectedDay == "Mittwoch" {
            self.DatabaseDay = "Wednesday"
        }
        if selectedDay == "Donnerstag" {
            self.DatabaseDay = "Thursday"
        }
        if selectedDay == "Freitag" {
            self.DatabaseDay = "Friday"
        }
        if selectedDay == "Bitte auswählen" {
            self.DatabaseDay = "notdefined"
        }
        print(selectedDay)
        print(self.DatabaseDay!)
    }
    

    @IBOutlet weak var CreateHomeworkRequestOut: UIButton!
    @IBOutlet weak var TitleText: UILabel!
    @IBOutlet weak var TitleBackground: UIView!
    @IBOutlet weak var TitleBar: UIView!
    @IBOutlet weak var Picker: UIPickerView!
    @IBOutlet weak var ContentTextView: UITextView!
    
    let days = ["Bitte auswählen", "Montag", "Dienstag", "Mittwoch", "Donnerstag", "Freitag"]
    
    @IBAction func BackBtn(_ sender: Any)
    {
        FirstViewController.LastVC.LastVCV = "hw"
        self.performSegue(withIdentifier: "backfromrequeststowtb", sender: nil)
    }
    @IBAction func CreateRequest(_ sender: Any)
    {
        let notificationFeedbackGenerator = UINotificationFeedbackGenerator()
        notificationFeedbackGenerator.prepare()
        
        var ref: DatabaseReference!
        
        ref = Database.database().reference()
        if ContentTextView.text != "" {
            if DatabaseDay == "Monday" || DatabaseDay == "Tuesday" || DatabaseDay == "Wednesday" || DatabaseDay == "Thursday" || DatabaseDay == "Friday" {
                //UPLOAD
                let date = Date()
                let calender = Calendar.current
                let components = calender.dateComponents([.year,.month,.day,.hour,.minute,.second], from: date)
                
                let year = components.year
                let month = components.month
                let day = components.day
                let hour = components.hour
                let minute = components.minute
                
                let fulldate = String(day!) + "." + String(month!) + "." + String(year!) + " " + String(hour!) + ":" + String(minute!)
                
                let random = randomString(length: 15)
                ref.child("requests").child(random).child("id").setValue(random)
                ref.child("requests").child(random).child("day").setValue(self.DatabaseDay!)
                ref.child("requests").child(random).child("Content").setValue(ContentTextView.text!)
                notificationFeedbackGenerator.notificationOccurred(.success)
                ref.child("requests").child(random).child("time").setValue(fulldate)
                FirstViewController.LastVC.LastVCV = "hw"
                self.performSegue(withIdentifier: "backfromrequeststowtb", sender: nil)
            }
            else {
                notificationFeedbackGenerator.notificationOccurred(.warning)
                EZAlertController.alert("Fehler", message: "Bitte wähle einen Tag im Menü oben aus.")
        }
    }
        else {
            notificationFeedbackGenerator.notificationOccurred(.warning)
            EZAlertController.alert("Fehler", message: "Bitte gib die Hausaufgaben in das Feld ein.")
        }
        
        
    }
    
    func randomString(length: Int) -> String {
        let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890"
        return String((0...length-1).map{_ in letters.randomElement()!})
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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ContentTextView.placeholder = "Text hier eingeben"
        ContentTextView.placeholderColor = UIColor.lightGray
        if UserDefaults.standard.string(forKey: "ButtonColor") != nil && UserDefaults.standard.string(forKey: "ButtonColor") != "" {
            self.CreateHomeworkRequestOut.backgroundColor = UIColor(red: CGFloat(UserDefaults.standard.integer(forKey: "ButtonRed"))/255, green: CGFloat(UserDefaults.standard.integer(forKey: "ButtonGreen"))/255, blue: CGFloat(UserDefaults.standard.integer(forKey: "ButtonBlue"))/255, alpha: 1)
        }
        if UserDefaults.standard.string(forKey: "TitleBarColor") != nil && UserDefaults.standard.string(forKey: "TitleBarColor") != "" {
            self.TitleBar.backgroundColor = UIColor(red: CGFloat(UserDefaults.standard.integer(forKey: "TitleBarRed"))/255, green: CGFloat(UserDefaults.standard.integer(forKey: "TitleBarGreen"))/255, blue: CGFloat(UserDefaults.standard.integer(forKey: "TitleBarBlue"))/255, alpha: 1)
        }
        
        if UserDefaults.standard.integer(forKey: "DarkmodeStatus") == 1 {
            view.backgroundColor = UIColor(red:0.05, green:0.05, blue:0.05, alpha:1.0)
            TitleBackground.backgroundColor = UIColor(red:0.13, green:0.13, blue:0.13, alpha:1.0)
            TitleText.textColor = UIColor.white
            ContentTextView.backgroundColor = UIColor(red:0.05, green:0.05, blue:0.05, alpha:1.0)
            ContentTextView.textColor = UIColor.white
            Picker.backgroundColor = UIColor(red:0.05, green:0.05, blue:0.05, alpha:1.0)
            //Picker.tintColor = UIColor.white
            Coloro = UIColor.white
            self.setNeedsStatusBarAppearanceUpdate()
        }
        if UserDefaults.standard.integer(forKey: "DarkmodeStatus") == 0 {
            view.backgroundColor = UIColor.white
            TitleBackground.backgroundColor = UIColor(red:0.95, green:0.95, blue:0.95, alpha:1.0)
            TitleText.textColor = UIColor.black
            ContentTextView.backgroundColor = UIColor.white
            ContentTextView.textColor = UIColor.black
            Picker.backgroundColor = UIColor.white
            Picker.tintColor = UIColor.black
            Coloro = UIColor.black
            self.setNeedsStatusBarAppearanceUpdate()
        }
        // Do any additional setup after loading the view.
    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        var attributedString:NSAttributedString!
        attributedString = NSAttributedString(string: days[row], attributes: [NSAttributedString.Key.foregroundColor : Coloro])
        return attributedString
    }
    
    /*func pickerView(pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        var attributedString: NSAttributedString!
        
        
    //attributedString = NSAttributedString(string: arrayOne[row], attributes: [NSForegroundColorAttributeName : UIColor.redColor()])
        
        if UserDefaults.standard.integer(forKey: "DarkmodeStatus") == 1 {
            attributedString = NSAttributedString(string: days[row], attributes: [NSAttributedString.Key.foregroundColor : UIColor.white])
        }
        if UserDefaults.standard.integer(forKey: "DarkmodeStatus") == 0 {
            attributedString = NSAttributedString(string: days[row], attributes: [NSAttributedString.Key.foregroundColor : UIColor.black])
        }
        
        
        return attributedString
    }*/
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
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
