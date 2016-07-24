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
import GoogleMaps

class MainViewController: UIViewController, GIDSignInUIDelegate {
  
  @IBOutlet weak var mapView: UIView!
  
  @IBOutlet weak var signInButton: UIButton!
  let ref = FIRDatabase.database().reference()
  
  
  
  
  
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    navigationController!.navigationBar.barTintColor = UIColor(red: 15/255.0, green: 157/255.0, blue: 88/255.0, alpha: 1.0)
    navigationController!.navigationBar.tintColor    = UIColor.whiteColor()
    
    GIDSignIn.sharedInstance().uiDelegate = self
    
    
    
    let camera = GMSCameraPosition.cameraWithLatitude(49.840044, longitude: 24.027737, zoom: 15)
    var mapFrame = self.mapView.frame
    mapFrame.origin.y = 0
    let mapViewItem = GMSMapView.mapWithFrame(mapFrame, camera: camera)
    mapViewItem.myLocationEnabled = true
    
    let marker = GMSMarker()
    marker.position = CLLocationCoordinate2DMake(49.840044, 24.027737)
    marker.title = "Lviv"
    marker.snippet = "Svobody Ave"
    marker.map = mapViewItem
    
    
    self.mapView.addSubview(mapViewItem)
    self.mapView.sendSubviewToBack(mapViewItem)
    if let user = FIRAuth.auth()?.currentUser {
      
    } else {
      
    }
    
    
    ref.observeEventType(FIRDataEventType.Value, withBlock: { (snapshot) in
      let postDict = snapshot.value as! [String : AnyObject]
      print("\(postDict)")
    })
    
    
    //    let prodRef = ref.child("prod")
    //    let userRef = ref.child("prod/blog")
    //    let refHandle = userRef.observeEventType(FIRDataEventType.Value, withBlock: { (snapshot) in
    //      let postDict = snapshot.value as! [String : AnyObject]
    //      print(postDict)
    //    })
    
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
  //  @IBAction private func changeSegment(segmentControl: UISegmentedControl) {
  //    switch segmentControl {
  //    case presentModeSegmentedControl:
  //      let modes:[SideMenuManager.MenuPresentMode] = [.MenuSlideIn, .ViewSlideOut, .ViewSlideInOut, .MenuDissolveIn]
  //      SideMenuManager.menuPresentMode = modes[segmentControl.selectedSegmentIndex]
  //    case blurSegmentControl:
  //      if segmentControl.selectedSegmentIndex == 0 {
  //        SideMenuManager.menuBlurEffectStyle = nil
  //      } else {
  //        let styles:[UIBlurEffectStyle] = [.Dark, .Light, .ExtraLight]
  //        SideMenuManager.menuBlurEffectStyle = styles[segmentControl.selectedSegmentIndex - 1]
  //      }
  //    default: break;
  //    }
  //  }
  //  
  //  @IBAction private func changeSlider(slider: UISlider) {
  //    switch slider {
  //    case darknessSlider:
  //      SideMenuManager.menuAnimationFadeStrength = CGFloat(slider.value)
  //    case shadowOpacitySlider:
  //      SideMenuManager.menuShadowOpacity = slider.value
  //    case shrinkFactorSlider:
  //      SideMenuManager.menuAnimationTransformScaleFactor = CGFloat(slider.value)
  //    case screenWidthSlider:
  //      SideMenuManager.menuWidth = view.frame.width * CGFloat(slider.value)
  //    default: break;
  //    }
  //  }
  //  
  //  @IBAction private func changeSwitch(switchControl: UISwitch) {
  //    SideMenuManager.menuFadeStatusBar = switchControl.on
  //  }
}