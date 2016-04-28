//
//  GoogleEarthHelper.swift
//  GPSTrack
//
//  Created by Albert Zhang on 4/28/16.
//  Copyright © 2016 Albert Zhang. All rights reserved.
//

import UIKit

class GoogleEarthHelper: NSObject {
    static func exportKML(event:Event) throws {
        var template = try KMLTemplate()
        template = template?.stringByReplacingOccurrencesOfString("{kmlName}", withString: event.title!)
        template = template?.stringByReplacingOccurrencesOfString("{lineColor}", withString: "ffffffff")
        template = template?.stringByReplacingOccurrencesOfString("{lineWidth}", withString: "1")
        var coordinates = ""
        if let records = event.locationRecords {
            for rec in records {
                var lat = 0.0
                if rec.latitude != nil {
                    lat = rec.latitude!.doubleValue
                }
                var lng = 0.0
                if rec.longitude != nil {
                    lng = rec.longitude!.doubleValue
                }
                var alt = 0.0
                if rec.altitude != nil {
                    alt = rec.altitude!.doubleValue
                }
                coordinates += "\(lng),\(lat),\(alt) "
            }
        }
        template = template?.stringByReplacingOccurrencesOfString("{coordinates}", withString: coordinates)

        var fn = event.title!
        let reg = try NSRegularExpression(pattern: "[^a-zA-Z0-9]", options: NSRegularExpressionOptions(rawValue: 0))
        fn = reg.stringByReplacingMatchesInString(fn, options: NSMatchingOptions(rawValue: 0),
                                                  range: NSRange(location: 0, length: fn.characters.count),
                                                  withTemplate: "")
        if fn.characters.count == 0 {
            fn = "Event"
        }

        var destURL = NSURL(fileURLWithPath: UIApplication.appDocumentDirectory()!)
        destURL = destURL.URLByAppendingPathComponent(fn + ".kml")
        try template?.writeToURL(destURL, atomically: true, encoding: NSUTF8StringEncoding)
    }

    static func KMLTemplate() throws -> String? {
        let fp = NSBundle.mainBundle().pathForResource("kml-template", ofType: "xml")!
        let contents = try String(contentsOfFile: fp, encoding: NSUTF8StringEncoding)
        return contents
    }
}
