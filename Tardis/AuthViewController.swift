//
//  AuthViewController.swift
//  Tardis
//
//  Created by Molnar Kristian on 7/24/16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn

class AuthViewController: UIViewController, GIDSignInUIDelegate {
  
  @IBOutlet weak var anonimousLogInContainer: UIView!
  @IBOutlet weak var logInContainer: UIView!
  override func viewDidLoad() {
    super.viewDidLoad()
    
    let addStatusBar = UIView()
    addStatusBar.frame = CGRectMake(0, 0, UIScreen.mainScreen().bounds.width, 20);
    addStatusBar.backgroundColor = UIColor(red: 15/255.0, green: 157/255.0, blue: 88/255.0, alpha: 1.0)
    self.view.addSubview(addStatusBar)
    
    
    self.navigationItem.hidesBackButton = true
    
    self.logInContainer.layer.borderColor = UIColor.whiteColor().CGColor
    self.logInContainer.layer.borderWidth = 1.0
    self.anonimousLogInContainer.layer.borderColor = UIColor.whiteColor().CGColor
    self.anonimousLogInContainer.layer.borderWidth = 1.0
    
    GIDSignIn.sharedInstance().uiDelegate = self
    
    print(FIRAuth.auth()?.currentUser)
    FIRAuth.auth()?.addAuthStateDidChangeListener { auth, user in
      if let user = user {
        self.performSegueWithIdentifier("toNavigationController", sender: self)
      } else {
        
      }
    }
    // Do any additional setup after loading the view.
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  @IBAction func logInWithGoogleAction(sender: AnyObject) {
    GIDSignIn.sharedInstance().signIn()
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
