//
//  UIButton+Ext.swift
//  GPSTrack
//
//  Created by Albert Zhang on 4/12/16.
//  Copyright © 2016 Albert Zhang. All rights reserved.
//

import UIKit

extension UIButton {
    func addTarget(obj:AnyObject?, action:Selector) {
        addTarget(obj, action: action, forControlEvents: .TouchUpInside)
    }
}
