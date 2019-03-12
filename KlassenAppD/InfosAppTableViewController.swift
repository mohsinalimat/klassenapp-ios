//
//  InfosAppTableViewController.swift
//  KlassenAppD
//
//  Created by Adrian Baumgart on 28.12.18.
//  Copyright © 2018 Adrian Baumgart. All rights reserved.
//

import UIKit

class InfosAppTableViewController: UITableViewController {
    
    
    var n1:[String] = ["Appname", "App-Entwickler", "Datenbank", "Verwendete Bibliotheken"]
    var n2:[String] = ["KlassenApp", "Adrian", "Firebase", "-Firebase\n-Fabric\n-Crashlytics\n-ReachabilitySwift\n-Alamofire\n-BulletinBoard\n-NotificationBannerSwift\n-RevealingSplashView\n-SendBidSDK\n-MiBadgeButton-Swift\n-SwipeableTabBarController\n-ExpandingMenu\n-SendBirdSDK\n-JGProgressHUD\n-TrueTime"]
    var n3:[String] = ["KlassenApp", "Adrian", "Firebase", "-Firebase -Fabric -Crashlytics -ReachabilitySwift -Alamofire -BulletinBoard -NotificationBannerSwift -RevealingSplashView\n-SendBidSDK -MiBadgeButton-Swift -SwipeableTabBarController\n-ExpandingMenu -SendBirdSDK -JGProgressHUD -TrueTime"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.estimatedRowHeight = 68.0
        tableView.rowHeight = UITableView.automaticDimension

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return n1.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "infocell", for: indexPath) as? AppInfosTableViewCell
        
        
        // Configure the cell...

        return cell!
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
