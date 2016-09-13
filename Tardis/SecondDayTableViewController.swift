//
//  SecondDayTableViewController.swift
//  Tardis
//
//  Created by Molnar Kristian on 7/25/16.
//  Copyright © 2016 Molnar Kristian. All rights reserved.
//

import UIKit
import Firebase

class SecondDayTableViewController: UITableViewController {
  
  let ref = FIRDatabase.database().reference()
  
  var scheduleItemArray:[[String:AnyObject]] = []
  var contentHeight:CGFloat = 88.0
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.view.backgroundColor = APPConfig().appColor
    let blogRef = ref.child("\(APPConfig().dataBaseRoot)/schedule/1/timeslots")
    blogRef.keepSynced(true)
    let refHandle = blogRef.observeEventType(FIRDataEventType.Value, withBlock: { (snapshot) in
      print(snapshot)
      let postDict = snapshot.value as! [[String:AnyObject]]
      print(postDict)
      
      
      for item in postDict {
        self.scheduleItemArray.append(item)
      }
      
      self.tableView.reloadData()
      
    })
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = false
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem()
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  // MARK: - Table view data source
  
  override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    // #warning Incomplete implementation, return the number of sections
    return 1
  }
  
  override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    // #warning Incomplete implementation, return the number of rows
    return self.scheduleItemArray.count
  }
  
  func setUpContent(content:ScheduleItem, session:String, time:String) {
    //  prod/sessions/1001
    
    
    let blogRef = ref.child("\(APPConfig().dataBaseRoot)/sessions/\(session)")
    blogRef.keepSynced(true)
    let refHandle = blogRef.observeEventType(FIRDataEventType.Value, withBlock: { (snapshot) in
      let postDict = snapshot.value as! [String : AnyObject]
      content.setUp(time, title: postDict["title"] as! String, location: "Eventum hall")
      
    })
  }
  
  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = UITableViewCell(style: .Default, reuseIdentifier: self.scheduleItemArray[indexPath.row]["startTime"] as? String)
    
    
    let content = ScheduleItem(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.contentHeight))
    let array = self.scheduleItemArray[indexPath.row]["sessions"] as! [AnyObject]
    let innerArray:[AnyObject] = array[0] as! [AnyObject]
    let variable = innerArray[0]
    print(innerArray)
    self.setUpContent(content, session: "\(variable)", time: self.scheduleItemArray[indexPath.row]["startTime"] as! String)
    
    cell.addSubview(content)
    cell.backgroundColor = UIColor.clearColor()
    APPConfig().setUpCellForUsage(cell)
    return cell
  }
  
  override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
    return self.contentHeight
  }
  
  
}
