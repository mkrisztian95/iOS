//
//  MainViewController.swift
//
//  Created by Jon Kent on 11/12/15.
//  Copyright © 2015 Jon Kent. All rights reserved.
//

import SideMenu
import Foundation
import Firebase
import GoogleSignIn

class MainViewController: UIViewController, GIDSignInUIDelegate {
  
  @IBOutlet weak var mapView: UIView!
  
  @IBOutlet weak var signInButton: UIButton!
  let ref = FIRDatabase.database().reference()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    navigationController!.navigationBar.barTintColor = APPConfig().appColor
    navigationController!.navigationBar.tintColor    = UIColor.whiteColor()
    
    GIDSignIn.sharedInstance().uiDelegate = self
    
    setupSideMenu()
    setDefaults()
  }
  
  private func setupSideMenu() {
    // Define the menus
    SideMenuManager.menuLeftNavigationController = storyboard!.instantiateViewControllerWithIdentifier("LeftMenuNavigationController") as? UISideMenuNavigationController
    //    SideMenuManager.menuRightNavigationController = storyboard!.instantiateViewControllerWithIdentifier("RightMenuNavigationController") as? UISideMenuNavigationController
    
    // Enable gestures. The left and/or right menus must be set up above for these to work.
    // Note that these continue to work on the Navigation Controller independent of the View Controller it displays!
    SideMenuManager.menuAddPanGestureToPresent(toView: self.navigationController!.navigationBar)
    SideMenuManager.menuAddScreenEdgePanGesturesToPresent(toView: self.navigationController!.view)
    
    // Set up a cool background image for demo purposes
    //    SideMenuManager.menuAnimationBackgroundColor = UIColor(patternImage: UIImage(named: "background")!)
  }
  
  private func setDefaults() {
    
    SideMenuManager.menuWidth = self.view.frame.width - 80
  }
  
  @IBAction func signInAction(sender: AnyObject) {
    GIDSignIn.sharedInstance().signIn()
  }
  
}