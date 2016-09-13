//
//  FirstDayTableViewController.swift
//  Tardis
//
//  Created by Molnar Kristian on 7/25/16.
//  Copyright © 2016 Molnar Kristian. All rights reserved.
//

import UIKit
import Firebase

class FirstDayTableViewController: UITableViewController {
  let ref = FIRDatabase.database().reference()
  
  var scheduleItemArray:[[String:AnyObject]] = []
  var contentHeight:CGFloat = 91.0
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.view.backgroundColor = APPConfig().appColor
    let blogRef = ref.child("\(APPConfig().dataBaseRoot)/schedule/0/timeslots")
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
    
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  // MARK: - Table view data source
  
  override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    // #warning Incomplete implementation, return the number of sections
    //
    
    return self.scheduleItemArray.count
  }
  
  override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    // #warning Incomplete implementation, return the number of rows
    let array:[AnyObject] = self.scheduleItemArray[section]["sessions"] as! [AnyObject]
    
    return array.count
  }
  
  
  override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    return 30
  }
  
  
  
  override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    var color:UIColor = APPConfig().yellowColor
    
    
    if section % 2 == 0 {
      color = APPConfig().redColor
    }
    
    if section % 3 == 0 {
      color = APPConfig().yellowColor
    }
    
    
    if section % 4 == 0 {
      color = APPConfig().greenColor
    }
    
    let container = ScheduleHeader(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height:  30))
    container.setUp("\(self.scheduleItemArray[section]["startTime"] as! String) - \(self.scheduleItemArray[section]["endTime"] as! String)", color: color)
    return container
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
    
    let array = self.scheduleItemArray[indexPath.section]["sessions"] as! [AnyObject]
    
    
    
    let innerArray:[AnyObject] = array[indexPath.row] as! [AnyObject]
    let variable = innerArray[0]
    
    let time = ""
    print("\(indexPath.section) - \(variable)")
    self.setUpContent(content, session: "\(variable)", time: time)
    
    cell.addSubview(content)
    cell.backgroundColor = UIColor.clearColor()
    APPConfig().setUpCellForUsage(cell)
    return cell
  }
  
  override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
    return self.contentHeight
  }
  
  
}
