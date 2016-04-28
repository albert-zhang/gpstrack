//
//  SettingManager.swift
//  GPSTrack
//
//  Created by Albert Zhang on 4/28/16.
//  Copyright © 2016 Albert Zhang. All rights reserved.
//

import UIKit

class SettingManager: NSObject {
    private static var _recordInterval:NSTimeInterval?
    static var recordInterval:NSTimeInterval {
        get {
            if _recordInterval == nil {
                _recordInterval = 0
                if let saved = NSUserDefaults.standardUserDefaults().objectForKey(UserDefaultsKeys.RecordInterval.rawValue) {
                    _recordInterval = saved.doubleValue
                }
            }
            if _recordInterval! == 0 {
                return Defs.defaultRecordInterval
            }
            return _recordInterval!
        }
    }

    static func saveRecordInterval(value:NSTimeInterval) {
        NSUserDefaults.standardUserDefaults().setObject(value, forKey: UserDefaultsKeys.RecordInterval.rawValue)
        _recordInterval = value
    }
}
