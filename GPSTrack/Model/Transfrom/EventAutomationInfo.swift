//
//  EventAutomationInfo.swift
//  GPSTrack
//
//  Created by Albert Zhang on 3/31/16.
//  Copyright © 2016 Albert Zhang. All rights reserved.
//

import UIKit
import CoreLocation

enum EventAutomationType : Int {
    case None               = 0
    case StartOnEnterRegion = 1
    case EndOnExitRegion    = 2
}

class EventAutomationInfo: NSObject , NSCoding {
    var automationType:EventAutomationType = .None
    var region:CLCircularRegion?

    required init?(coder aDecoder: NSCoder) {
        super.init()

        automationType = EventAutomationType(rawValue: aDecoder.decodeIntegerForKey("automationType"))!

        let regionCenterLat = aDecoder.decodeDoubleForKey("region.center.latitude")
        let regionCenterLng = aDecoder.decodeDoubleForKey("region.center.longitude")
        let regionRadius = aDecoder.decodeDoubleForKey("region.radius")

        if regionRadius > 0 {
            let uuid = NSUUID().UUIDString;
            region = CLCircularRegion(center: CLLocationCoordinate2D(latitude: regionCenterLat, longitude: regionCenterLng),
                                      radius: regionRadius,
                                      identifier: uuid);
        }
    }

    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeInteger(automationType.rawValue, forKey: "automationType")

        if let reg = region {
            aCoder.encodeDouble(reg.center.latitude, forKey: "region.center.latitude")
            aCoder.encodeDouble(reg.center.longitude, forKey: "region.center.longitude")
            aCoder.encodeDouble(reg.radius, forKey: "region.radius")

        } else {
            aCoder.encodeDouble(0, forKey: "region.center.latitude")
            aCoder.encodeDouble(0, forKey: "region.center.longitude")
            aCoder.encodeDouble(0, forKey: "region.radius")
        }
    }
}
