//
//  EventDetailsView.swift
//  GPSTrack
//
//  Created by Albert Zhang on 4/8/16.
//  Copyright © 2016 Albert Zhang. All rights reserved.
//

import UIKit

class EventEditView: BaseView {

    private var _dismissBtn:UIButton
    var dismissBtn:UIButton {
        get {
            return _dismissBtn
        }
    }

    private var _eventTitleField:UITextField
    var eventTitleField:UITextField {
        get {
            return _eventTitleField
        }
    }

    private var _eventDescField:UITextView
    var eventDescField:UITextView {
        get {
            return _eventDescField
        }
    }

    private var _runningSwitch:UISwitch
    var runningSwitch:UISwitch {
        get {
            return _runningSwitch
        }
    }

    private var _okBtn:UIButton
    var okBtn:UIButton {
        get {
            return _okBtn
        }
    }

    override init() {
        _dismissBtn = UIButton(type: .System)
        _dismissBtn.tintColor = UIColor.whiteColor()
        _dismissBtn.setTitle("Dismiss", forState: .Normal)

        _eventTitleField = UITextField()
        _eventTitleField.borderStyle = .RoundedRect

        _eventDescField = UITextView()

        _runningSwitch = UISwitch()

        _okBtn = UIButton(type: .System)
        _okBtn.tintColor = UIColor.whiteColor()
        _okBtn.setTitle("Save", forState: .Normal)

        super.init()

        backgroundColor = UIColor.fromHex("009999")
        addSubview(_dismissBtn)
        addSubview(_eventTitleField)
        addSubview(_eventDescField)
        addSubview(_runningSwitch)
        addSubview(_okBtn)

        layer.cornerRadius = 3
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    override func createLayout(topLayoutGuide topLayoutGuide: UILayoutSupport, bottomLayoutGuide: UILayoutSupport) {
        _dismissBtn.translatesAutoresizingMaskIntoConstraints = false
        addConstraints(
            NSLayoutConstraint.constraintsWithVisualFormat("V:|-[_dismissBtn]",
                options: NSLayoutFormatOptions(rawValue: 0),
                metrics: nil,
                views: ["_dismissBtn": _dismissBtn]))
        addConstraints(
            NSLayoutConstraint.constraintsWithVisualFormat("H:|-[_dismissBtn]",
                options: NSLayoutFormatOptions(rawValue: 0),
                metrics: nil,
                views: ["_dismissBtn": _dismissBtn]))

        _okBtn.translatesAutoresizingMaskIntoConstraints = false
        _okBtn.translatesAutoresizingMaskIntoConstraints = false
        addConstraints(
            NSLayoutConstraint.constraintsWithVisualFormat("V:|-[_okBtn]",
                options: NSLayoutFormatOptions(rawValue: 0),
                metrics: nil,
                views: ["_okBtn": _okBtn]))
        addConstraints(
            NSLayoutConstraint.constraintsWithVisualFormat("H:[_okBtn]-|",
                options: NSLayoutFormatOptions(rawValue: 0),
                metrics: nil,
                views: ["_okBtn": _okBtn]))

        _eventTitleField.translatesAutoresizingMaskIntoConstraints = false
        _eventDescField.translatesAutoresizingMaskIntoConstraints = false
        addConstraints(
            NSLayoutConstraint.constraintsWithVisualFormat("H:|-10-[_eventTitleField]-10-|",
                options: NSLayoutFormatOptions(rawValue: 0),
                metrics: nil,
                views: ["_eventTitleField": _eventTitleField]))
        addConstraints(
            NSLayoutConstraint.constraintsWithVisualFormat("H:|-10-[_eventDescField]-10-|",
                options: NSLayoutFormatOptions(rawValue: 0),
                metrics: nil,
                views: ["_eventDescField": _eventDescField]))
        addConstraints(
            NSLayoutConstraint.constraintsWithVisualFormat("V:[_eventDescField(==60)]",
                options: NSLayoutFormatOptions(rawValue: 0),
                metrics: nil,
                views: ["_eventDescField": _eventDescField]))
        addConstraints(
            NSLayoutConstraint.constraintsWithVisualFormat("V:|-100-[_eventTitleField]-20-[_eventDescField]",
                options: NSLayoutFormatOptions(rawValue: 0),
                metrics: nil,
                views: ["_eventTitleField": _eventTitleField, "_eventDescField": _eventDescField]))

        _runningSwitch.translatesAutoresizingMaskIntoConstraints = false
        addConstraint(
            NSLayoutConstraint(item: _runningSwitch, attribute: .CenterX,
                relatedBy: .Equal,
                toItem: self, attribute: .CenterX,
                multiplier: 1, constant: 0))
        addConstraint(
            NSLayoutConstraint(item: _runningSwitch, attribute: .Top,
                relatedBy: .Equal,
                toItem: _eventDescField, attribute: .Bottom,
                multiplier: 1, constant: 30))

    }

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
