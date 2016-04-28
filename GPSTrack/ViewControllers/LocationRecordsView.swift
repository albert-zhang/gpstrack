//
//  LocationRecordsView.swift
//  GPSTrack
//
//  Created by Albert Zhang on 4/7/16.
//  Copyright © 2016 Albert Zhang. All rights reserved.
//

import UIKit

class LocationRecordsView: BaseView {
    private var _recordsTable:UITableView
    var recordsTable:UITableView {
        get {
            return _recordsTable
        }
    }

    override init(){
        _recordsTable = UITableView()

        super.init()

        addSubview(_recordsTable)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func createLayout(topLayoutGuide topLayoutGuide: UILayoutSupport, bottomLayoutGuide: UILayoutSupport) {
        _recordsTable.translatesAutoresizingMaskIntoConstraints = false
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-0-[recordsTable]-0-|",
            options: NSLayoutFormatOptions(rawValue: 0),
            metrics: nil,
            views: ["recordsTable": _recordsTable]))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-0-[topLayoutGuide]-0-[recordsTable]-0-|",
            options: NSLayoutFormatOptions(rawValue: 0),
            metrics: nil,
            views: ["topLayoutGuide": topLayoutGuide, "recordsTable": _recordsTable]))
    }
}
