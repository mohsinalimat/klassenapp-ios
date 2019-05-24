//
//  LaunchAnimationViewController.swift
//  KlassenAppD
//
//  Created by Adrian Baumgart on 04.10.18.
//  Copyright © 2018 Adrian Baumgart. All rights reserved.
//

import UIKit
import RevealingSplashView

class LaunchAnimationViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        if UserDefaults.standard.integer(forKey: "DarkmodeStatus") == 1 {
            view.backgroundColor = UIColor(red:0.05, green:0.05, blue:0.05, alpha:1.0)
            UIApplication.shared.statusBarStyle = .lightContent
        }
        if UserDefaults.standard.integer(forKey: "DarkmodeStatus") == 0 {
            view.backgroundColor = UIColor.white
            UIApplication.shared.statusBarStyle = .default
        }
        let revealingSplashView = RevealingSplashView(iconImage: UIImage(named: "LaunchScreenW")!,iconInitialSize: CGSize(width: 300, height: 300), backgroundColor: UIColor(red: 0, green: 0, blue: 0, alpha: 1.0))
        revealingSplashView.duration = 1
      //  revealingSplashView.animationType = .rotateOut
        //revealingSplashView.animationType = SplashAnimationType.squeezeAndZoomOut
      //  revealingSplashView.animationType = SplashAnimationType.rotateOut
        
        //Adds the revealing splash view as a sub view
        self.view.addSubview(revealingSplashView)
        //Starts animation
       // sleep(1)
        revealingSplashView.startAnimation(){
            print("Completed")
            if UserDefaults.standard.string(forKey: "WelcomeTour") != "done" {
                // self.performSegue(withIdentifier: "startwelcomeTourSegue", sender: nil)
                let vc = (self.storyboard?.instantiateViewController(withIdentifier: "welcome1"))!
                self.present(vc, animated: true)
            }
            else if UserDefaults.standard.integer(forKey: "Checker") == 1 {
                //   self.performSegue(withIdentifier: "logintohome", sender: nil)
             /*   let vc = (self.storyboard?.instantiateViewController(withIdentifier: "homeID"))!
                self.present(vc, animated: true)*/
                self.performSegue(withIdentifier: "directtotb", sender: nil)
            }
            else {
                self.performSegue(withIdentifier: "launchanimationfinish", sender: nil)
            }
        }
        // Do any additional setup after loading the view.
    }
    
//launchanimationfinish
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
