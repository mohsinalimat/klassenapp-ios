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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        swipeAnimatedTransitioning?.animationType = SwipeAnimationType.sideBySide
        
        changeAppearance()
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
        
        guard let idx = tabBar.items?.firstIndex(of: item), tabBar.subviews.count > idx + 1, let imageView = tabBar.subviews[idx + 1].subviews.compactMap({ $0 as? UIImageView }).first else {
            return
        }
        
        imageView.layer.add(bounceAnimation, forKey: nil)
    }
}
