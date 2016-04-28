//
//  EventListView.swift
//  GPSTrack
//
//  Created by Albert Zhang on 4/8/16.
//  Copyright © 2016 Albert Zhang. All rights reserved.
//

import UIKit

class EventListView: BaseView {

    private var _eventsCollection:UICollectionView
    var eventsCollection:UICollectionView {
        get {
            return _eventsCollection
        }
    }

    private var _collectionLayout:UICollectionViewFlowLayout

    override init() {
        _collectionLayout = UICollectionViewFlowLayout()
        _eventsCollection = UICollectionView(frame: .zero, collectionViewLayout: _collectionLayout)
        _collectionLayout.minimumLineSpacing = 10
        _collectionLayout.minimumInteritemSpacing = 10
        _eventsCollection.backgroundColor = UIColor.whiteColor()
        _eventsCollection.registerClass(EventCell.self, forCellWithReuseIdentifier: EventCell.RUID)
        super.init()
        addSubview(_eventsCollection)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func createLayout(topLayoutGuide topLayoutGuide: UILayoutSupport, bottomLayoutGuide: UILayoutSupport) {
        _eventsCollection.translatesAutoresizingMaskIntoConstraints = false
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-0-[_eventsCollection]-0-|",
            options: NSLayoutFormatOptions(rawValue: 0),
            metrics: nil,
            views: ["_eventsCollection": _eventsCollection]))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-0-[topLayoutGuide]-0-[_eventsCollection]-0-|",
            options: NSLayoutFormatOptions(rawValue: 0),
            metrics: nil,
            views: ["_eventsCollection": _eventsCollection, "topLayoutGuide": topLayoutGuide]))
    }

}
