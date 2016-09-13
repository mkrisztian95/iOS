//
//  AppDelegate.swift
//  SideMenu
//
//  Created by jonkykong on 12/23/2015.
//  Copyright (c) 2015 jonkykong. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, GIDSignInDelegate {
  var table1:FirstDayTableViewController! = nil
  var table2:SecondDayTableViewController! = nil
  
  var window: UIWindow?
  
  override init() {
    // Firebase Init
    FIRApp.configure()
    GIDSignIn.sharedInstance().clientID = FIRApp.defaultApp()?.options.clientID
    
    FIRDatabase.database().persistenceEnabled = true
  }
  
  func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
    /*var configureError: NSError?
     GGLContext.sharedInstance().configureWithError(&configureError)
     assert(configureError == nil, "Error configuring Google services: \(configureError)")
     
     GIDSignIn.sharedInstance().delegate = self
     */
    var configureError: NSError?
    //    GMSServices.provideAPIKey("AIzaSyCEtkeXHgva5wSULamLxmU0ZYpSEZ-ln9w")
    //    FIRApp.configure()
    GIDSignIn.sharedInstance().delegate = self
    
    
    return true
  }
  
  func application(application: UIApplication,
                   openURL url: NSURL, options: [String: AnyObject]) -> Bool {
    
    
    
    
    if #available(iOS 9.0, *) {
      return GIDSignIn.sharedInstance().handleURL(url,
                                                  sourceApplication: options[UIApplicationOpenURLOptionsSourceApplicationKey] as? String,
                                                  annotation: options[UIApplicationOpenURLOptionsAnnotationKey])
    } else {
      // Fallback on earlier versions
    }
    
    return false
  }
  
  func application(application: UIApplication,
                   openURL url: NSURL, sourceApplication: String?, annotation: AnyObject?) -> Bool {
    
    
    
    if #available(iOS 9.0, *) {
      var options: [String: AnyObject] = [UIApplicationOpenURLOptionsSourceApplicationKey: sourceApplication!,
                                          UIApplicationOpenURLOptionsAnnotationKey: annotation!]
    } else {
      // Fallback on earlier versions
    }
    return GIDSignIn.sharedInstance().handleURL(url,
                                                sourceApplication: sourceApplication,
                                                annotation: annotation)
  }
  
  func signIn(signIn: GIDSignIn!, didSignInForUser user: GIDGoogleUser!,
              withError error: NSError!) {
    if let error = error {
      print(error.localizedDescription)
      return
    }
    
    let authentication = user.authentication
    let credential = FIRGoogleAuthProvider.credentialWithIDToken(authentication.idToken,
                                                                 accessToken: authentication.accessToken)
    
    FIRAuth.auth()?.signInWithCredential(credential) { (user, error) in
      // ...
    }
    // ...
  }
  
  func signIn(signIn: GIDSignIn!, didDisconnectWithUser user:GIDGoogleUser!,
              withError error: NSError!) {
    // Perform any operations when the user disconnects from app here.
    // ...
  }
  
  func applicationWillResignActive(application: UIApplication) {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
  }
  
  func applicationDidEnterBackground(application: UIApplication) {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
  }
  
  func applicationWillEnterForeground(application: UIApplication) {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
  }
  
  func applicationDidBecomeActive(application: UIApplication) {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
  }
  
  func applicationWillTerminate(application: UIApplication) {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
  }
  
  
}

