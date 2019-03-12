//
//  ChatViewController.swift
//  KlassenAppD
//
//  Created by Adrian Baumgart on 15.09.18.
//  Copyright © 2018 Adrian Baumgart. All rights reserved.
//

import UIKit
import Firebase
import TrueTime
import ExpandingMenu
//import SendBirdSDK

class ChatViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextViewDelegate {
    var itemSender:[String] = [] //Array for all Names
    var itemMessage:[String] = [] //Array for all Amounts
    var databasekeys: [String] = [] //Array for all References in the Database
    var fullList: [Message] = []
    var itemTimestamp:[String] = []
    //@IBOutlet weak var ChatMSGTF: UITextField!
    @IBOutlet weak var backgroundTitleView: UIView!
    @IBOutlet weak var TitleLabel: UILabel!
    @IBOutlet weak var ChatTableView: UITableView!
   // @IBOutlet weak var ChatMSGTF: UITextView!
    @IBOutlet weak var ChatMSGTF: UITextView!
    
  /*  @IBOutlet weak var CellName: UILabel!
    @IBOutlet weak var CellTS: UILabel!
    @IBOutlet weak var CellMessage: UILabel!*/
    @IBOutlet weak var SendBtn: UIButton!
    @IBAction func SendBtnAction(_ sender: Any)
    {
        if ChatMSGTF.text != "" {
        SendBtn.isEnabled = false
        let currentDateTime = Date()
        
        // get the user's calendar
        let userCalendar = Calendar.current
        
        // choose which date and time components are needed
        let requestedComponents: Set<Calendar.Component> = [
            .year,
            .month,
            .day,
            .hour,
            .minute,
            .second
        ]
        
        // get the components
        let dateTimeComponents = userCalendar.dateComponents(requestedComponents, from: currentDateTime)
        
        // now the components are available
        dateTimeComponents.year //as! String  // 2016
        dateTimeComponents.month //as! String  // 10
        dateTimeComponents.day  //as! String  // 8
        dateTimeComponents.hour //as! String   // 22
        dateTimeComponents.minute// as! String // 42
        dateTimeComponents.second //as! String // 17

        var wholeDate = "\(dateTimeComponents.day)..\(dateTimeComponents.hour):\(dateTimeComponents.minute):\(dateTimeComponents.second)"
        print(wholeDate)
        let date = Date()
        let calender = Calendar.current
        let components = calender.dateComponents([.year,.month,.day,.hour,.minute,.second], from: date)
        
        let year = components.year
        let month = components.month
        let day = components.day
        let hour = components.hour
        let minute = components.minute
        let second = components.second
        if year! < 10
        {
            PV.yearunter10 = "0\(year!)"
        }
        else
        {
            PV.yearunter10 = "\(year!)"
        }
        print(PV.yearunter10)

        if month! < 10
        {
            PV.monthunder10 = "0\(month!)"
        }
        else
        {
            PV.monthunder10 = "\(month!)"
        }
        print(PV.monthunder10)
        if day! < 10
        {
            PV.dayunder10 = "0\(day!)"
        }
        else
        {
            PV.dayunder10 = "\(day!)"
        }
        print(PV.dayunder10)
        if hour! < 10
        {
             PV.hourunder10 = "0\(hour!)"
        }
        else
        {
            PV.hourunder10 = "\(hour!)"
        }
        print(PV.hourunder10)
        if minute! < 10
        {
            PV.minuteunder10 = "0\(minute!)"
        }
        else
        {
          PV.minuteunder10 = "\(minute!)"
        }
        print(PV.minuteunder10)
        if second! < 10
        {
            PV.secondunder10 = "0\(second!)"
        }
        else
        {
            PV.secondunder10 = "\(second!)"
        }
        print(PV.secondunder10)

        PV.today_string = PV.dayunder10 + ":" + PV.monthunder10 + ":" + PV.yearunter10 +  " " + PV.hourunder10  + ":" + PV.minuteunder10 + ":" + PV.secondunder10
        print(PV.today_string)
        let ref: DatabaseReference
        ref = Database.database().reference()
        //print(dat)
        print(PV.today_string)
        var RandomID = randomString(length: 20)
        let Reference = PV.today_string + "|" + (Auth.auth().currentUser?.displayName)! + "|" + RandomID
        ref.child("chat").child(Reference).child("sender").setValue(Auth.auth().currentUser?.displayName)
        ref.child("chat").child(Reference).child("message").setValue(ChatMSGTF.text)
        ref.child("chat").child(Reference).child("timestamp").setValue(PV.today_string)
        ChatMSGTF.text = ""
            SendBtn.isEnabled = true
            ChatTableView.reloadData()
            fullList.removeAll()
            self.itemSender.removeAll() //Clear Array for Names
            self.itemMessage.removeAll()
            self.itemTimestamp.removeAll()
            ChatTableView.reloadData()
        loadData()
        //reloadData()
            // ref.child("chat").child()
                                    
        }
    }
    func randomString(length: Int) -> String {
        let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890"
        return String((0...length-1).map{_ in letters.randomElement()!})
    }
    
