//
//  NewsTeaViewController.swift
//  KlassenAppD
//
//  Created by Adrian Baumgart on 06.07.18.
//  Copyright © 2018 Adrian Baumgart. All rights reserved.
//

import UIKit
import FirebaseDatabase

class NewsTeaViewController: UIViewController {

    @IBOutlet weak var NewsTeaDes: UITextView!
    @IBOutlet weak var NewsTeaLabel: UILabel!
    @IBOutlet weak var NewsTeaLDes: UITextView!
    @IBOutlet weak var backgroundTitleView: UIView!
    @IBAction func UploadNewsBtn(_ sender: Any)
    {
   
        var ref: DatabaseReference!
        
        ref = Database.database().reference()
        
        ref.child("news").child("newsL").setValue(NewsTeaLDes.text!) {
            (error:Error?, ref:DatabaseReference) in
            if let error = error {
                print("Data could not be saved: \(error).")
            } else {
                print("Data saved successfully!")
            }
        }
        ref.child("news").child("newsL").observeSingleEvent(of: .value) { (NewsTeaSnap) in
            let NewsTeaLEL = NewsTeaSnap.value as? String
            self.NewsTeaLDes.text = NewsTeaLEL
        }
    }
    @IBAction func ChangetoSuS(_ sender: Any)
    {
        self.changeAlert(title: "Achtung", message: "Wenn sie zur Schüleransicht wechseln, müssen sie sich für den Bearbeitungsmodus nochmals anmelden")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if UserDefaults.standard.integer(forKey: "DarkmodeStatus") == 1 {
            view.backgroundColor = UIColor(red:0.05, green:0.05, blue:0.05, alpha:1.0)
            backgroundTitleView.backgroundColor = UIColor(red:0.13, green:0.13, blue:0.13, alpha:1.0)
            NewsTeaDes.textColor = UIColor.white
            NewsTeaLabel.textColor = UIColor.white
            NewsTeaDes.backgroundColor = UIColor(red:0.05, green:0.05, blue:0.05, alpha:1.0)
            NewsTeaLDes.backgroundColor = UIColor(red:0.05, green:0.05, blue:0.05, alpha:1.0)
            NewsTeaLDes.textColor = UIColor.white
            UIApplication.shared.statusBarStyle = .lightContent
        }
        
        if UserDefaults.standard.integer(forKey: "DarkmodeStatus") == 0 {
            view.backgroundColor = UIColor.white
             backgroundTitleView.backgroundColor = UIColor(red:0.97, green:0.97, blue:0.97, alpha:0.8)
            NewsTeaDes.textColor = UIColor.black
            NewsTeaLabel.textColor = UIColor.black
            NewsTeaDes.backgroundColor = UIColor.white
            NewsTeaLDes.backgroundColor = UIColor.white
            NewsTeaLDes.textColor = UIColor.black
            UIApplication.shared.statusBarStyle = .default
        }
        // Do any additional setup after loading the view.
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return UIStatusBarStyle(rawValue: UserDefaults.standard.integer(forKey: "DarkmodeStatus"))!
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        var ref: DatabaseReference!
        
        ref = Database.database().reference()
        
        ref.child("news").child("news1").observeSingleEvent(of: .value) { (NewsTeaSnap) in
            let NewsTeaLE = NewsTeaSnap.value as? String
            self.NewsTeaDes.text = "News von den Administratoren: " + NewsTeaLE!
        }
        
        ref.child("news").child("newsL").observeSingleEvent(of: .value) { (NewsLTeaSnap) in
            let NewaTeaLEL = NewsLTeaSnap.value as? String
            self.NewsTeaLDes.text = NewaTeaLEL
        }
        
        if FirstViewController.LastVC.LastVCV == "infos" {
            FirstViewController.LastVC.LastVCV = "0"
            self.tabBarController?.selectedIndex = 1
        }
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    func changeAlert (title: String, message:String) {
        let CHA = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        CHA.addAction(UIAlertAction(title: "Weiter", style: UIAlertAction.Style.default, handler: { (alertButtonClicked) in
            UserDefaults.standard.set(1, forKey: "Checker")
            UserDefaults.standard.set("0", forKey: "TEALOGGER")
            self.performSegue(withIdentifier: "changetosussegue", sender: nil)
        }))
        CHA.addAction(UIAlertAction(title: "Abbrechen", style: UIAlertAction.Style.default, handler: { (alertButtonClicked) in
            CHA.dismiss(animated: true, completion: nil)
        }))
        self.present(CHA, animated: true, completion: nil)
    }
}
