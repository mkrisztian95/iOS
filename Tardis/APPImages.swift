//
//  CHImages.swift
//  ChampySwift
//
//  Created by Molnar Kristian on 5/4/16.
//  Copyright © 2016 AzinecLLC. All rights reserved.
//

import UIKit
import Kingfisher
import SwiftyJSON

class APPImages: NSObject {
  
  
  func setUpBackground(imageView:UIImageView, urlString:String) {
    imageView.layer.masksToBounds = true
    let url = NSURL(string: urlString)
    
    var cachename = urlString
    
    let myCache = ImageCache(name: cachename)
    
    
    let optionInfo: KingfisherOptionsInfo = [
      .TargetCache(myCache),
      .DownloadPriority(1),
      .Transition(ImageTransition.Fade(1))
    ]
    
    imageView.kf_setImageWithURL(url!, placeholderImage: UIImage(named: "Google"), optionsInfo: optionInfo, progressBlock: { (receivedSize, totalSize) in
      
    }) { (image, error, cacheType, imageURL) in
      
      
    }
    
  }
  
}


