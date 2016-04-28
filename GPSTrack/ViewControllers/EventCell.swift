//
//  EventCell.swift
//  GPSTrack
//
//  Created by Albert Zhang on 4/8/16.
//  Copyright © 2016 Albert Zhang. All rights reserved.
//

import UIKit

class EventCell: UICollectionViewCell {
    static let RUID = "EventCell"

    private var titleLabel:UILabel
    private var editBtn:UIButton


    override init(frame: CGRect) {
        titleLabel = UILabel()
        titleLabel.textColor = UIColor.whiteColor()
        titleLabel.numberOfLines = 2
        titleLabel.lineBreakMode = .ByCharWrapping
        titleLabel.textAlignment = .Center
        editBtn = UIButton(type: .DetailDisclosure)
        editBtn.tintColor = UIColor.whiteColor()

        super.init(frame: frame)

        backgroundColor = UIColor.yellowColor()

        addSubview(titleLabel)
        addSubview(editBtn)

        layer.cornerRadius = 3

        editBtn.addTarget(self, action: #selector(EventCell.onEdit))

        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-[titleLabel]-|",
            options: NSLayoutFormatOptions(rawValue: 0),
            metrics: nil,
            views: ["titleLabel": titleLabel]))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-[titleLabel]-|",
            options: NSLayoutFormatOptions(rawValue: 0),
            metrics: nil,
            views: ["titleLabel": titleLabel]))

        editBtn.translatesAutoresizingMaskIntoConstraints = false
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:[editBtn]-|",
            options: NSLayoutFormatOptions(rawValue: 0),
            metrics: nil,
            views: ["editBtn": editBtn]))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-[editBtn]",
            options: NSLayoutFormatOptions(rawValue: 0),
            metrics: nil,
            views: ["editBtn": editBtn]))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private var _event:Event?
    var event:Event? {
        set (value) {
            _event = value
            titleLabel.text = _event?.title
            self.setHilightedColor(false)
        }
        get {
            return _event
        }
    }

    override var selected: Bool {
        get {
            return super.selected
        }
        set (value) {
            super.selected = value
            self.setHilightedColor(value)
        }
    }

    override var highlighted: Bool {
        get {
            return super.highlighted
        }
        set (value) {
            super.highlighted = value
            self.setHilightedColor(value)
        }
    }

    private func setHilightedColor(b:Bool) {
        if b {
            if _event?.isRunning?.boolValue == true {
                backgroundColor = UIColor.fromHex("dd4444")
            } else {
                backgroundColor = UIColor.fromHex("dd7744")
            }
        } else {
            if _event?.isRunning?.boolValue == true {
                backgroundColor = UIColor.fromHex("FF6666")
            } else {
                backgroundColor = UIColor.fromHex("FF9966")
            }
        }
    }

    typealias EventCellEditHandler = (EventCell) -> Void
    var editHandler:EventCellEditHandler?

    func onEdit() {
        if editHandler != nil {
            editHandler!(self)
        }
    }

}
