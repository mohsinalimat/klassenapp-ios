//
//  SecondViewController.swift
//  KlassenAppD
//
//  Created by Adrian Baumgart on 09.04.18.
//  Copyright © 2018 Adrian Baumgart. All rights reserved.
//

import FirebaseAuth
import FirebaseDatabase
import NVActivityIndicatorView
import SPStorkController
import UIKit

class SecondViewController: UIViewController {
    @IBOutlet var Arbeit1BtnOut: UIButton!
    @IBOutlet var Arbeit2BtnOut: UIButton!
    @IBOutlet var Arbeit3BtnOut: UIButton!
    @IBOutlet var Arbeit4BtnOut: UIButton!
    @IBOutlet var Arbeit5BtnOut: UIButton!
    @IBOutlet var backgroundTitleView: UIView!
    @IBOutlet var TitleBar: UIView!
    
    @IBOutlet var TestsLabel: UILabel!
    
    var loader: NVActivityIndicatorView!
    
    @IBAction func Arbeit1Btn(_ sender: Any) {
        let impactFeedbackgenerator = UIImpactFeedbackGenerator(style: .light)
        impactFeedbackgenerator.prepare()
        impactFeedbackgenerator.impactOccurred()
        AllTestsViewController.TestVC.selectedTest = "Arbeit1"
        let controller1 = AllTestsViewController()
        let transitionDelegate = SPStorkTransitioningDelegate()
        controller1.transitioningDelegate = transitionDelegate
        controller1.modalPresentationStyle = .custom
        controller1.modalPresentationCapturesStatusBarAppearance = true
        self.present(controller1, animated: true, completion: nil)
    }
    
    @IBAction func Arbeit2Btn(_ sender: Any) {
        let impactFeedbackgenerator = UIImpactFeedbackGenerator(style: .light)
        impactFeedbackgenerator.prepare()
        impactFeedbackgenerator.impactOccurred()
        AllTestsViewController.TestVC.selectedTest = "Arbeit2"
        let controller1 = AllTestsViewController()
        let transitionDelegate = SPStorkTransitioningDelegate()
        controller1.transitioningDelegate = transitionDelegate
        controller1.modalPresentationStyle = .custom
        controller1.modalPresentationCapturesStatusBarAppearance = true
        self.present(controller1, animated: true, completion: nil)
    }
    
    @IBAction func Arbeit3Btn(_ sender: Any) {
        let impactFeedbackgenerator = UIImpactFeedbackGenerator(style: .light)
        impactFeedbackgenerator.prepare()
        impactFeedbackgenerator.impactOccurred()
        AllTestsViewController.TestVC.selectedTest = "Arbeit3"
        let controller1 = AllTestsViewController()
        let transitionDelegate = SPStorkTransitioningDelegate()
        controller1.transitioningDelegate = transitionDelegate
        controller1.modalPresentationStyle = .custom
        controller1.modalPresentationCapturesStatusBarAppearance = true
        self.present(controller1, animated: true, completion: nil)
    }
    
    @IBAction func Arbeit4Btn(_ sender: Any) {
        let impactFeedbackgenerator = UIImpactFeedbackGenerator(style: .light)
        impactFeedbackgenerator.prepare()
        impactFeedbackgenerator.impactOccurred()
        AllTestsViewController.TestVC.selectedTest = "Arbeit4"
        let controller1 = AllTestsViewController()
        let transitionDelegate = SPStorkTransitioningDelegate()
        controller1.transitioningDelegate = transitionDelegate
        controller1.modalPresentationStyle = .custom
        controller1.modalPresentationCapturesStatusBarAppearance = true
        self.present(controller1, animated: true, completion: nil)
    }
    
    @IBAction func Arbeit5Btn(_ sender: Any) {
        let impactFeedbackgenerator = UIImpactFeedbackGenerator(style: .light)
        impactFeedbackgenerator.prepare()
        impactFeedbackgenerator.impactOccurred()
        AllTestsViewController.TestVC.selectedTest = "Arbeit5"
        let controller1 = AllTestsViewController()
        let transitionDelegate = SPStorkTransitioningDelegate()
        controller1.transitioningDelegate = transitionDelegate
        controller1.modalPresentationStyle = .custom
        controller1.modalPresentationCapturesStatusBarAppearance = true
        self.present(controller1, animated: true, completion: nil)
    }
    
