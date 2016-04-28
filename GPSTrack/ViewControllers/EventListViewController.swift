//
//  EventListViewController.swift
//  GPSTrack
//
//  Created by Albert Zhang on 4/8/16.
//  Copyright © 2016 Albert Zhang. All rights reserved.
//

import UIKit

class EventListViewController: BaseViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {

    override init() {
        super.init()
        self.automaticallyAdjustsScrollViewInsets = false
        self.title = "All Events"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        let v = EventListView()
        self.view = v
    }

    var view2:EventListView? {
        get {
            return self.view as? EventListView
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view2?.eventsCollection.dataSource = self
        view2?.eventsCollection.delegate = self
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.reload()
    }

    private var events:[Event]?

    private func reload() {
        events = DataManager.manager().getEvents(isRunning: nil)
    }

    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let evts = events {
            return evts.count
        }
        return 0
    }

    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(EventCell.RUID, forIndexPath: indexPath) as! EventCell
        let evt = events![indexPath.row]
        cell.event = evt
        if cell.editHandler == nil {
            cell.editHandler = { evtCell in
                let ctlr = EventEditViewController()
                ctlr.event = evtCell.event
                self.presentViewController(ctlr, animated: true, completion: nil)
            }
        }
        return cell
    }

//    func collectionView(collectionView: UICollectionView,
//                        layout collectionViewLayout: UICollectionViewLayout,
//                               minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat
//    {
//        return 0
//    }
//
//    func collectionView(collectionView: UICollectionView,
//                        layout collectionViewLayout: UICollectionViewLayout,
//                               minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat
//    {
//        return 0
//    }

    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize
    {
        if let sz = view2?.eventsCollection.bounds.size {
            let d = (sz.width - 21) / 3
            if indexPath.row % 3 < 2 {
                return CGSize(width: d, height: d)
            } else  {
                let d3 = sz.width - 20 - d * 2
                return CGSize(width: d3, height: d3)
            }
        }
        return CGSize.zero
    }

    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        collectionView.deselectItemAtIndexPath(indexPath, animated: true)
        let evt = events![indexPath.row]
        let ctlr = EventDetailsViewController()
        ctlr.event = evt
        self.navigationController?.pushViewController(ctlr, animated: true)
    }

}
