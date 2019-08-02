//
//  WholeTabBarController.swift
//  KlassenAppD
//
//  Created by Adrian Baumgart on 14.07.18.
//  Copyright © 2018 Adrian Baumgart. All rights reserved.
//

import SwipeableTabBarController
import UIKit

class WholeTabBarController: SwipeableTabBarController {
    var style = Appearances()
    
    /* override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
         super.traitCollectionDidChange(previousTraitCollection)
     
         if #available(iOS 12.0, *) {
             let userInterfaceStyle = traitCollection.userInterfaceStyle
     
             if userInterfaceStyle == .dark {
                 UserDefaults.standard.set(1, forKey: "DarkmodeStatus")
                  tabBar.barTintColor = style.darkBarTintColor
                  tabBar.tintColor = style.darkTintColor
                  self.setNeedsStatusBarAppearanceUpdate()
             }
             else if userInterfaceStyle == .light || userInterfaceStyle == .unspecified {
                 UserDefaults.standard.set(0, forKey: "DarkmodeStatus")
                  tabBar.barTintColor = style.lightBarTintColor
                  tabBar.tintColor = style.lightTintColor
                  self.setNeedsStatusBarAppearanceUpdate()
             }
     
         } else {
             // Fallback on earlier versions
         }
     
     } */
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        swipeAnimatedTransitioning?.animationType = SwipeAnimationType.sideBySide
        
      /*  if UserDefaults.standard.integer(forKey: "DarkmodeStatus") == 1 {
            tabBar.barTintColor = style.darkBarTintColor
            tabBar.tintColor = style.darkTintColor
        }
        if UserDefaults.standard.integer(forKey: "DarkmodeStatus") == 0 {
            tabBar.barTintColor = style.lightBarTintColor
            tabBar.tintColor = style.lightTintColor
        }*/
        
        changeAppearance()
        
        let tabBarItems = tabBar.items! as [UITabBarItem]
        //   tabBarItems[0].imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0)
        //  tabBarItems[1].imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0)
        // tabBarItems[2].imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0)
        //   tabBarItems[3].imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0)
        //   tabBarItems[4].imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0)
    }
    
     func changeAppearance() {
           if UserDefaults.standard.integer(forKey: "AutoAppearance") == 1 {
               if #available(iOS 13.0, *) {
                   if traitCollection.userInterfaceStyle == .dark {
                       tabBar.barTintColor = style.darkBarTintColor
                       tabBar.tintColor = style.darkTintColor
                   }
                   else if traitCollection.userInterfaceStyle == .light || traitCollection.userInterfaceStyle == .unspecified {
                       tabBar.barTintColor = style.lightBarTintColor
                       tabBar.tintColor = style.lightTintColor
                   }
               }
           }
           else {
               if UserDefaults.standard.integer(forKey: "DarkmodeStatus") == 1 {
                   tabBar.barTintColor = style.darkBarTintColor
                   tabBar.tintColor = style.darkTintColor
               }
               else if UserDefaults.standard.integer(forKey: "DarkmodeStatus") == 0 {
                   tabBar.barTintColor = style.lightBarTintColor
                   tabBar.tintColor = style.lightTintColor
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
           else {
               // Fallback on earlier versions
           }
       }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    private var bounceAnimation: CAKeyframeAnimation = {
        let bounceAnimation = CAKeyframeAnimation(keyPath: "transform.scale")
        bounceAnimation.values = [1.0, 1.07, 0.94, 1.02, 1.0]
        bounceAnimation.duration = TimeInterval(0.2)
        bounceAnimation.calculationMode = CAAnimationCalculationMode.cubic
        return bounceAnimation
    }()
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        let impactFeedbackgenerator = UIImpactFeedbackGenerator(style: .light)
        impactFeedbackgenerator.prepare()
        impactFeedbackgenerator.impactOccurred()
        
        guard let idx = tabBar.items?.index(of: item), tabBar.subviews.count > idx + 1, let imageView = tabBar.subviews[idx + 1].subviews.compactMap({ $0 as? UIImageView }).first else {
            return
        }
        
        imageView.layer.add(bounceAnimation, forKey: nil)
    }
}
