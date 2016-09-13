//
//  APPConfig.swift
//  Tardis
//
//  Created by Molnar Kristian on 7/25/16.
//  Copyright © 2016 Molnar Kristian. All rights reserved.
//

import UIKit

class APPConfig: NSObject {
  
  let dataBaseRoot = "dev"
  
  func setUpCellForUsage(cell:UITableViewCell) {
    cell.accessoryType  = .None
    cell.selectionStyle = UITableViewCellSelectionStyle.None
    cell.backgroundColor = UIColor.clearColor()
  }
  
  
  let blueColor:UIColor! = UIColor(red: 66/255.0, green: 133/255.0, blue: 244/255.0, alpha: 1.0)
  let redColor:UIColor! =  UIColor(red: 219/255.0, green: 68/255.0, blue: 55/255.0, alpha: 1.0)
  let yellowColor:UIColor! = UIColor(red: 244/255.0, green: 180/255.0, blue: 0/255.0, alpha: 1.0)
  let greenColor:UIColor! = UIColor(red: 15/255.0, green: 157/255.0, blue: 88/255.0, alpha: 1.0)
  let appColor:UIColor! = UIColor(red: 66/255.0, green: 133/255.0, blue: 244/255.0, alpha: 1.0)
  
  
}
