//
//  SpeakerTableViewItem.swift
//  Tardis
//
//  Created by Molnar Kristian on 7/25/16.
//  Copyright © 2016 Molnar Kristian. All rights reserved.
//

import UIKit
import Firebase


@IBDesignable class SpeakerTableViewItem: UIView {
  
  
  var view: UIView!
  let storage = FIRStorage.storage()
  
  @IBOutlet weak var speakerName: UILabel!
  @IBOutlet weak var company: UILabel!
  @IBOutlet weak var country: UILabel!
  @IBOutlet weak var image: UIImageView!
  
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
    let nib    = UINib(nibName: "SpeakerTableViewItem", bundle: bundle)
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
    
    let spaceRef = storageRef.child(obj["photoUrl"] as! String)
    
    self.speakerName.text = obj["name"] as! String
    self.speakerName.adjustsFontSizeToFitWidth = true
    
    self.company.text = "Company: \(obj["company"] as! String)"
    self.company.adjustsFontSizeToFitWidth = true
    
    self.country.text = obj["country"] as! String
    self.country.adjustsFontSizeToFitWidth = true
    
    spaceRef.downloadURLWithCompletion { (URL, error) -> Void in
      if (error != nil) {
        // Handle any errors
      } else {
        
        APPImages().setUpBackground(self.image, urlString: (URL?.absoluteString)!)
        // Get the download URL for 'images/stars.jpg'
      }
    }
    
  }
  
  required init?(coder aDecoder: NSCoder) {
    // 1. setup any properties here
    // 2. call super.init(coder:)
    super.init(coder: aDecoder)
    // 3. Setup view from .xib file
    xibSetup()
  }
  
  
}
