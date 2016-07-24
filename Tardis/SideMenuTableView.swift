//
//  SideMenuTableView.swift
//  SideMenu
//
//  Created by Jon Kent on 4/5/16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import Foundation
//import SideMenu
import GoogleSignIn
import Firebase

class SideMenuTableView: UITableViewController, GIDSignInUIDelegate {
  
  @IBOutlet weak var userImage: UIImageView!
  @IBOutlet weak var userName: UILabel!
  @IBOutlet weak var userEmail: UILabel!
  @IBOutlet weak var containerWhite: UIView!
  
  
  override func viewDidLoad() {
    
    super.viewDidLoad()
    GIDSignIn.sharedInstance().uiDelegate = self
    
    FIRAuth.auth()?.addAuthStateDidChangeListener { auth, user in
      if let user = user {
        APPImages().setUpBackground(self.userImage, urlString: (user.photoURL?.absoluteString)!)
        self.userName.text = user.displayName
        self.userEmail.text = user.email
        
        self.userEmail.adjustsFontSizeToFitWidth = true
        self.userName.adjustsFontSizeToFitWidth = true
        // User is signed in.
      } else {
        print("nem")
        // No user is signed in.
      }
    }
    
  }
  
  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)
    
  }
  
  @IBOutlet weak var logoutAction: UIButton!
  @IBAction func logOut(sender: AnyObject) {
    
    
  }
  
  
  @IBOutlet weak var logOutUserAction: UIButton!
  @IBAction func logOutUser(sender: AnyObject) {
    GIDSignIn.sharedInstance().signOut()
    
    do {
      try FIRAuth.auth()?.signOut()
      
    } catch {
      
    }
    
    self.performSegueWithIdentifier("toAuthController", sender: self)
  }
}
