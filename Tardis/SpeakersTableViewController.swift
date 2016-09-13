//
//  SpeakersTableViewController.swift
//  Tardis
//
//  Created by Molnar Kristian on 7/25/16.
//  Copyright © 2016 Molnar Kristian. All rights reserved.
//

import UIKit
import Firebase

class SpeakersTableViewController: UITableViewController {
  
  let ref = FIRDatabase.database().reference()
  
  var speakersItemsArray:[[String:AnyObject]] = []
  
  var contentHeight:CGFloat = 117.0
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.view.backgroundColor = APPConfig().appColor
    let blogRef = ref.child("\(APPConfig().dataBaseRoot)/speakers")
    blogRef.keepSynced(true)
    let refHandle = blogRef.observeEventType(FIRDataEventType.Value, withBlock: { (snapshot) in
      
      var postDict = snapshot.value as! [AnyObject]
      print(postDict[0])
      postDict.removeFirst()
      
      for item in postDict {
        if item is NSNull {
          continue
        }
        let fetchedItem = item as! [String:AnyObject]
        self.speakersItemsArray.append(fetchedItem)
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
    return 1
  }
  
  override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    // #warning Incomplete implementation, return the number of rows
    return self.speakersItemsArray.count
  }
  
  
  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = UITableViewCell(style: .Default, reuseIdentifier: "row")
    
    if indexPath.row % 2 != 0 {
      let contentView = SpeakerTableViewItem(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.contentHeight))
      contentView.setUp(self.speakersItemsArray[indexPath.row])
      cell.addSubview(contentView)
      cell.backgroundColor = UIColor.clearColor()
      
    } else {
      let contentView = SpeakerTableViewItemRight(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.contentHeight))
      contentView.setUp(self.speakersItemsArray[indexPath.row])
      cell.addSubview(contentView)
      cell.backgroundColor = UIColor.clearColor()
    }
    
    
    
    APPConfig().setUpCellForUsage(cell)
    
    return cell
  }
  
  override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
    return self.contentHeight
  }
  
  
}
