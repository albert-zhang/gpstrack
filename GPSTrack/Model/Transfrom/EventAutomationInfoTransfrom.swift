//
//  EventAutomationInfo.swift
//  GPSTrack
//
//  Created by Albert Zhang on 3/31/16.
//  Copyright © 2016 Albert Zhang. All rights reserved.
//

import UIKit

class EventAutomationInfoTransform: NSValueTransformer {

    override class func transformedValueClass() -> AnyClass {
        return EventAutomationInfo.self;
    }

    override class func allowsReverseTransformation() -> Bool {
        return true;
    }

    override func transformedValue(value: AnyObject?) -> AnyObject? {
        let info = value as! EventAutomationInfo;
        let data = NSMutableData()
        let archiver = NSKeyedArchiver(forWritingWithMutableData: data)
        info.encodeWithCoder(archiver)
        archiver.finishEncoding()
        return NSData(data: data)
    }

    override func reverseTransformedValue(value: AnyObject?) -> AnyObject? {
        let data = value as! NSData
        let unarchiver = NSKeyedUnarchiver(forReadingWithData: data)
        let info = EventAutomationInfo(coder: unarchiver)
        unarchiver.finishDecoding()
        return info
    }
}
