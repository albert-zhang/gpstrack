//
//  GCD+Ext.swift
//  GPSTrack
//
//  Created by Albert Zhang on 4/11/16.
//  Copyright © 2016 Albert Zhang. All rights reserved.
//

import Foundation

func dispatch_after_second(second:Double, _ block: dispatch_block_t) {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(second * Double(NSEC_PER_SEC))), dispatch_get_main_queue(), block)
}
