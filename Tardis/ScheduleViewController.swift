//
//  ScheduleViewController.swift
//  Tardis
//
//  Created by Molnar Kristian on 7/25/16.
//  Copyright © 2016 Molnar Kristian. All rights reserved.
//

import UIKit

class ScheduleViewController: UIViewController {
  @IBOutlet weak var scrollView: UIScrollView!
  @IBOutlet weak var segmentedControl: UISegmentedControl!
  
  let appDelegate     = UIApplication.sharedApplication().delegate as! AppDelegate
  
  var table1 = FirstDayTableViewController()
  var table2 = SecondDayTableViewController()
  
  let delegate = UIApplication.sharedApplication().delegate as! AppDelegate
  var pageImages: [UIImage]       = []
  var pageViews: [UIImageView?]   = []
  
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Do any additional setup after loading the view.
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  func scrollViewDidScroll(scrollView: UIScrollView!) {
    // Load the pages that are now on screen
    //    let point = CGPointMake(scrollView.contentOffset.x, 0)
    //    scrollView.setContentOffset(point, animated: false)
    loadVisiblePages()
  }
  
  override func viewDidAppear(animated: Bool) {
    let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main",bundle: nil)
    
    
    
    if appDelegate.table2 != nil {
      table2 = appDelegate.table2
    } else {
      appDelegate.table2 = mainStoryboard.instantiateViewControllerWithIdentifier("SecondDayTableViewController") as! SecondDayTableViewController
      table2 = appDelegate.table2
    }
    
    if appDelegate.table1 != nil {
      table1 = appDelegate.table1
    } else {
      appDelegate.table1 = mainStoryboard.instantiateViewControllerWithIdentifier("FirstDayTableViewController") as! FirstDayTableViewController
      table1 = appDelegate.table1
    }
    
    
    
    
    self.setUpFrames()
    
    self.addChildViewController(table1)
    self.addChildViewController(table2)
    
    table1.didMoveToParentViewController(self)
    table2.didMoveToParentViewController(self)
    
    scrollView.addSubview(table1.tableView)
    scrollView.addSubview(table2.tableView)
    
    
    
    
    loadVisiblePages()
    scrollView.setContentOffset(CGPointMake(0, 0), animated: false)
    
  }
  
  func setUpFrames() {
    
    
    let pagesScrollViewSize = scrollView.frame.size
    scrollView.contentSize  = CGSizeMake(self.view.frame.size.width * 2, self.view.frame.size.height - 88)
    
    var firstFrame:CGRect  = table1.tableView.frame
    firstFrame.origin.x    = 0
    firstFrame.origin.y    = 0
    firstFrame.size.width  = self.scrollView.frame.size.width
    firstFrame.size.height = self.scrollView.frame.size.height
    table1.tableView.frame = firstFrame
    
    //    privateUserSecondScreen                 = mainStoryboard.instantiateViewControllerWithIdentifier("PrivateProfileSecondScreenTableViewController") as! PrivateProfileSecondScreenTableViewController
    var secondFrame:CGRect  = table2.tableView.frame
    secondFrame.origin.x    = self.scrollView.frame.size.width
    secondFrame.origin.y    = 0
    secondFrame.size.width  = self.scrollView.frame.size.width
    secondFrame.size.height = self.scrollView.frame.size.height
    table2.tableView.frame = secondFrame
    
  }
  
  func loadVisiblePages() {
    
    // First, determine which page is currently visible
    let pageWidth = scrollView.frame.size.width
    let page      = Int(floor((scrollView.contentOffset.x * 3.0 + pageWidth) / (pageWidth * 3.0)))
    
    
    if page == 0 {
      segmentedControl.selectedSegmentIndex = 0
      
      return
    }
    
    if page == 1 {
      segmentedControl.selectedSegmentIndex = 1
      
      return
    }
    
    
    
  }
  @IBAction func changedSegmentedControl(sender: AnyObject) {
    switch segmentedControl.selectedSegmentIndex {
    case 1:
      let p =  CGPoint(x:self.view.frame.size.width,y:0)
      self.scrollView.setContentOffset(p, animated: true)
      break
   
    case 0:
      let p =  CGPoint(x:0,y:0)
      scrollView.setContentOffset(p, animated: true)
      break
      
    default:
      let p =  CGPoint(x:0,y:0)
      scrollView.setContentOffset(p, animated: true)
    }
  }
  /*
   // MARK: - Navigation
   
   // In a storyboard-based application, you will often want to do a little preparation before navigation
   override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
   // Get the new view controller using segue.destinationViewController.
   // Pass the selected object to the new view controller.
   }
   */
  
}
