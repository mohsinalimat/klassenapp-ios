//
//  CreateHWRequest2ViewController.swift
//  KlassenAppD
//
//  Created by Adrian Baumgart on 30.05.19.
//  Copyright © 2019 Adrian Baumgart. All rights reserved.
//

import AppCenter
import AppCenterAnalytics
import AppCenterCrashes
import EZAlertController
import Firebase
import SPAlert
import SPFakeBar
import SPStorkController
import UIKit

class CreateHWRequest2ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    let navigationbar = SPFakeBarView(style: .stork)
    private var ContentTextView: UITextView!
    private var Picker: UIPickerView!
    var DatabaseDay: String!
    var Coloro: UIColor!
    let days = ["Bitte auswählen", "Montag", "Dienstag", "Mittwoch", "Donnerstag", "Freitag"]
    
    var style = Appearances()
    
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
            DatabaseDay = "Monday"
        }
        if selectedDay == "Dienstag" {
            DatabaseDay = "Tuesday"
        }
        if selectedDay == "Mittwoch" {
            DatabaseDay = "Wednesday"
        }
        if selectedDay == "Donnerstag" {
            DatabaseDay = "Thursday"
        }
        if selectedDay == "Freitag" {
            DatabaseDay = "Friday"
        }
        if selectedDay == "Bitte auswählen" {
            DatabaseDay = "notdefined"
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        var attributedString: NSAttributedString!
        attributedString = NSAttributedString(string: days[row], attributes: [NSAttributedString.Key.foregroundColor: Coloro])
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
        view.addSubview(navigationbar)
        for subview in navigationbar.subviews {
            if subview is UIVisualEffectView {
                subview.removeFromSuperview()
            }
        }
        
        let titlebar = UIView(frame: CGRect(x: 0, y: navigationbar.height - 1, width: view.frame.width, height: 3))
        titlebar.backgroundColor = UIColor(red: 0.61, green: 0.32, blue: 0.88, alpha: 1.0)
        
        if UserDefaults.standard.string(forKey: "TitleBarColor") != nil, UserDefaults.standard.string(forKey: "TitleBarColor") != "" {
            titlebar.backgroundColor = UIColor(red: CGFloat(UserDefaults.standard.integer(forKey: "TitleBarRed")) / 255, green: CGFloat(UserDefaults.standard.integer(forKey: "TitleBarGreen")) / 255, blue: CGFloat(UserDefaults.standard.integer(forKey: "TitleBarBlue")) / 255, alpha: 1)
        }
        view.addSubview(titlebar)
        
        Picker = UIPickerView(frame: CGRect(x: 8, y: 105, width: view.frame.width - 16, height: 175))
        Picker.delegate = self
        Picker.dataSource = self
        view.addSubview(Picker)
        
        ContentTextView = UITextView(frame: CGRect(x: 8, y: 285, width: view.frame.width - 16, height: view.frame.height - 355))
        ContentTextView.isEditable = true
        ContentTextView.placeholder = "Text hier eingeben"
        ContentTextView.font = .systemFont(ofSize: 16)
        
        view.addSubview(ContentTextView)
        
        changeAppearance()
    }
    
    func changeAppearance() {
        if UserDefaults.standard.integer(forKey: "AutoAppearance") == 1 {
            if #available(iOS 13.0, *) {
                if traitCollection.userInterfaceStyle == .dark {
                    view.backgroundColor = style.darkBackground
                    navigationbar.backgroundColor = style.darkTitleBackground
                    navigationbar.titleLabel.textColor = style.darkText
                    ContentTextView.textColor = style.darkText
                    ContentTextView.backgroundColor = style.darkBackground
                    Picker.backgroundColor = style.darkBackground
                    Coloro = style.darkText
                    setNeedsStatusBarAppearanceUpdate()
                }
                else if traitCollection.userInterfaceStyle == .light || traitCollection.userInterfaceStyle == .unspecified {
                    view.backgroundColor = style.lightBackground
                    navigationbar.backgroundColor = style.lightTitleBackground
                    navigationbar.titleLabel.textColor = style.lightText
                    ContentTextView.textColor = style.lightText
                    ContentTextView.backgroundColor = style.lightBackground
                    Picker.backgroundColor = style.lightBackground
                    Picker.tintColor = style.lightText
                    Coloro = style.lightText
                    setNeedsStatusBarAppearanceUpdate()
                }
            }
        }
        else {
            if UserDefaults.standard.integer(forKey: "DarkmodeStatus") == 1 {
                view.backgroundColor = style.darkBackground
                navigationbar.backgroundColor = style.darkTitleBackground
                navigationbar.titleLabel.textColor = style.darkText
                ContentTextView.textColor = style.darkText
                ContentTextView.backgroundColor = style.darkBackground
                Picker.backgroundColor = style.darkBackground
                Coloro = style.darkText
                setNeedsStatusBarAppearanceUpdate()
            }
            else if UserDefaults.standard.integer(forKey: "DarkmodeStatus") == 0 {
                view.backgroundColor = style.lightBackground
                navigationbar.backgroundColor = style.lightTitleBackground
                navigationbar.titleLabel.textColor = style.lightText
                ContentTextView.textColor = style.lightText
                ContentTextView.backgroundColor = style.lightBackground
                Picker.backgroundColor = style.lightBackground
                Picker.tintColor = style.lightText
                Coloro = style.lightText
                setNeedsStatusBarAppearanceUpdate()
            }
        }
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        
        if #available(iOS 13.0, *) {
            if UserDefaults.standard.integer(forKey: "AutoAppearance") == 1 {
                UIView.animate(withDuration: 0.1) {
                    self.changeAppearance()
                }
                self.setNeedsStatusBarAppearanceUpdate()
            }
        }
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Placeholder"
            textView.textColor = UIColor.lightGray
        }
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
        present(controller1, animated: true, completion: nil)
    }
    
    @objc func sendRequest() {
        let notificationFeedbackGenerator = UINotificationFeedbackGenerator()
        notificationFeedbackGenerator.prepare()
        
        var ref: DatabaseReference!
        
        ref = Database.database().reference()
        if ContentTextView.text != "" {
            if DatabaseDay == "Monday" || DatabaseDay == "Tuesday" || DatabaseDay == "Wednesday" || DatabaseDay == "Thursday" || DatabaseDay == "Friday" {
                let date = Date()
                let calender = Calendar.current
                let components = calender.dateComponents([.year, .month, .day, .hour, .minute, .second], from: date)
                
                let year = components.year
                let month = components.month
                let day = components.day
                let hour = components.hour
                let minute = components.minute
                
                let fulldate = String(day!) + "." + String(month!) + "." + String(year!) + " " + String(hour!) + ":" + String(minute!)
                
                let random = randomString(length: 15)
                ref.child("requests").child(random).child("id").setValue(random)
                ref.child("requests").child(random).child("day").setValue(DatabaseDay!)
                ref.child("requests").child(random).child("Content").setValue(ContentTextView.text!)
                ref.child("requests").child(random).child("time").setValue(fulldate)
                ref.child("requests").child(random).child("client").setValue("iOS")
                view.endEditing(true)
                let requests = UserDefaults.standard.stringArray(forKey: "RequestLog")
                var request2: [String] = []
                if requests != nil {
                    request2.append(contentsOf: requests!)
                }
                request2.append(random)
                UserDefaults.standard.set(request2, forKey: "RequestLog")
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
                dismiss(animated: true, completion: nil)
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
        return String((0...length - 1).map { _ in letters.randomElement()! })
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}

extension UITextView: UITextViewDelegate {
    open override var bounds: CGRect {
        didSet {
            resizePlaceholder()
        }
    }
    
    public var placeholder: String? {
        get {
            var placeholderText: String?
            
            if let placeholderLabel = self.viewWithTag(100) as? UILabel {
                placeholderText = placeholderLabel.text
            }
            
            return placeholderText
        }
        set {
            if let placeholderLabel = self.viewWithTag(100) as! UILabel? {
                placeholderLabel.text = newValue
                placeholderLabel.sizeToFit()
            }
            else {
                addPlaceholder(newValue!)
            }
        }
    }
    
    public func textViewDidChange(_ textView: UITextView) {
        if let placeholderLabel = self.viewWithTag(100) as? UILabel {
            placeholderLabel.isHidden = text.characters.count > 0
        }
    }
    
    private func resizePlaceholder() {
        if let placeholderLabel = self.viewWithTag(100) as! UILabel? {
            let labelX = textContainer.lineFragmentPadding
            let labelY = textContainerInset.top - 2
            let labelWidth = frame.width - (labelX * 2)
            let labelHeight = placeholderLabel.frame.height
            
            placeholderLabel.frame = CGRect(x: labelX, y: labelY, width: labelWidth, height: labelHeight)
        }
    }
    
    private func addPlaceholder(_ placeholderText: String) {
        let placeholderLabel = UILabel()
        
        placeholderLabel.text = placeholderText
        placeholderLabel.sizeToFit()
        
        placeholderLabel.font = font
        placeholderLabel.textColor = UIColor.lightGray
        placeholderLabel.tag = 100
        
        placeholderLabel.isHidden = text.characters.count > 0
        
        addSubview(placeholderLabel)
        resizePlaceholder()
        delegate = self
    }
}
