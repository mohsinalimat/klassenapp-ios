//
//  EventsNewViewController.swift
//  KlassenAppD
//
//  Created by Adrian Baumgart on 03.09.19.
//  Copyright © 2019 Adrian Baumgart. All rights reserved.
//

import UIKit
import FirebaseDatabase
import SPStorkController

class EventsNewViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var allEvents:[singleEvent] = []
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        allEvents.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "supercell", for: indexPath)
        cell.textLabel!.text = allEvents[indexPath.row].name
        cell.detailTextLabel!.text = allEvents[indexPath.row].formattedDate
        
        return cell
    }
    
    /*func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print(allEvents[indexPath.row].identifier)
        AllNewEventsViewController.TestVC.selectedEventID = allEvents[indexPath.row].identifier
        
        let impactFeedbackgenerator = UIImpactFeedbackGenerator(style: .light)
        impactFeedbackgenerator.prepare()
        impactFeedbackgenerator.impactOccurred()
        let controller1 = AllNewEventsViewController()
        let transitionDelegate = SPStorkTransitioningDelegate()
        controller1.transitioningDelegate = transitionDelegate
        controller1.modalPresentationStyle = .custom
        controller1.modalPresentationCapturesStatusBarAppearance = true
        self.present(controller1, animated: true, completion: nil)
    }*/
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
           print(allEvents[indexPath.row].identifier)
           AllNewEventsViewController.TestVC.selectedEventID = allEvents[indexPath.row].identifier
           
           let impactFeedbackgenerator = UIImpactFeedbackGenerator(style: .light)
           impactFeedbackgenerator.prepare()
           impactFeedbackgenerator.impactOccurred()
           let controller1 = AllNewEventsViewController()
           let transitionDelegate = SPStorkTransitioningDelegate()
           controller1.transitioningDelegate = transitionDelegate
           controller1.modalPresentationStyle = .custom
           controller1.modalPresentationCapturesStatusBarAppearance = true
           self.present(controller1, animated: true, completion: nil)
    }
    

    
    @IBOutlet weak var eventsTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchData()

        // Do any additional setup after loading the view.
    }
    
    func fetchData() {
        var databasekeys: [String] = []
        
       /* let date = Date()
        let calender = Calendar.current
        let components = calender.dateComponents([.year, .month, .day, .hour, .minute, .second], from: date)
        
        let year = components.year!
        let month = components.month!
        let day = components.day!
        
        let yearString = String(year)
        var monthString = String(month)
        var dayString = String(day)
        
        if month < 10 {
            monthString = "0\(monthString)"
        }
        
        if day < 10 {
            dayString = "0\(dayString)"
        }
        
        let currentDateString = "\(yearString)\(monthString)\(dayString)"
        let currentDate = Int(currentDateString)!*/
        
        let ref: DatabaseReference
        ref = Database.database().reference()
        
        ref.child("arbeiten").child("list").observe(.value) { snapshot in
            
            databasekeys.removeAll()
            self.allEvents.removeAll()
            
            if let item = snapshot.value as? [String: AnyObject] {
                databasekeys = Array(item.keys)
                
                for key in databasekeys {
                    let date = item[key]!["date"] as? Int
                    let formattedDate = item[key]!["formattedDate"] as? String
                    let name = item[key]!["name"] as? String
                    let identifier = key as? String
                    
                    self.allEvents.append(singleEvent(name: name!, formattedDate: formattedDate!, date: date!, identifier: identifier!))
                }
            }
            self.allEvents.sort(by: { $0.date < $1.date })
            self.eventsTableView.reloadData()
        }
    }
    
    struct singleEvent {
        var name: String
        var formattedDate: String
        var date: Int
        var identifier: String
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
