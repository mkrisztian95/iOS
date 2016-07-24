//
//  BlogTableViewController.swift
//  Tardis
//
//  Created by Molnar Kristian on 7/22/16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import UIKit
import Foundation
import Firebase

class BlogTableViewController: UITableViewController {
  
  let ref = FIRDatabase.database().reference()
  
  var blogItemsArray:[[String:AnyObject]] = []
  
  var contentHeight:CGFloat = 132.0
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.view.backgroundColor = UIColor(red: 15/255.0, green: 157/255.0, blue: 88/255.0, alpha: 1.0)
    let blogRef = ref.child("prod/blog")
    blogRef.keepSynced(true)
    let refHandle = blogRef.observeEventType(FIRDataEventType.Value, withBlock: { (snapshot) in
      let postDict = snapshot.value as! [String : AnyObject]
      let arrayKeys = Array(postDict.keys)
      
      for key:String in arrayKeys {
        let fetchedItem = postDict[key] as! [String: AnyObject]
        self.blogItemsArray.append(fetchedItem)
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
    return self.blogItemsArray.count
  }
  
  
  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = UITableViewCell(style: .Default, reuseIdentifier: "row")
    
    let contentView = BlogTableViewCellContent(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.contentHeight))
    contentView.setUp(self.blogItemsArray[indexPath.row])
    cell.addSubview(contentView)
    cell.backgroundColor = UIColor.clearColor()
    return cell
  }
  
  override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
    return self.contentHeight
  }
  
  /*
   // Override to support conditional editing of the table view.
   override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
   // Return false if you do not want the specified item to be editable.
   return true
   }
   */
  
  /*
   // Override to support editing the table view.
   override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
   if editingStyle == .Delete {
   // Delete the row from the data source
   tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
   } else if editingStyle == .Insert {
   // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
   }    
   }
   */
  
  /*
   // Override to support rearranging the table view.
   override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {
   
   }
   */
  
  /*
   // Override to support conditional rearranging of the table view.
   override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
   // Return false if you do not want the item to be re-orderable.
   return true
   }
   */
  
  /*
   // MARK: - Navigation
   
   // In a storyboard-based application, you will often want to do a little preparation before navigation
   override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
   // Get the new view controller using segue.destinationViewController.
   // Pass the selected object to the new view controller.
   }
   */
  
}
