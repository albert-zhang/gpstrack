//
//  Utils.swift
//  GPSTrack
//
//  Created by Albert Zhang on 4/12/16.
//  Copyright © 2016 Albert Zhang. All rights reserved.
//

import UIKit

func printInit(obj:NSObject) {
    let cls = NSStringFromClass(obj.dynamicType)
    print("\(cls) Init\t@ \(NSDate())")
}

func printDeinit(obj:NSObject) {
    let cls = NSStringFromClass(obj.dynamicType)
    print("\(cls) Deinit\t@ \(NSDate())")
}

class Utils: NSObject {

}