   // var chatManager: ChatManager!
  //  var currentUser: PCCurrentUser?
    
   /* var chatManager: ChatManager!
    var currentUser: PCCurrentUser?*/
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ChatMSGTF.delegate = self
        var borderColor : UIColor = UIColor(red: 0.85, green: 0.85, blue: 0.85, alpha: 1.0)
        ChatMSGTF.layer.borderWidth = 0.5
        ChatMSGTF.layer.borderColor = borderColor.cgColor
        ChatMSGTF.layer.cornerRadius = 5.0
        var amountOfLinesToBeShown:CGFloat = 6
        var maxHeight:CGFloat = ChatMSGTF.font!.lineHeight * amountOfLinesToBeShown
        ChatMSGTF.sizeThatFits(CGSize(width: ChatMSGTF.frame.size.width, height: maxHeight))
        /*let fixedWidth = ChatMSGTF.frame.size.width
        let newSize = ChatMSGTF.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.greatestFiniteMagnitude))
        ChatMSGTF.frame.size = CGSize(width: max(newSize.width, fixedWidth), height: newSize.height)*/
        let menuButtonSize: CGSize = CGSize(width: 64.0, height: 50.0)
        print(self.view.frame.height)
        let menuButton = ExpandingMenuButton(frame: CGRect(origin: CGPoint.zero, size: menuButtonSize), image: UIImage(named: "menulines")!, rotatedImage: UIImage(named: "menulines")!)
        menuButton.foldingAnimations = .all
        menuButton.menuItemMargin = 1
        menuButton.expandingDirection = .bottom
        if UserDefaults.standard.integer(forKey: "DarkmodeStatus") == 1 {
            menuButton.bottomViewColor = UIColor.darkGray
        }
        else if UserDefaults.standard.integer(forKey: "DarkmodeStatus") != 1 {
            menuButton.bottomViewColor = UIColor.darkGray
        }
        menuButton.center = CGPoint(x: self.view.bounds.width - 32.0, y: (self.view.frame.origin.y) + 70.0)
        view.addSubview(menuButton)
        //HomeWorkShortID
        let item0 = ExpandingMenuItem(size: menuButtonSize, title: "Hausaufgaben", image: UIImage(named: "book")!, highlightedImage: UIImage(named: "book")!, backgroundImage: UIImage(named: "book"), backgroundHighlightedImage: UIImage(named: "book")) { () -> Void in
            // Do some action
            //self.performSegue(withIdentifier: "hw2arbeiten", sender: nil)
            if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "HomeWorkShortID") as? FirstViewController
            {
                self.present(vc, animated: true, completion: nil)
            }
            print("btn1")
        }
        let item1 = ExpandingMenuItem(size: menuButtonSize, title: "Arbeiten", image: UIImage(named: "ball_point_pen")!, highlightedImage: UIImage(named: "ball_point_pen")!, backgroundImage: UIImage(named: "ball_point_pen"), backgroundHighlightedImage: UIImage(named: "ball_point_pen")) { () -> Void in
            // Do some action
            //self.performSegue(withIdentifier: "hw2arbeiten", sender: nil)
            if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TestsShortID") as? SecondViewController
            {
                self.present(vc, animated: true, completion: nil)
            }
            print("btn1")
        }
        let item2 = ExpandingMenuItem(size: menuButtonSize, title: "Hausaufgaben bis morgen", image: UIImage(named: "clock")!, highlightedImage: UIImage(named: "clock")!, backgroundImage: UIImage(named: "clock"), backgroundHighlightedImage: UIImage(named: "clock")) { () -> Void in
            // Do some action
            if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "habmID") as? HABMViewController
            {
                self.present(vc, animated: true, completion: nil)
            }
            print("btn2")
        }
        let item3 = ExpandingMenuItem(size: menuButtonSize, title: "Neuigkeiten", image: UIImage(named: "news")!, highlightedImage: UIImage(named: "news")!, backgroundImage: UIImage(named: "news"), backgroundHighlightedImage: UIImage(named: "news")) { () -> Void in
            // Do some action
            if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "newsID") as? NewsViewController
            {
                self.present(vc, animated: true, completion: nil)
            }
            print("btn3")
        }
        let item4 = ExpandingMenuItem(size: menuButtonSize, title: "Einstellungen", image: UIImage(named: "settings")!, highlightedImage: UIImage(named: "settings")!, backgroundImage: UIImage(named: "settings"), backgroundHighlightedImage: UIImage(named: "settings")) { () -> Void in
            // Do some action
            if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "settingsID") as? SettingsViewController
            {
                self.present(vc, animated: true, completion: nil)
            }
            print("btn4")
        }
        let item5 = ExpandingMenuItem(size: menuButtonSize, title: "Speiseplan", image: UIImage(named: "icons8-restaurant-filled-50")!, highlightedImage: UIImage(named: "icons8-restaurant-filled-50")!, backgroundImage: UIImage(named: "icons8-restaurant-filled-50"), backgroundHighlightedImage: UIImage(named: "icons8-restaurant-filled-50")) { () -> Void in
            // Do some action
            if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "FOODID") as? FoodViewController
            {
                self.present(vc, animated: true, completion: nil)
            }
            print("btn5")
        }
        let item6 = ExpandingMenuItem(size: menuButtonSize, title: "Stundenplan", image: UIImage(named: "icon_menu")!, highlightedImage: UIImage(named: "icon_menu")!, backgroundImage: UIImage(named: "icon_menu"), backgroundHighlightedImage: UIImage(named: "icon_menu")) { () -> Void in
            // Do some action
            if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "planID") as? TimeTableViewController
            {
                self.present(vc, animated: true, completion: nil)
            }
            print("btn6")
        }
        let item7 = ExpandingMenuItem(size: menuButtonSize, title: "Updatecenter", image: UIImage(named: "downloadsign")!, highlightedImage: UIImage(named: "downloadsign")!, backgroundImage: UIImage(named: "downloadsign"), backgroundHighlightedImage: UIImage(named: "downloadsign")) { () -> Void in
            // Do some action
            if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "updatecenterid") as? UpdateCenterViewController
            {
                self.present(vc, animated: true, completion: nil)
            }
            print("btn7")
        }
        let item8 = ExpandingMenuItem(size: menuButtonSize, title: "Chat", image: UIImage(named: "chat")!, highlightedImage: UIImage(named: "chat")!, backgroundImage: UIImage(named: "chat"), backgroundHighlightedImage: UIImage(named: "chat")) { () -> Void in
            if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "chatID") as? ChatViewController
            {
                self.present(vc, animated: true, completion: nil)
            }
            // Do some action
            print("btn8")
        }
        let item9 = ExpandingMenuItem(size: menuButtonSize, title: "Liste", image: UIImage(named: "checked")!, highlightedImage: UIImage(named: "checked")!, backgroundImage: UIImage(named: "checked"), backgroundHighlightedImage: UIImage(named: "checked")) { () -> Void in
            if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "rememberID") as? RememberViewController
            {
                self.present(vc, animated: true, completion: nil)
            }
            // Do some action
            print("btn8")
        }
        
        
        if Auth.auth().currentUser != nil {
            menuButton.addMenuItems([item0, item1, item2, item3, item4, item5, item6, item7, item9])
        }
        else {
            menuButton.addMenuItems([item0, item1, item2, item3, item4, item5, item6, item7, item9])
        }
      /*  SBDMain.connect(withUserId: "adba") { (user, error) in
            guard error == nil else {    // Error.
                return
            }
         
        }*/
        if UserDefaults.standard.integer(forKey: "DarkmodeStatus") == 1 {
            view.backgroundColor = UIColor(red:0.05, green:0.05, blue:0.05, alpha:1.0)
            backgroundTitleView.backgroundColor = UIColor(red:0.13, green:0.13, blue:0.13, alpha:1.0)
            TitleLabel.textColor = UIColor.white
            ChatTableView.backgroundColor = UIColor(red:0.05, green:0.05, blue:0.05, alpha:1.0)
            ChatMSGTF.backgroundColor = UIColor(red:0.13, green:0.13, blue:0.13, alpha:1.0)
            ChatMSGTF.textColor = UIColor.white
          /*  ChatMSGTF.attributedPlaceholder = NSAttributedString(string: "Nachricht",
                                                                   attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])*/
            ChatMSGTF.textColor = UIColor.white
           // ChatMSGTF.tintColor = UIColor.white
            UIApplication.shared.statusBarStyle = .lightContent
        }
        if UserDefaults.standard.integer(forKey: "DarkmodeStatus") == 0 {
            view.backgroundColor = UIColor.white
            backgroundTitleView.backgroundColor = UIColor(red:0.97, green:0.97, blue:0.97, alpha:0.8)
            TitleLabel.textColor = UIColor.black
            ChatTableView.backgroundColor = UIColor.white
            ChatMSGTF.backgroundColor = UIColor.white
            ChatMSGTF.textColor = UIColor.black
          /* ChatMSGTF.attributedPlaceholder = NSAttributedString(string: "Nachricht",
                                                                   attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])*/
           // ChatMSGTF.tintColor = UIColor.black
            UIApplication.shared.statusBarStyle = .default
        }
        NotificationCenter.default.addObserver(self, selector: #selector(ChatViewController.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(ChatViewController.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        // Do any additional setup after loading the view.
    }
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0{
                let keyboardHeight = keyboardSize.height
                let heightbefore = view.frame.origin.y
                self.view.frame.origin.y -= keyboardHeight
                if view.frame.origin.y != heightbefore - keyboardHeight {
                    view.frame.origin.y -= keyboardHeight
                }
            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y != 0{
                let keyboardHeight = keyboardSize.height
                self.view.frame.origin.y += keyboardHeight
                if view.frame.origin.y != 0 {
                    view.frame.origin.y = 0
                }
            }
        }
    }
    func textFieldShouldReturn(_textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    override func viewDidAppear(_ animated: Bool) {
        loadData()
       // reloadData()
        let ref: DatabaseReference
        ref = Database.database().reference()
        ref.child("chat").observe(.childRemoved) { (snapshot) in //Download removed Data
            self.loadData()
        }
        }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fullList.count //Rows in UITableView
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "listcell"
        var cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as? ListTableViewCell
        if UserDefaults.standard.integer(forKey: "DarkmodeStatus") == 1 {
            cell?.CellMessage.textColor = UIColor.white
            cell?.backgroundColor = UIColor(red:0.05, green:0.05, blue:0.05, alpha:1.0)
        }
        if UserDefaults.standard.integer(forKey: "DarkmodeStatus") == 0 {
            cell?.CellMessage.textColor = UIColor.black
            cell?.backgroundColor = UIColor.white
        }
        //if itemNames.count != 0 {
        // let cell = UITableViewCell(style: .default, reuseIdentifier: "listcell")
        /*cell?.CellName.text = itemSender[indexPath.row]
        cell?.CellMessage.text = itemMessage[indexPath.row]
        cell?.CellTS.text = itemTimestamp[indexPath.row]*/
        cell?.CellName.textColor = UIColor.blue
        var counter = fullList.count as! Int
        for number in 0..<(fullList.count-1) {
            if fullList[indexPath.row].Name == Auth.auth().currentUser?.displayName {
                cell?.CellName.textColor = UIColor(red: 0.3608, green: 0.8392, blue: 0, alpha: 1.0)
            }
            else {
                cell?.CellName.textColor = UIColor(red: 0, green: 0.4157, blue: 1, alpha: 1.0)
            }
           // let mySubstring = String((fullList[indexPath.row].Text.substringToIndex(6)))
            
        }
        cell?.CellMessage?.text = fullList[indexPath.row].Text
        cell?.CellName.text = fullList[indexPath.row].Name
        cell?.CellTS.text = fullList[indexPath.row].Zeit
        cell?.selectionStyle = .none
        let table = UITableView()
        print("FINISHED")
        // }
        return cell!
    }
    func scrollToBottom(){
        DispatchQueue.main.async {
            let indexPath = IndexPath(row: self.fullList.count-1, section: 0)
            self.ChatTableView.scrollToRow(at: indexPath, at: .bottom, animated: false)
        }
    }
    
   /* func reloadData() {
        let ref: DatabaseReference
        ref = Database.database().reference()
        ref.child("chat").observe(.childChanged) { (AddedSnap) in
            print(11111111)
            let items = AddedSnap.value as? [String:AnyObject]
            var iS = items!["sender"] as? String
            var iM = items!["message"] as? String
            var iT = items!["timestamp"] as? String
            //var fullMessage = "\(iT) | \(iS) | \(iM)"
            self.fullList.append(Message.init(Name: iS ?? "", Text: iM ?? "", Zeit: iT ?? ""))
            self.fullList.sort { ($0.Zeit) < ($1.Zeit) }
          //  print(self.fullList)
            
            self.ChatTableView.reloadData()
            self.scrollToBottom()
            
        }
    }*/
    
    func loadData() { //Downloads all Data
        let ref: DatabaseReference
        ref = Database.database().reference()
        
     
        ref.child("chat").observe(.value) { (snapshot) in //Download Data
          // ref.child("chat").removeAllObservers()
            self.itemSender.removeAll() //Clear Array for Names
            self.itemMessage.removeAll()
            self.itemTimestamp.removeAll()
            self.fullList.removeAll() //Clear Array for Amounts
            //  ref.child("list").removeAllObservers()
            if let item = snapshot.value as? [String:AnyObject]{
                self.databasekeys = Array(item.keys) //Download members of List
                // print(self.databasekeys)
                for key in self.databasekeys {
                    var iS = item[key]!["sender"] as? String
                    var iM = item[key]!["message"] as? String
                    var iT = item[key]!["timestamp"] as? String
                    //var fullMessage = "\(iT) | \(iS) | \(iM)"
                    self.fullList.append(Message.init(Name: iS ?? "", Text: iM ?? "", Zeit: iT ?? ""))
                 //   self.fullList.append(fullMessage)
                    
                   // var iMString = String(iM ?? 0)
                   /* self.itemSender.append(iS!)
                    self.itemMessage.append(iM ?? "")
                    self.itemTimestamp.append(iT ?? "")*/
                    
                    
                    
                    
                }
                
                let ref: DatabaseReference
                ref = Database.database().reference()
               // print(self.fullList)
               // self.fullList.sorted(by: { $0.Zeit > $1.Zeit })

                self.fullList.sort { ($0.Zeit) < ($1.Zeit) }
                print(self.fullList)
              //  self.reloadData()
                
                self.ChatTableView.reloadData()
                self.scrollToBottom()
                
            }
        }
       /* ref.child("chat").observe(.childAdded) { (AddedSnap) in
            print(11111111)
            let items = AddedSnap.value as? [String:AnyObject]
            var iS = items!["sender"] as? String
            var iM = items!["message"] as? String
            var iT = items!["timestamp"] as? String
            //var fullMessage = "\(iT) | \(iS) | \(iM)"
            self.fullList.append(Message.init(Name: iS ?? "", Text: iM ?? "", Zeit: iT ?? ""))
            self.fullList.sort { ($0.Zeit) < ($1.Zeit) }
            //  print(self.fullList)
            
            self.ChatTableView.reloadData()
            self.scrollToBottom()
            
        }*/
    }
    struct Message {
        var Name = ""
        var Text = ""
        var Zeit = ""
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    func textFieldShouldReturn(_ ChatMSGTF: UITextView) -> Bool {
        self.view.endEditing(true)
        return true
    }
    struct PV {
        static var time = ""
        static var today_string = ""
        static var dayunder10 = ""
        static var hourunder10 = ""
        static var minuteunder10 = ""
        static var secondunder10 = ""
        static var monthunder10 = ""
        static var yearunter10 = ""
        
    }
    
}
