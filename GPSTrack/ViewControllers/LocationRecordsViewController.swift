//
//  LocationRecordsViewController.swift
//  GPSTrack
//
//  Created by Albert Zhang on 4/7/16.
//  Copyright © 2016 Albert Zhang. All rights reserved.
//

import UIKit

class LocationRecordsViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource {

    override init() {
        super.init()
        self.automaticallyAdjustsScrollViewInsets = false
        self.title = "All Location Records"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        let v = LocationRecordsView()
        self.view = v
    }

    var view2:LocationRecordsView? {
        get {
            return self.view as? LocationRecordsView
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view2?.recordsTable.dataSource = self
        view2?.recordsTable.delegate = self
        view2?.recordsTable.rowHeight = 40
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.reload()
    }


    // MARK: -

    var recordes:[LocationRecord]?

    private func reload() {
        recordes = DataManager.manager().getAllLocationRecords()
    }

    // MARK: -

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let rs = recordes {
            return rs.count
        }
        return 0
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let RUID = "ruid";
        var cell:UITableViewCell? = tableView.dequeueReusableCellWithIdentifier(RUID)
        if cell == nil {
            cell = UITableViewCell(style: .Value2, reuseIdentifier: RUID)
            cell?.textLabel?.font = UIFont.systemFontOfSize(12)
            cell?.detailTextLabel?.font = UIFont.systemFontOfSize(10)
        }
        let lr = recordes![indexPath.row]
        cell?.textLabel?.text = "\(lr.timestamp!)"
        cell?.detailTextLabel?.text = "\(lr.latitude!), \(lr.longitude!), \(lr.altitude!)"
        return cell!
    }

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath){

    }

}
