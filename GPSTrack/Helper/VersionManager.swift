//
//  VersionManager.swift
//  GPSTrack
//
//  Created by Albert Zhang on 3/30/16.
//  Copyright © 2016 Albert Zhang. All rights reserved.
//

import UIKit

class VersionManager: NSObject {

    private static var singleton:VersionManager?
    static func manager() -> VersionManager {
        if singleton == nil {
            singleton = VersionManager()
        }
        return singleton!
    }

    override init() {
    }

    func compareVersionString(ver1:String, withVersion ver2:String) -> NSComparisonResult {
        let cmps1 = ver1.componentsSeparatedByString(".")
        let cmps2 = ver2.componentsSeparatedByString(".")
        let maxCount = max(cmps1.count, cmps2.count)
        for index in 0...(maxCount - 1) {
            var d1 = 0
            var d2 = 0
            if cmps1.count > index {
                d1 = Int(cmps1[index])!
            }
            if cmps2.count > index {
                d2 = Int(cmps1[index])!
            }
            if d1 > d2 {
                return .OrderedAscending
            } else if d1 < d2 {
                return .OrderedDescending
            }
        }
        return .OrderedSame
    }

    func handleVersion(){
        let lastVerOptional = NSUserDefaults.standardUserDefaults().objectForKey(UserDefaultsKeys.LastAppVersion.rawValue) as? String
        let nowVer = UIApplication.appVersionString()

        if let lastVer = lastVerOptional {
            if compareVersionString(lastVer, withVersion: nowVer) == .OrderedDescending {
                // TODO: handle version update
            }
        }

        NSUserDefaults.standardUserDefaults().setObject(nowVer, forKey: UserDefaultsKeys.LastAppVersion.rawValue)
        NSUserDefaults.standardUserDefaults().synchronize()
    }
}
