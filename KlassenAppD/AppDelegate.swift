//
//  AppDelegate.swift
//  KlassenAppD
//
//  Created by Adrian Baumgart on 09.04.18.
//  Copyright © 2018 Adrian Baumgart. All rights reserved.
//

import UIKit
import Firebase
import UserNotifications
import Fabric
import Crashlytics
import FirebaseDatabase
import FirebaseFunctions
import FirebaseInstanceID
import FirebaseMessaging
import AppCenter
import AppCenterAnalytics
import AppCenterCrashes
import AppCenterPush
import StatusBarOverlay

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
        var databasekeys: [String] = [] //Array for all References in the Database
    var window: UIWindow?
    let network: NetworkManager = NetworkManager.sharedInstance
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
                
        FirebaseApp.configure()
       // MSPush.setDelegate(self as! MSPushDelegate)
        MSPush.setEnabled(true)
        MSAppCenter.start("1859318b-9a51-4324-baf1-f7dc7bea9f52", withServices:[
            MSAnalytics.self,
            MSCrashes.self,
            MSPush.self
            ])
        let enabled = MSPush.isEnabled()
        print("MSPUSH ENABLED: \(enabled)")
      /*  if #available(iOS 10.0, *) {
            UNUserNotificationCenter.current().delegate = self as? UNUserNotificationCenterDelegate
            
            let authOptions: UNAuthorizationOptions = [.badge, .sound, .alert]
            UNUserNotificationCenter.current().requestAuthorization(options: authOptions) { (_, _) in}
        } else {
            let settings: UIUserNotificationSettings = UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
            application.registerUserNotificationSettings(settings)
        }
        
        application.registerForRemoteNotifications()
        Messaging.messaging().delegate = self*/
        //Messaging.messaging().shouldEstablishDirectChannel = true
        
      //  UIApplication.shared.setMinimumBackgroundFetchInterval(UIApplication.backgroundFetchIntervalMinimum)

     //   Database.database().isPersistenceEnabled = true
        Fabric.with([Crashlytics.self])
       /* if #available(iOS 10.0, *) {
            let center = UNUserNotificationCenter.current()
            let options: UNAuthorizationOptions = [.alert, .sound];
            center.requestAuthorization(options: options) {
                (granted, error) in
                if !granted {
                    print("Something went wrong")
                }
            }
        } else {
            // Fallback on earlier versions
        }*/
        
    
         //CCPClient.initApp(appId: "6346990561630613504")
       // SBDMain.initWithApplicationId("9A79C5F9-FD9F-4130-8ED6-12EA53D2DAC4")
      /*  var ref: DatabaseReference!
        
        ref = Database.database().reference()
        
        NetworkManager.isReachable { (_) in
            ref.child("homework").child("Week1").child("Datum").observeSingleEvent(of: .value) { (Week1DatumSnap) in
                let Week1DatumLE = Week1DatumSnap.value as? String
                UserDefaults.standard.set(Week1DatumLE, forKey: "UDW1Btn")
            }
            ref.child("homework").child("Week2").child("Datum").observeSingleEvent(of: .value) { (Week2DatumSnap) in
                let Week2DatumLE = Week2DatumSnap.value as? String
                UserDefaults.standard.set(Week2DatumLE, forKey: "UDW2Btn")
            }
            ref.child("homework").child("Week3").child("Datum").observeSingleEvent(of: .value) { (Week3DatumSnap) in
                let Week3DatumLE = Week3DatumSnap.value as? String
                UserDefaults.standard.set(Week3DatumLE, forKey: "UDW3Btn")
            }
            ref.child("homework").child("Week4").child("Datum").observeSingleEvent(of: .value) { (Week4DatumSnap) in
                let Week4DatumLE = Week4DatumSnap.value as? String
                UserDefaults.standard.set(Week4DatumLE, forKey: "UDW4Btn")
            }
            //TestsViewControllerMain
            ref.child("arbeiten").child("Arbeit1").child("buttonname").observeSingleEvent(of: .value) { (Arbeit1ButtonSnap) in
                let Arbeit1ButtonName = Arbeit1ButtonSnap.value as? String
                UserDefaults.standard.set(Arbeit1ButtonName, forKey: "UDTEST1Btn")
            }
            ref.child("arbeiten").child("Arbeit2").child("buttonname").observeSingleEvent(of: .value) { (Arbeit2ButtonSnap) in
                let Arbeit2ButtonName = Arbeit2ButtonSnap.value as? String
                UserDefaults.standard.set(Arbeit2ButtonName, forKey: "UDTEST2Btn")
            }
            ref.child("arbeiten").child("Arbeit3").child("buttonname").observeSingleEvent(of: .value) { (Arbeit3ButtonSnap) in
                let Arbeit3ButtonName = Arbeit3ButtonSnap.value as? String
                UserDefaults.standard.set(Arbeit3ButtonName, forKey: "UDTEST3Btn")
            }
            ref.child("arbeiten").child("Arbeit4").child("buttonname").observeSingleEvent(of: .value) { (Arbeit4ButtonSnap) in
                let Arbeit4ButtonName = Arbeit4ButtonSnap.value as? String
                UserDefaults.standard.set(Arbeit4ButtonName, forKey: "UDTEST4Btn")
            }
            ref.child("arbeiten").child("Arbeit5").child("buttonname").observeSingleEvent(of: .value) { (Arbeit5ButtonSnap) in
                let Arbeit5ButtonName = Arbeit5ButtonSnap.value as? String
                UserDefaults.standard.set(Arbeit5ButtonName, forKey: "UDTEST5Btn")
            }
            
            //NewsViewController
            ref.child("news").child("news1").observeSingleEvent(of: .value, with: { (NewsSnap) in
                let NewsLE = NewsSnap.value as? String
                UserDefaults.standard.set(NewsLE, forKey: "NEWSADMIN")
                ref.child("news").child("newsL").observeSingleEvent(of: .value, with: { (NewsLSnap) in
                    let NewsLLE = NewsLSnap.value as? String
                    UserDefaults.standard.set(NewsLLE, forKey: "NEWSLEHRER")
                })
            })
            //Test1ViewController
            ref.child("arbeiten").child("Arbeit1").child("label").observeSingleEvent(of: .value) { (LabelT1Snap) in
                let LabelT1LE = LabelT1Snap.value as? String
                UserDefaults.standard.set(LabelT1LE, forKey: "UDT1LABEL")
            }
            ref.child("arbeiten").child("Arbeit1").child("beschreibung").observeSingleEvent(of: .value) { (DesT1Snap) in
                let DesT1LE = DesT1Snap.value as? String
                UserDefaults.standard.set(DesT1LE, forKey: "UDT1DES")
            }
            //Test2ViewController
            ref.child("arbeiten").child("Arbeit2").child("label").observeSingleEvent(of: .value) { (LabelT2Snap) in
                let LabelT2LE = LabelT2Snap.value as? String
                UserDefaults.standard.set(LabelT2LE, forKey: "UDT2LABEL")
            }
            ref.child("arbeiten").child("Arbeit2").child("beschreibung").observeSingleEvent(of: .value) { (DesT2Snap) in
                let DesT2LE = DesT2Snap.value as? String
                UserDefaults.standard.set(DesT2LE, forKey: "UDT2DES")
            }
            //Test3ViewController
            ref.child("arbeiten").child("Arbeit3").child("label").observeSingleEvent(of: .value) { (LabelT3Snap) in
                let LabelT3LE = LabelT3Snap.value as? String
                UserDefaults.standard.set(LabelT3LE, forKey: "UDT3LABEL")
            }
            ref.child("arbeiten").child("Arbeit3").child("beschreibung").observeSingleEvent(of: .value) { (DesT3Snap) in
                let DesT3LE = DesT3Snap.value as? String
                UserDefaults.standard.set(DesT3LE, forKey: "UDT3DES")
            }
            //Test4ViewController
            ref.child("arbeiten").child("Arbeit4").child("label").observeSingleEvent(of: .value) { (LabelT4Snap) in
                let LabelT4LE = LabelT4Snap.value as? String
                UserDefaults.standard.set(LabelT4LE, forKey: "UDT4LABEL")
            }
            ref.child("arbeiten").child("Arbeit4").child("beschreibung").observeSingleEvent(of: .value) { (DesT4Snap) in
                let DesT4LE = DesT4Snap.value as? String
                UserDefaults.standard.set(DesT4LE, forKey: "UDT4DES")
            }
            //Test5ViewController
            ref.child("arbeiten").child("Arbeit5").child("label").observeSingleEvent(of: .value) { (LabelT5Snap) in
                let LabelT5LE = LabelT5Snap.value as? String
                UserDefaults.standard.set(LabelT5LE, forKey: "UDT5LABEL")
            }
            ref.child("arbeiten").child("Arbeit5").child("beschreibung").observeSingleEvent(of: .value) { (DesT5Snap) in
                let DesT5LE = DesT5Snap.value as? String
                UserDefaults.standard.set(DesT5LE, forKey: "UDT5DES")
            }
            //Week1ViewController
            ref.child("homework").child("Week1").child("Monday").observeSingleEvent(of: .value) { (MondayWeek1Snap) in
                let MondayWeek1Home = MondayWeek1Snap.value as? String
                UserDefaults.standard.set(MondayWeek1Home, forKey: "UDW1MO")
            }
            ref.child("homework").child("Week1").child("Tuesday").observeSingleEvent(of: .value) { (TuesdayWeek1Snap) in
                let TuesdayWeek1Home = TuesdayWeek1Snap.value as? String
                UserDefaults.standard.set(TuesdayWeek1Home, forKey: "UDW1TU")
            }
            ref.child("homework").child("Week1").child("Wednesday").observeSingleEvent(of: .value) { (WednesdayWeek1Snap) in
                let WednesdayWeek1Home = WednesdayWeek1Snap.value as? String
                UserDefaults.standard.set(WednesdayWeek1Home, forKey: "UDW1WE")
            }
            ref.child("homework").child("Week1").child("Thursday").observeSingleEvent(of: .value) { (ThursdayWeek1Snap) in
                let ThursdayWeek1Home = ThursdayWeek1Snap.value as? String
                UserDefaults.standard.set(ThursdayWeek1Home, forKey: "UDW1TH")
            }
            ref.child("homework").child("Week1").child("Friday").observeSingleEvent(of: .value) { (FridayWeek1Snap) in
                let FridayWeek1Home = FridayWeek1Snap.value as? String
                UserDefaults.standard.set(FridayWeek1Home, forKey: "UDW1FR")
            }
            ref.child("homework").child("Week1").child("Datum").observeSingleEvent(of: .value) { (DateWeek1Snap) in
                let DateWeek1LE = DateWeek1Snap.value as? String
                UserDefaults.standard.set(DateWeek1LE, forKey: "UDW1DA")
            }
            //Week2ViewController
            ref.child("homework").child("Week2").child("Monday").observeSingleEvent(of: .value) { (MondayWeek2Snap) in
                let MondayWeek2Home = MondayWeek2Snap.value as? String
                UserDefaults.standard.set(MondayWeek2Home, forKey: "UDW2MO")
            }
            ref.child("homework").child("Week2").child("Tuesday").observeSingleEvent(of: .value) { (TuesdayWeek2Snap) in
                let TuesdayWeek2Home = TuesdayWeek2Snap.value as? String
                UserDefaults.standard.set(TuesdayWeek2Home, forKey: "UDW2TU")
            }
            ref.child("homework").child("Week2").child("Wednesday").observeSingleEvent(of: .value) { (WednesdayWeek2Snap) in
                let WednesdayWeek2Home = WednesdayWeek2Snap.value as? String
                UserDefaults.standard.set(WednesdayWeek2Home, forKey: "UDW2WE")
            }
            ref.child("homework").child("Week2").child("Thursday").observeSingleEvent(of: .value) { (ThursdayWeek2Snap) in
                let ThursdayWeek2Home = ThursdayWeek2Snap.value as? String
                UserDefaults.standard.set(ThursdayWeek2Home, forKey: "UDW2TH")
            }
            ref.child("homework").child("Week2").child("Friday").observeSingleEvent(of: .value) { (FridayWeek2Snap) in
                let FridayWeek2Home = FridayWeek2Snap.value as? String
                UserDefaults.standard.set(FridayWeek2Home, forKey: "UDW2FR")
            }
            ref.child("homework").child("Week2").child("Datum").observeSingleEvent(of: .value) { (DateWeek2Snap) in
                let DateWeek2LE = DateWeek2Snap.value as? String
                UserDefaults.standard.set(DateWeek2LE, forKey: "UDW2DA")
            }
            //Week3ViewController
            ref.child("homework").child("Week3").child("Monday").observeSingleEvent(of: .value) { (MondayWeek3Snap) in
                let MondayWeek3Home = MondayWeek3Snap.value as? String
                UserDefaults.standard.set(MondayWeek3Home, forKey: "UDW3MO")
            }
            ref.child("homework").child("Week3").child("Tuesday").observeSingleEvent(of: .value) { (TuesdayWeek3Snap) in
                let TuesdayWeek3Home = TuesdayWeek3Snap.value as? String
                UserDefaults.standard.set(TuesdayWeek3Home, forKey: "UDW3TU")
            }
            ref.child("homework").child("Week3").child("Wednesday").observeSingleEvent(of: .value) { (WednesdayWeek3Snap) in
                let WednesdayWeek3Home = WednesdayWeek3Snap.value as? String
                UserDefaults.standard.set(WednesdayWeek3Home, forKey: "UDW3WE")
            }
            ref.child("homework").child("Week3").child("Thursday").observeSingleEvent(of: .value) { (ThursdayWeek3Snap) in
                let ThursdayWeek3Home = ThursdayWeek3Snap.value as? String
                UserDefaults.standard.set(ThursdayWeek3Home, forKey: "UDW3TH")
            }
            ref.child("homework").child("Week3").child("Friday").observeSingleEvent(of: .value) { (FridayWeek3Snap) in
                let FridayWeek3Home = FridayWeek3Snap.value as? String
                UserDefaults.standard.set(FridayWeek3Home, forKey: "UDW3FR")
            }
            ref.child("homework").child("Week3").child("Datum").observeSingleEvent(of: .value) { (DateWeek3Snap) in
                let DateWeek3LE = DateWeek3Snap.value as? String
                UserDefaults.standard.set(DateWeek3LE, forKey: "UDW3DA")
            }
            //Week4ViewController
            ref.child("homework").child("Week4").child("Monday").observeSingleEvent(of: .value) { (MondayWeek4Snap) in
                let MondayWeek4Home = MondayWeek4Snap.value as? String
                UserDefaults.standard.set(MondayWeek4Home, forKey: "UDW4MO")
            }
            ref.child("homework").child("Week4").child("Tuesday").observeSingleEvent(of: .value) { (TuesdayWeek4Snap) in
                let TuesdayWeek4Home = TuesdayWeek4Snap.value as? String
                UserDefaults.standard.set(TuesdayWeek4Home, forKey: "UDW4TU")
            }
            ref.child("homework").child("Week4").child("Wednesday").observeSingleEvent(of: .value) { (WednesdayWeek4Snap) in
                let WednesdayWeek4Home = WednesdayWeek4Snap.value as? String
                UserDefaults.standard.set(WednesdayWeek4Home, forKey: "UDW4WE")
            }
            ref.child("homework").child("Week4").child("Thursday").observeSingleEvent(of: .value) { (ThursdayWeek4Snap) in
                let ThursdayWeek4Home = ThursdayWeek4Snap.value as? String
                UserDefaults.standard.set(ThursdayWeek4Home, forKey: "UDW4TH")
            }
            ref.child("homework").child("Week4").child("Friday").observeSingleEvent(of: .value) { (FridayWeek4Snap) in
                let FridayWeek4Home = FridayWeek4Snap.value as? String
                UserDefaults.standard.set(FridayWeek4Home, forKey: "UDW4FR")
            }
            ref.child("homework").child("Week4").child("Datum").observeSingleEvent(of: .value) { (DateWeek4Snap) in
                let DateWeek4LE = DateWeek4Snap.value as? String
                UserDefaults.standard.set(DateWeek4LE, forKey: "UDW4DA")
            }
            //FoodViewControllerMain
            ref.child("Speiseplan").child("Datum").observeSingleEvent(of: .value) { (FoodDateSnap) in
                let FoodDateLE = FoodDateSnap.value as? String
                UserDefaults.standard.set(FoodDateLE, forKey: "FOODDATEUD")
            }
            //FoodMoViewController
            ref.child("Speiseplan").child("monday").observeSingleEvent(of: .value) { (FoodMondaySnap) in
                let FoodMondayLE = FoodMondaySnap.value as? String
                UserDefaults.standard.set(FoodMondayLE, forKey: "UDFOODMO")
            }
            //FoodTuViewController
            ref.child("Speiseplan").child("Tuesday").observeSingleEvent(of: .value) { (FoodTuesdaySnap) in
                let FoodTuesdayLE = FoodTuesdaySnap.value as? String
                UserDefaults.standard.set(FoodTuesdayLE, forKey: "UDFOODTU")
            }
            //FoodWeViewController
            ref.child("Speiseplan").child("Wednesday").observeSingleEvent(of: .value) { (FoodWednesdaySnap) in
                let FoodWednesdayLE = FoodWednesdaySnap.value as? String
                UserDefaults.standard.set(FoodWednesdayLE, forKey: "UDFOODWE")
            }
            //FoodThViewController
            ref.child("Speiseplan").child("Thursday").observeSingleEvent(of: .value) { (FoodThursdaySnap) in
                let FoodThursdayLE = FoodThursdaySnap.value as? String
                UserDefaults.standard.set(FoodThursdayLE, forKey: "UDFOODTH")
            }
            //FoodFrViewController
            ref.child("Speiseplan").child("Friday").observeSingleEvent(of: .value) { (FoodFridaySnap) in
                let FoodFridayLE = FoodFridaySnap.value as? String
                UserDefaults.standard.set(FoodFridayLE, forKey: "UDFOODFR")
            }
        }*/
        //Download entire Database
        //HomeworkViewControllerMain
        
        
        return true
    }
    
   /* func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String) {
        let VC: FirstViewController = FirstViewController()
        let token: [String: AnyObject] = [Messaging.messaging().fcmToken!: Messaging.messaging().fcmToken as AnyObject]
        VC.postToken(Token: token)
    }
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        //When the notifications of this code worked well, there was not yet.
        Messaging.messaging().apnsToken = deviceToken
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        
        print(" Entire message \(userInfo)")
        print("Article avaialble for download: \(userInfo["articleId"]!)")
        
        let state : UIApplication.State = application.applicationState
        switch state {
        case UIApplication.State.active:
            print("If needed notify user about the message")
        default:
            print("Run code to download content")
        }
        
        completionHandler(UIBackgroundFetchResult.newData)
    }
    
    func messaging(_ messaging: Messaging, didReceive remoteMessage: MessagingRemoteMessage) {
        print("34r343409404384903870")
    }*/
    
    func application(_ application: UIApplication, continue userActivity: NSUserActivity, restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void) -> Bool {
        if userActivity.activityType == "com.adrianbaumgart.KlassenAppDREA1234.SiriShortcutHomework" {
            let mainStoryboardIpad : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let initialViewControlleripad : UIViewController = mainStoryboardIpad.instantiateViewController(withIdentifier: "Week1SiriStory") as UIViewController
            self.window = UIWindow(frame: UIScreen.main.bounds)
            self.window?.rootViewController = initialViewControlleripad
            self.window?.makeKeyAndVisible()
            if let WEEK1VC = window?.rootViewController as? Woche1ViewController {
                WEEK1VC.calledViaSiriShortcutHW1()
            }
    }
        if userActivity.activityType == "com.adrianbaumgart.KlassenAppDREA1234.SiriShortcutNextTest" {
            let mainStoryboardIpad : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let initialViewControlleripad : UIViewController = mainStoryboardIpad.instantiateViewController(withIdentifier: "Test1SiriStory") as UIViewController
            self.window = UIWindow(frame: UIScreen.main.bounds)
            self.window?.rootViewController = initialViewControlleripad
            self.window?.makeKeyAndVisible()
            if let TEST1VC = window?.rootViewController as? Test1ViewController {
                TEST1VC.calledViaSiriShortcutTest1()
            }
        }
        
        return false
}
    
    /*func push(_ push: MSPush!, didReceive pushNotification: MSPushNotification!) {
        let title: String = pushNotification.title ?? ""
        var message: String = pushNotification.message ?? ""
        var customData: String = ""
        for item in pushNotification.customData {
            customData =  ((customData.isEmpty) ? "" : "\(customData), ") + "\(item.key): \(item.value)"
        }
        if (UIApplication.shared.applicationState == .background) {
            NSLog("Notification received in background, title: \"\(title)\", message: \"\(message)\", custom data: \"\(customData)\"");
        } else {
            message =  message + ((customData.isEmpty) ? "" : "\n\(customData)")
            
            let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .cancel))
            
            // Show the alert controller.
            self.window?.rootViewController?.present(alertController, animated: true)
        }
    }*/
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }
    
  /*  func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String) {
        let VC: FirstViewController = FirstViewController()
        let token:[String: AnyObject] = [Messaging.messaging().fcmToken!: Messaging.messaging().fcmToken as AnyObject]
        VC.postToken(Token: token)
    }
   
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any]) {
        print("HALLOWELT: \(userInfo)")
    }
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        // Convert token to string
        let deviceTokenString = deviceToken.reduce("", {$0 + String(format: "%02X", $1)})
        print("APNs device token: \(deviceTokenString)")
        //Messaging.messaging().setAPNSToken(deviceToken, type: MessagingAPNSTokenType.sandbox)
        Messaging.messaging().subscribe(toTopic: "/chat")
        
        // Persist it in your backend in case it's new
        UserDefaults.standard.set(deviceTokenString, forKey: "PushDeviceTokenString")
    }*/
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     
        
        
    }

   /* func application(_ application: UIApplication,
                     performFetchWithCompletionHandler completionHandler:
        @escaping (UIBackgroundFetchResult) -> Void) {
        // Check for new data.
        print("1111")
        var ref: DatabaseReference!
        
        ref = Database.database().reference()
        ref.child("chat").observe(.childChanged) { (SNAPPER) in
            ref.child("chat").child(SNAPPER.key).observeSingleEvent(of: .value, with: { (SNA) in
                print("3354")
                if let item = SNA.value as? [String:AnyObject]{
                    self.databasekeys = Array(item.keys) //Download members of List
                    // print(self.databasekeys)
                    //for key in self.databasekeys {
                    var iS = item["sender"] as? String
                    var iM = item["message"] as? String
                    var iT = item["timestamp"] as? String
                    //var fullMessage = "\(iT) | \(iS) | \(iM)"
                    //   self.fullList.append(fullMessage)
                    
                    // var iMString = String(iM ?? 0)
                    /* self.itemSender.append(iS!)
                     self.itemMessage.append(iM ?? "")
                     self.itemTimestamp.append(iT ?? "")*/
                    if #available(iOS 10.0, *) {
                        let content = UNMutableNotificationContent()
                        content.title = "\(iS!) @ Chat"
                        content.body = iM ?? "HI"
                        content.sound = UNNotificationSound.default
                        let trigger = UNTimeIntervalNotificationTrigger(
                            timeInterval: 1.0,
                            repeats: false)
                        
                        let request = UNNotificationRequest.init(identifier: "testTriggerNotif", content: content, trigger: trigger)
                        
                        let center = UNUserNotificationCenter.current()
                        center.add(request)
                    } else {
                        // Fallback on earlier versions
                    }
                    
                    
                    //}
                }
            })
            
        }
        completionHandler(.newData)
    }*/
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        if url.absoluteString == "klassenapp://Homework1" {
            if UserDefaults.standard.integer(forKey: "Checker") == 1 {
                let mainStoryboardIpad : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let initialViewControlleripad : UIViewController = mainStoryboardIpad.instantiateViewController(withIdentifier: "Week1SiriStory") as UIViewController
                self.window = UIWindow(frame: UIScreen.main.bounds)
                self.window?.rootViewController = initialViewControlleripad
                self.window?.makeKeyAndVisible()
            }
    }
        if url.absoluteString == "klassenapp://Homework2" {
            if UserDefaults.standard.integer(forKey: "Checker") == 1 {
                let mainStoryboardIpad : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let initialViewControlleripad : UIViewController = mainStoryboardIpad.instantiateViewController(withIdentifier: "HW2ID") as UIViewController
                self.window = UIWindow(frame: UIScreen.main.bounds)
                self.window?.rootViewController = initialViewControlleripad
                self.window?.makeKeyAndVisible()
            }
    }
        if url.absoluteString == "klassenapp://Homework3" {
            if UserDefaults.standard.integer(forKey: "Checker") == 1 {
                let mainStoryboardIpad : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let initialViewControlleripad : UIViewController = mainStoryboardIpad.instantiateViewController(withIdentifier: "HW3ID") as UIViewController
                self.window = UIWindow(frame: UIScreen.main.bounds)
                self.window?.rootViewController = initialViewControlleripad
                self.window?.makeKeyAndVisible()
            }
    }
        if url.absoluteString == "klassenapp://Homework4" {
            if UserDefaults.standard.integer(forKey: "Checker") == 1 {
                let mainStoryboardIpad : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let initialViewControlleripad : UIViewController = mainStoryboardIpad.instantiateViewController(withIdentifier: "HW4ID") as UIViewController
                self.window = UIWindow(frame: UIScreen.main.bounds)
                self.window?.rootViewController = initialViewControlleripad
                self.window?.makeKeyAndVisible()
            }
    }
        if url.absoluteString == "klassenapp://Event1" {
            if UserDefaults.standard.integer(forKey: "Checker") == 1 {
                let mainStoryboardIpad : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let initialViewControlleripad : UIViewController = mainStoryboardIpad.instantiateViewController(withIdentifier: "Test1SiriStory") as UIViewController
                self.window = UIWindow(frame: UIScreen.main.bounds)
                self.window?.rootViewController = initialViewControlleripad
                self.window?.makeKeyAndVisible()
            }
    }
        if url.absoluteString == "klassenapp://Event2" {
            if UserDefaults.standard.integer(forKey: "Checker") == 1 {
                let mainStoryboardIpad : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let initialViewControlleripad : UIViewController = mainStoryboardIpad.instantiateViewController(withIdentifier: "TEST2ID") as UIViewController
                self.window = UIWindow(frame: UIScreen.main.bounds)
                self.window?.rootViewController = initialViewControlleripad
                self.window?.makeKeyAndVisible()
            }
    }
        if url.absoluteString == "klassenapp://Event3" {
            if UserDefaults.standard.integer(forKey: "Checker") == 1 {
                let mainStoryboardIpad : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let initialViewControlleripad : UIViewController = mainStoryboardIpad.instantiateViewController(withIdentifier: "TEST3ID") as UIViewController
                self.window = UIWindow(frame: UIScreen.main.bounds)
                self.window?.rootViewController = initialViewControlleripad
                self.window?.makeKeyAndVisible()
            }
    }
        if url.absoluteString == "klassenapp://Event4" {
            if UserDefaults.standard.integer(forKey: "Checker") == 1 {
                let mainStoryboardIpad : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let initialViewControlleripad : UIViewController = mainStoryboardIpad.instantiateViewController(withIdentifier: "TEST4ID") as UIViewController
                self.window = UIWindow(frame: UIScreen.main.bounds)
                self.window?.rootViewController = initialViewControlleripad
                self.window?.makeKeyAndVisible()
            }
    }
        if url.absoluteString == "klassenapp://Event5" {
            if UserDefaults.standard.integer(forKey: "Checker") == 1 {
                let mainStoryboardIpad : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let initialViewControlleripad : UIViewController = mainStoryboardIpad.instantiateViewController(withIdentifier: "TEST5ID") as UIViewController
                self.window = UIWindow(frame: UIScreen.main.bounds)
                self.window?.rootViewController = initialViewControlleripad
                self.window?.makeKeyAndVisible()
            }
    }
        if url.absoluteString == "klassenapp://Milchbar" {
            if UserDefaults.standard.integer(forKey: "Checker") == 1 {
                let mainStoryboardIpad : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let initialViewControlleripad : UIViewController = mainStoryboardIpad.instantiateViewController(withIdentifier: "FOODID") as UIViewController
                self.window = UIWindow(frame: UIScreen.main.bounds)
                self.window?.rootViewController = initialViewControlleripad
                self.window?.makeKeyAndVisible()
            }
    }
        return true
}
    
    func gotoUC() {
        let mainStoryboardIpad : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let initialViewControlleripad : UIViewController = mainStoryboardIpad.instantiateViewController(withIdentifier: "updatecenterid") as UIViewController
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.rootViewController = initialViewControlleripad
        self.window?.makeKeyAndVisible()
    }
    
    
 
    
    /// This method is called on iOS 10 devices to handle data messages received via FCM through its
    /// direct channel (not via APNS). For iOS 9 and below, the FCM data message is delivered via the
    /// UIApplicationDelegate's -application:didReceiveRemoteNotification: method.
   
    /* func application(_ application: UIApplication, performFetchWithCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
     
     if UserDefaults.standard.integer(forKey: "Checker") == 1 {
     var i = 5
     while i >= 0 {
     
    
     
     /// This method is called on iOS 10 devices to handle data messages received via FCM through its
     /// direct channel (not via APNS). For iOS 9 and below, the FCM data message is delivered via the
     /// UIApplicationDelegate's -application:didReceiveRemoteNotification: method.
     @available(iOS 10.0, *)
     func messaging(messaging: Messaging, didReceive remoteMessage: MessagingRemoteMessage)
     {
     let FcmRcdNfnNryVal = remoteMessage.appData
     print("iOS 10.0 FcmRcdRmtNfnMsg : ", FcmRcdNfnNryVal)
     
     }
     
     var ref: DatabaseReference!
     
     ref = Database.database().reference()
     
     var homeworkw1 = ref.child("homework").child("Week1")
     
     homeworkw1.child("Monday").observeSingleEvent(of: .value) { (MondayASnap) in
     DataVar.MondayA = MondayASnap.value as! String
     }
     homeworkw1.child("Tuesday").observeSingleEvent(of: .value) { (TuesdayASnap) in
     DataVar.TuesdayA = TuesdayASnap.value as! String
     }
     homeworkw1.child("Wednesday").observeSingleEvent(of: .value) { (WednesdayASnap) in
     DataVar.WednesdayA = WednesdayASnap.value as! String
     }
     homeworkw1.child("Thursday").observeSingleEvent(of: .value) { (ThursdayASnap) in
     DataVar.ThursdayA = ThursdayASnap.value as! String
     }
     homeworkw1.child("Friday").observeSingleEvent(of: .value) { (FridayASnap) in
     DataVar.FridayA = FridayASnap.value as! String
     }
     
     if DataVar.MondayA != DataVar.MondayB || DataVar.TuesdayA != DataVar.TuesdayB || DataVar.WednesdayA != DataVar.WednesdayB || DataVar.ThursdayA != DataVar.ThursdayB || DataVar.FridayA != DataVar.FridayB {
     
     if #available(iOS 10.0, *) {
     let content = UNMutableNotificationContent()
     content.title = "Neue Hausaufgaben!"
     content.body = "Die Hausaufgabenliste wurde aktualisiert!"
     content.badge = 1
     
     let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
     
     let request = UNNotificationRequest(identifier: "newHomework", content: content, trigger: trigger)
     
     UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
     } else {
     // Fallback on earlier versions
     }
     
     }
     }
     }
     }
     struct DataVar {
     static var MondayB = "Download"
     static var TuesdayB = "Download"
     static var WednesdayB = "Download"
     static var ThursdayB = "Download"
     static var FridayB = "Download"
     
     static var MondayA = "Download"
     static var TuesdayA = "Download"
     static var WednesdayA = "Download"
     static var ThursdayA = "Download"
     static var FridayA = "
     
     */
    
    
    
    
    
  /*  func application(_ application: UIApplication, performActionFor shortcutItem: UIApplicationShortcutItem, completionHandler: @escaping (Bool) -> Void) {
        if shortcutItem.type == "com.adrianbaumgart.KlassenAppDREA123.showWeek1Homework" {
            //LoginShortID
            if UserDefaults.standard.integer(forKey: "Checker") == 1 {
                let mainStoryboardIpad : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let initialViewControlleripad : UIViewController = mainStoryboardIpad.instantiateViewController(withIdentifier: "LoginShortID") as UIViewController
                self.window = UIWindow(frame: UIScreen.main.bounds)
                self.window?.rootViewController = initialViewControlleripad
                self.window?.makeKeyAndVisible()
            }
            else {
                let mainStoryboardIpad : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let initialViewControlleripad : UIViewController = mainStoryboardIpad.instantiateViewController(withIdentifier: "planID") as UIViewController
                self.window = UIWindow(frame: UIScreen.main.bounds)
                self.window?.rootViewController = initialViewControlleripad
                self.window?.makeKeyAndVisible()
            }
        }
        if shortcutItem.type == "com.adrianbaumgart.KlassenAppDREA123.showNextTest" {
            //LoginShortID
            FirstViewController.LastVC.ShortDirect = "NextTest"
            let mainStoryboardIpad : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let initialViewControlleripad : UIViewController = mainStoryboardIpad.instantiateViewController(withIdentifier: "LoginShortID") as UIViewController
            self.window = UIWindow(frame: UIScreen.main.bounds)
            self.window?.rootViewController = initialViewControlleripad
            self.window?.makeKeyAndVisible()
        }
        if shortcutItem.type == "com.adrianbaumgart.KlassenAppDREA123.showTimeTable" {
            FirstViewController.LastVC.ShortDirect = "TimeTableShort"
            let mainStoryboardIpad : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let initialViewControlleripad : UIViewController = mainStoryboardIpad.instantiateViewController(withIdentifier: "planID") as UIViewController
            self.window = UIWindow(frame: UIScreen.main.bounds)
            self.window?.rootViewController = initialViewControlleripad
            self.window?.makeKeyAndVisible()
        }
    }*/
    @available(iOS 10.0, *)
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
            completionHandler(UNNotificationPresentationOptions.alert)
    }
}

