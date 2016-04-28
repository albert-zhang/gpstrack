//
//  LocationRecord+Ext.swift
//  GPSTrack
//
//  Created by Albert Zhang on 3/31/16.
//  Copyright © 2016 Albert Zhang. All rights reserved.
//

import Foundation

extension LocationRecord {

    func addEvents(events:[Event]) {
        let mute = NSMutableSet()
        if let old = self.events {
            mute.addObjectsFromArray(old.allObjects)
        }
        mute.addObjectsFromArray(events)
        self.events = NSSet(set: mute)
    }

}
