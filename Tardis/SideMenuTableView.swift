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
      NSUserDefaults.standardUserDefaults().setBool(false, forKey: "isLoggedIn")
      
    } catch {
      
    }
    
    self.performSegueWithIdentifier("toAuthController", sender: self)
  }
  
  
  func displayShareSheet(shareContent:String) {
    let activityViewController = UIActivityViewController(activityItems: [shareContent as NSString], applicationActivities: nil)
    presentViewController(activityViewController, animated: true, completion: {})
  }
  
  
  @IBAction func shareAction(sender: AnyObject) {
    self.displayShareSheet("Some Shit to Share from Tardis, Good Day")
  }
  
  func sendInvite() {
    //    if let invite = FIRInvites.inviteDialog() {
    //      invite.setInviteDelegate(self)
    //      
    //      // NOTE: You must have the App Store ID set in your developer console project
    //      // in order for invitations to successfully be sent.
    //      
    //      // A message hint for the dialog. Note this manifests differently depending on the
    //      // received invation type. For example, in an email invite this appears as the subject.
    //      invite.setMessage("Try this out!\n -\(GIDSignIn.sharedInstance().currentUser.profile.name)")
    //      // Title for the dialog, this is what the user sees before sending the invites.
    //      invite.setTitle("Invites Example")
    //      invite.setDeepLink("app_url")
    //      invite.setCallToActionText("Install!")
    //      invite.setCustomImage("https://www.google.com/images/branding/googlelogo/2x/googlelogo_color_272x92dp.png")
    //      invite.open()
    //    }
  }
  @IBAction func sendInviteAction(sender: AnyObject) {
    sendInvite()
  }
}
