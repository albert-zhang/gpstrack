//
//  UIApplication+Ext.swift
//  GPSTrack
//
//  Created by Albert Zhang on 3/30/16.
//  Copyright © 2016 Albert Zhang. All rights reserved.
//

import UIKit

extension UIApplication {
    static func appVersionString() -> String{
        return NSBundle.mainBundle().objectForInfoDictionaryKey("CFBundleShortVersionString") as! String
    }

    static func appDocumentDirectory() -> String? {
        let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
        return paths.first
    }
}
