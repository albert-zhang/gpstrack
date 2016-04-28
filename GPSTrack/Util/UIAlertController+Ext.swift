//
//  UIAlert+Ext.swift
//  GPSTrack
//
//  Created by Albert Zhang on 4/28/16.
//  Copyright © 2016 Albert Zhang. All rights reserved.
//

import UIKit

extension UIAlertController {
    class func showAlert(title title:String?, message:String?) -> UIAlertController {
        let root =  UIApplication.sharedApplication().keyWindow?.rootViewController
        let ctlr = UIAlertController(title: title, message: message, preferredStyle: .Alert)
        ctlr.addAction(UIAlertAction(title: "Dismiss", style: .Cancel, handler: { (action) in
            root?.dismissViewControllerAnimated(true, completion: nil)
        }))
        root?.presentViewController(ctlr, animated: true, completion: nil)
        return ctlr
    }
}
