//
//  ViewController.swift
//  GPSTrack
//
//  Created by Albert Zhang on 3/30/16.
//  Copyright © 2016 Albert Zhang. All rights reserved.
//

import UIKit

class HomeViewController: BaseViewController {

    private var recordTimer:NSTimer?

    override func loadView() {
        let v = HomeView()
        self.view = v
    }

    var view2:HomeView? {
        get {
            return self.view as? HomeView
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        btn("StartRecord", action: #selector(HomeViewController.onStart))
        btn("StopRecord", action: #selector(HomeViewController.onStop))
        btn("AllLocations", action: #selector(HomeViewController.onAllLocationRecords))
        btn("AllEvents", action: #selector(HomeViewController.onAllEvents))
        btn("CreateEvent", action: #selector(HomeViewController.onCreateEvents))
    }


    private var btnY:CGFloat = 30
    private func btn(title:String, action:Selector) {
        let btn3 = UIButton(type: .System)
        btn3.titleLabel?.font = UIFont.boldSystemFontOfSize(40)
        btn3.setTitle(title, forState: .Normal)
        self.view.addSubview(btn3)
        btn3.addTarget(self, action: action, forControlEvents: .TouchUpInside)
        btn3.translatesAutoresizingMaskIntoConstraints = false
        self.view.addConstraint(NSLayoutConstraint(item: btn3, attribute: .Top, relatedBy: .Equal,
            toItem: self.topLayoutGuide, attribute: .Bottom, multiplier: 1, constant: btnY))
        self.view.addConstraint(NSLayoutConstraint(item: btn3, attribute: .CenterX, relatedBy: .Equal,
            toItem: self.view, attribute: .CenterX, multiplier: 1, constant: 0))
        btnY += 80
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func onAllLocationRecords() {
        let ctlr = LocationRecordsViewController()
        self.navigationController?.pushViewController(ctlr, animated: true)
    }

    func onAllEvents(){
        let ctlr = EventListViewController()
        self.navigationController?.pushViewController(ctlr, animated: true)
    }

    func onCreateEvents() {
        let ctlr = EventEditViewController()
        self.presentViewController(ctlr, animated: true, completion: nil)
    }


    func onStart() {
        LocationService.service().checkPermission { result in
            if result {
                LocationService.service().start()
                self.startRecordTimer()
            } else {
                print("location service denied")
            }
        }
    }

    func onStop() {
        LocationService.service().stop()
        self.stopRecordTimer()
    }

    func startRecordTimer() {
        if recordTimer != nil {
            return
        }
        recordTimer = NSTimer.scheduledTimerWithTimeInterval(SettingManager.recordInterval,
                                                             target: self, selector: #selector(onRecordTimer),
                                                             userInfo: nil, repeats: true)
    }

    func stopRecordTimer() {
        if recordTimer == nil {
            return
        }
        recordTimer?.invalidate()
        recordTimer = nil
    }

    func onRecordTimer() {
        guard let loc = LocationService.service().lastLocation else { return }
        guard let lr = DataManager.manager().insertLocationRecord(location: loc) else { return }
        guard let evts = DataManager.manager().getEvents(isRunning: true) else { return }
        var fixedEvts = [Event]()
        fixedEvts.appendContentsOf(evts)
        if fixedEvts.count == 0 {
            let autoEvtTitle = "Event "
                + NSDateFormatter.localizedStringFromDate(NSDate(), dateStyle: .ShortStyle, timeStyle: .ShortStyle)
            let autoEvt = DataManager.manager().insertEvent(title: autoEvtTitle, desc: "")
            fixedEvts.append(autoEvt!)
        }
        lr.addEvents(fixedEvts)

    }

}

