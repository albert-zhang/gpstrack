//
//  UIColor+Ext.swift
//  GPSTrack
//
//  Created by Albert Zhang on 4/12/16.
//  Copyright © 2016 Albert Zhang. All rights reserved.
//

import UIKit

extension UIColor {
    static func fromHex(hex:String) -> UIColor? {
        var r:CGFloat = 0
        var g:CGFloat = 0
        var b:CGFloat = 0
        var parseIndex = 0
        var i = hex.characters.count - 2
        while i >= 0 {
            let rg = hex.startIndex.advancedBy(i)..<hex.startIndex.advancedBy(i + 2)
            let str = hex[rg]
            let scanner = NSScanner(string: str)
            var val:UInt32 = 0
            scanner.scanHexInt(&val)
            let valFloat = CGFloat(val)

            if parseIndex == 0 {
                b = valFloat / 255.0
            } else if parseIndex == 1 {
                g = valFloat / 255.0
            } else if parseIndex == 2 {
                r = valFloat / 255.0
            }
            parseIndex += 1
            if parseIndex > 2 {
                break
            }

            i -= 2
        }
        return UIColor(red: r, green: g, blue: b, alpha: 1)
    }
}
