//
//  BlogTableViewCellContent.swift
//  Tardis
//
//  Created by Molnar Kristian on 7/22/16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import UIKit
import Firebase

@IBDesignable class BlogTableViewCellContent: UIView {
  
  var view: UIView!
  let storage = FIRStorage.storage()
  
  @IBOutlet weak var backgroundView: UIView!
  
  @IBOutlet weak var backgroundImage: UIImageView!
  @IBOutlet weak var briefView: UITextView!
  
  @IBOutlet weak var titleLabel: UILabel!
  var tapped = false
  func xibSetup() {
    view                  = loadViewFromNib()
    // use bounds not frame or it'll be offset
    view.frame            = bounds
    // Make the view stretch with containing view
    view.autoresizingMask = [UIViewAutoresizing.FlexibleWidth, UIViewAutoresizing.FlexibleHeight]
    // Adding custom subview on top of our view (over any custom drawing > see note below)
    addSubview(view)
  }
  
  func loadViewFromNib() -> UIView {
    let bundle = NSBundle(forClass: self.dynamicType)
    let nib    = UINib(nibName: "BlogTableViewCellContent", bundle: bundle)
    let view   = nib.instantiateWithOwner(self, options: nil)[0] as! UIView
    view.layer.cornerRadius = 5.0
    return view
  }
  
  override init(frame: CGRect) {
    // 1. setup any properties here
    // 2. call super.init(frame:)
    super.init(frame: frame)
    // 3. Setup view from .xib file
    xibSetup()
    
    
    
  }
  
  func setUp(obj:[String:AnyObject]) {
    let storageRef = storage.referenceForURL("gs://tardis-x.appspot.com")
    
    
    let spaceRef = storageRef.child(obj["image"] as! String)
    
    
    let starsRef = storageRef.child("images/stars.jpg")
    // Fetch the download URL
    spaceRef.downloadURLWithCompletion { (URL, error) -> Void in
      if (error != nil) {
        // Handle any errors
      } else {
        //        APPImages().
        print( (URL?.absoluteString)!)
        APPImages().setUpBackground(self.backgroundImage, urlString: (URL?.absoluteString)!)
        // Get the download URL for 'images/stars.jpg'
      }
    }
    self.backgroundImage.image = UIImage(named: "Google")!
    self.titleLabel.text = obj["title"] as? String
    self.briefView.text = obj["brief"] as? String
    
    
    self.titleLabel.adjustsFontSizeToFitWidth = true
  }
  
  required init?(coder aDecoder: NSCoder) {
    // 1. setup any properties here
    // 2. call super.init(coder:)
    super.init(coder: aDecoder)
    // 3. Setup view from .xib file
    xibSetup()
  }
  
  
}

