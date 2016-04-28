//
//  Event+Ext.swift
//  GPSTrack
//
//  Created by Albert Zhang on 3/31/16.
//  Copyright © 2016 Albert Zhang. All rights reserved.
//

import Foundation

extension Event {
    var locationRecords:[LocationRecord]? {
        get {
            let sdr = NSSortDescriptor(key: "timestamp", ascending: true)
            return recordes?.sortedArrayUsingDescriptors([sdr]) as? [LocationRecord]
        }
    }
}