    func viewLoadSetup() {
        self.loader = NVActivityIndicatorView(frame: CGRect(x: self.view.center.x - 25, y: self.view.center.y - 25, width: 50, height: 50))
        self.loader.type = .ballPulseSync
        self.loader.color = UIColor.red
        view.addSubview(self.loader)
        if self.Arbeit1BtnOut.titleLabel?.text == "Download..." {
            self.loader.startAnimating()
        }
        else {
            self.loader.stopAnimating()
        }
        if UserDefaults.standard.string(forKey: "ButtonColor") != nil, UserDefaults.standard.string(forKey: "ButtonColor") != "" {
            self.Arbeit1BtnOut.backgroundColor = UIColor(red: CGFloat(UserDefaults.standard.integer(forKey: "ButtonRed")) / 255, green: CGFloat(UserDefaults.standard.integer(forKey: "ButtonGreen")) / 255, blue: CGFloat(UserDefaults.standard.integer(forKey: "ButtonBlue")) / 255, alpha: 1)
            
            self.Arbeit2BtnOut.backgroundColor = UIColor(red: CGFloat(UserDefaults.standard.integer(forKey: "ButtonRed")) / 255, green: CGFloat(UserDefaults.standard.integer(forKey: "ButtonGreen")) / 255, blue: CGFloat(UserDefaults.standard.integer(forKey: "ButtonBlue")) / 255, alpha: 1)
            
            self.Arbeit3BtnOut.backgroundColor = UIColor(red: CGFloat(UserDefaults.standard.integer(forKey: "ButtonRed")) / 255, green: CGFloat(UserDefaults.standard.integer(forKey: "ButtonGreen")) / 255, blue: CGFloat(UserDefaults.standard.integer(forKey: "ButtonBlue")) / 255, alpha: 1)
            
            self.Arbeit4BtnOut.backgroundColor = UIColor(red: CGFloat(UserDefaults.standard.integer(forKey: "ButtonRed")) / 255, green: CGFloat(UserDefaults.standard.integer(forKey: "ButtonGreen")) / 255, blue: CGFloat(UserDefaults.standard.integer(forKey: "ButtonBlue")) / 255, alpha: 1)
            
            self.Arbeit5BtnOut.backgroundColor = UIColor(red: CGFloat(UserDefaults.standard.integer(forKey: "ButtonRed")) / 255, green: CGFloat(UserDefaults.standard.integer(forKey: "ButtonGreen")) / 255, blue: CGFloat(UserDefaults.standard.integer(forKey: "ButtonBlue")) / 255, alpha: 1)
        }
        if UserDefaults.standard.string(forKey: "TitleBarColor") != nil, UserDefaults.standard.string(forKey: "TitleBarColor") != "" {
            self.TitleBar.backgroundColor = UIColor(red: CGFloat(UserDefaults.standard.integer(forKey: "TitleBarRed")) / 255, green: CGFloat(UserDefaults.standard.integer(forKey: "TitleBarGreen")) / 255, blue: CGFloat(UserDefaults.standard.integer(forKey: "TitleBarBlue")) / 255, alpha: 1)
        }
        
        if UserDefaults.standard.integer(forKey: "DarkmodeStatus") == 1 {
            view.backgroundColor = UIColor(red: 0.05, green: 0.05, blue: 0.05, alpha: 1.0)
            self.backgroundTitleView.backgroundColor = UIColor(red: 0.13, green: 0.13, blue: 0.13, alpha: 1.0)
            self.TestsLabel.textColor = UIColor.white
            self.setNeedsStatusBarAppearanceUpdate()
        }
        if UserDefaults.standard.integer(forKey: "DarkmodeStatus") == 0 {
            view.backgroundColor = UIColor.white
            self.backgroundTitleView.backgroundColor = UIColor(red: 0.95, green: 0.95, blue: 0.95, alpha: 1.0)
            self.TestsLabel.textColor = UIColor.black
            self.setNeedsStatusBarAppearanceUpdate()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.viewLoadSetup()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        var ref: DatabaseReference!
        
        ref = Database.database().reference()
        
        ref.child("arbeiten").child("Arbeit1").child("buttonname").observe(.value) { Arbeit1ButtonSnap in
            let Arbeit1ButtonName = Arbeit1ButtonSnap.value as? String
            self.loader.stopAnimating()
            UserDefaults.standard.set(Arbeit1ButtonName, forKey: "UDTEST1Btn")
            if Arbeit1ButtonName != "-" {
                self.Arbeit1BtnOut.isEnabled = true
                self.Arbeit1BtnOut.setTitle(Arbeit1ButtonName, for: .normal)
            }
            if Arbeit1ButtonName == "-" {
                self.Arbeit1BtnOut.isEnabled = false
                self.Arbeit1BtnOut.setTitle(Arbeit1ButtonName, for: .normal)
            }
        }
        ref.child("arbeiten").child("Arbeit2").child("buttonname").observe(.value) { Arbeit2ButtonSnap in
            let Arbeit2ButtonName = Arbeit2ButtonSnap.value as? String
            UserDefaults.standard.set(Arbeit2ButtonName, forKey: "UDTEST2Btn")
            if Arbeit2ButtonName != "-" {
                self.Arbeit2BtnOut.isEnabled = true
                self.Arbeit2BtnOut.setTitle(Arbeit2ButtonName, for: .normal)
            }
            if Arbeit2ButtonName == "-" {
                self.Arbeit2BtnOut.isEnabled = false
                self.Arbeit2BtnOut.setTitle(Arbeit2ButtonName, for: .normal)
            }
        }
        ref.child("arbeiten").child("Arbeit3").child("buttonname").observe(.value) { Arbeit3ButtonSnap in
            let Arbeit3ButtonName = Arbeit3ButtonSnap.value as? String
            UserDefaults.standard.set(Arbeit3ButtonName, forKey: "UDTEST3Btn")
            if Arbeit3ButtonName != "-" {
                self.Arbeit3BtnOut.isEnabled = true
                self.Arbeit3BtnOut.setTitle(Arbeit3ButtonName, for: .normal)
            }
            if Arbeit3ButtonName == "-" {
                self.Arbeit3BtnOut.isEnabled = false
                self.Arbeit3BtnOut.setTitle(Arbeit3ButtonName, for: .normal)
            }
        }
        ref.child("arbeiten").child("Arbeit4").child("buttonname").observe(.value) { Arbeit4ButtonSnap in
            let Arbeit4ButtonName = Arbeit4ButtonSnap.value as? String
            UserDefaults.standard.set(Arbeit4ButtonName, forKey: "UDTEST4Btn")
            if Arbeit4ButtonName != "-" {
                self.Arbeit4BtnOut.isEnabled = true
                self.Arbeit4BtnOut.setTitle(Arbeit4ButtonName, for: .normal)
            }
            if Arbeit4ButtonName == "-" {
                self.Arbeit4BtnOut.isEnabled = false
                self.Arbeit4BtnOut.setTitle(Arbeit4ButtonName, for: .normal)
            }
        }
        ref.child("arbeiten").child("Arbeit5").child("buttonname").observe(.value) { Arbeit5ButtonSnap in
            let Arbeit5ButtonName = Arbeit5ButtonSnap.value as? String
            UserDefaults.standard.set(Arbeit5ButtonName, forKey: "UDTEST5Btn")
            if Arbeit5ButtonName != "-" {
                self.Arbeit5BtnOut.isEnabled = true
                self.Arbeit5BtnOut.setTitle(Arbeit5ButtonName, for: .normal)
            }
            if Arbeit5ButtonName == "-" {
                self.Arbeit5BtnOut.isEnabled = false
                self.Arbeit5BtnOut.setTitle(Arbeit5ButtonName, for: .normal)
            }
        }
    }
}
