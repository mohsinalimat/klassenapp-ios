//
//  CreateHWRequest2ViewController.swift
//  KlassenAppD
//
//  Created by Adrian Baumgart on 30.05.19.
//  Copyright © 2019 Adrian Baumgart. All rights reserved.
//

import UIKit
import Firebase
import UITextView_Placeholder
import SPFakeBar
import EZAlertController
import SPAlert
import AppCenter
import AppCenterAnalytics
import AppCenterCrashes
import SPStorkController

class CreateHWRequest2ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    let navigationbar = SPFakeBarView(style: .stork)
    private var ContentTextView: UITextView!
    private var Picker: UIPickerView!
    var DatabaseDay:String!
    var Coloro: UIColor!
    let days = ["Bitte auswählen", "Montag", "Dienstag", "Mittwoch", "Donnerstag", "Freitag"]
    
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
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        var attributedString:NSAttributedString!
        attributedString = NSAttributedString(string: days[row], attributes: [NSAttributedString.Key.foregroundColor : Coloro])
        return attributedString
    }
    
    override func viewDidLoad() {
        navigationbar.titleLabel.text = "Anfrage"
        navigationbar.titleLabel.font = navigationbar.titleLabel.font.withSize(23)
        navigationbar.height = 100
        navigationbar.titleLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
        navigationbar.titleLabel.numberOfLines = 3
        navigationbar.rightButton.setTitle("Senden", for: .normal)
        navigationbar.rightButton.titleLabel?.font = .boldSystemFont(ofSize: 17)
        navigationbar.rightButton.addTarget(self, action: #selector(sendRequest), for: .touchUpInside)
        navigationbar.leftButton.setTitle("Verlauf", for: .normal)
        navigationbar.leftButton.titleLabel?.font = .boldSystemFont(ofSize: 17)
        navigationbar.leftButton.addTarget(self, action: #selector(openLog), for: .touchUpInside)
        self.view.addSubview(navigationbar)
        for subview in navigationbar.subviews {
            if subview is UIVisualEffectView {
                subview.removeFromSuperview()
            }
        }
        
        let titlebar = UIView(frame: CGRect(x: 0, y: navigationbar.height - 1, width: self.view.frame.width, height: 3))
        titlebar.backgroundColor = UIColor(red:0.61, green:0.32, blue:0.88, alpha:1.0)
        
        if UserDefaults.standard.string(forKey: "TitleBarColor") != nil && UserDefaults.standard.string(forKey: "TitleBarColor") != "" {
            titlebar.backgroundColor = UIColor(red: CGFloat(UserDefaults.standard.integer(forKey: "TitleBarRed"))/255, green: CGFloat(UserDefaults.standard.integer(forKey: "TitleBarGreen"))/255, blue: CGFloat(UserDefaults.standard.integer(forKey: "TitleBarBlue"))/255, alpha: 1)
        }
        self.view.addSubview(titlebar)
        
        Picker = UIPickerView(frame: CGRect(x: 8, y: 105, width: self.view.frame.width - 16, height: 175))
        Picker.delegate = self
        Picker.dataSource = self
        self.view.addSubview(Picker)
        
        ContentTextView = UITextView(frame: CGRect(x: 8, y: 285, width: self.view.frame.width - 16, height: self.view.frame.height - 355))
        ContentTextView.isEditable = true
        ContentTextView.placeholder = "Text hier eingeben"
        ContentTextView.placeholderColor = UIColor.lightGray
        ContentTextView.font = .systemFont(ofSize: 16)
        
        self.view.addSubview(ContentTextView)
        if UserDefaults.standard.integer(forKey: "DarkmodeStatus") == 1 {
            view.backgroundColor = UIColor(red:0.05, green:0.05, blue:0.05, alpha:1.0)
            navigationbar.backgroundColor = UIColor(red:0.13, green:0.13, blue:0.13, alpha:1.0)
            navigationbar.titleLabel.textColor = .white
            ContentTextView.textColor = .white
            ContentTextView.backgroundColor = UIColor(red:0.05, green:0.05, blue:0.05, alpha:1.0)
            Picker.backgroundColor = UIColor(red:0.05, green:0.05, blue:0.05, alpha:1.0)
            Coloro = UIColor.white
            self.setNeedsStatusBarAppearanceUpdate()
        }
        if UserDefaults.standard.integer(forKey: "DarkmodeStatus") == 0 {
            view.backgroundColor = UIColor.white
            navigationbar.backgroundColor = UIColor(red:0.95, green:0.95, blue:0.95, alpha:1.0)
            navigationbar.titleLabel.textColor = .black
            ContentTextView.textColor = .black
            ContentTextView.backgroundColor = .white
            Picker.backgroundColor = UIColor.white
            Picker.tintColor = UIColor.black
            Coloro = UIColor.black
            self.setNeedsStatusBarAppearanceUpdate()
        }
        
        // Do any additional setup after loading the view.
    }
    
    @objc func openLog() {
        let impactFeedbackgenerator = UIImpactFeedbackGenerator(style: .light)
        impactFeedbackgenerator.prepare()
        impactFeedbackgenerator.impactOccurred()
        let controller1 = HwRequestLogViewController()
        let transitionDelegate = SPStorkTransitioningDelegate()
        controller1.transitioningDelegate = transitionDelegate
        controller1.modalPresentationStyle = .custom
        controller1.modalPresentationCapturesStatusBarAppearance = true
        self.present(controller1, animated: true, completion: nil)
    }
    
    @objc func sendRequest() {
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
                ref.child("requests").child(random).child("time").setValue(fulldate)
                ref.child("requests").child(random).child("client").setValue("iOS")
                //notificationFeedbackGenerator.notificationOccurred(.success)
                self.view.endEditing(true)
                var requests = UserDefaults.standard.stringArray(forKey: "RequestLog")
                var request2:[String] = []
                if requests != nil {
                    request2.append(contentsOf: requests!)
                }
                request2.append(random)
                UserDefaults.standard.set(request2, forKey: "RequestLog")
                print(UserDefaults.standard.stringArray(forKey: "RequestLog"))
                MSAnalytics.trackEvent("Create Homework Request")
                let doneAlert = SPAlertView(title: "Hochgeladen", message: "", preset: .done)
                
                for subview in doneAlert.subviews {
                    if subview is UIVisualEffectView {
                        subview.removeFromSuperview()
                    }
                }
                
                if UserDefaults.standard.integer(forKey: "DarkmodeStatus") == 1 {
                    doneAlert.backgroundColor = .black
                    let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.dark)
                    let blurEffectView = UIVisualEffectView(effect: blurEffect)
                    blurEffectView.frame = view.bounds
                    blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
                    doneAlert.insertSubview(blurEffectView, at: 0)
                }
                if UserDefaults.standard.integer(forKey: "DarkmodeStatus") == 0 {
                    doneAlert.backgroundColor = .white
                    let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.extraLight)
                    let blurEffectView = UIVisualEffectView(effect: blurEffect)
                    blurEffectView.frame = view.bounds
                    blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
                    doneAlert.insertSubview(blurEffectView, at: 0)
                }
                doneAlert.duration = 2
                doneAlert.present()
                self.dismiss(animated: true, completion: nil)
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
        return .lightContent
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
