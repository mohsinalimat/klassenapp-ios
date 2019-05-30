//
//  WholeTabBarController.swift
//  KlassenAppD
//
//  Created by Adrian Baumgart on 14.07.18.
//  Copyright © 2018 Adrian Baumgart. All rights reserved.
//

import UIKit
import SwipeableTabBarController

class WholeTabBarController: SwipeableTabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        //setSwipeAnimation(type: SwipeAnimationType.sideBySide)
        swipeAnimatedTransitioning?.animationType = SwipeAnimationType.sideBySide
        if UserDefaults.standard.integer(forKey: "DarkmodeStatus") == 1 {
            self.tabBar.barTintColor = .black
            tabBar.tintColor = UIColor(red:1.00, green:0.58, blue:0.00, alpha:1.0)
        }
        if UserDefaults.standard.integer(forKey: "DarkmodeStatus") == 0 {
            self.tabBar.barTintColor = .white
            tabBar.tintColor = UIColor(red:0.00, green:0.48, blue:1.00, alpha:1.0)
        }
        let tabBarItems = tabBar.items! as [UITabBarItem]
        tabBarItems[0].imageInsets = UIEdgeInsets(top: 6,left: 0,bottom: -6,right: 0)
        tabBarItems[1].imageInsets = UIEdgeInsets(top: 6,left: 0,bottom: -6,right: 0)
        tabBarItems[2].imageInsets = UIEdgeInsets(top: 6,left: 0,bottom: -6,right: 0)
        tabBarItems[3].imageInsets = UIEdgeInsets(top: 6,left: 0,bottom: -6,right: 0)
        tabBarItems[4].imageInsets = UIEdgeInsets(top: 6,left: 0,bottom: -6,right: 0)

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
       
    }
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        let impactFeedbackgenerator = UIImpactFeedbackGenerator(style: .light)
        impactFeedbackgenerator.prepare()
        impactFeedbackgenerator.impactOccurred()
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
