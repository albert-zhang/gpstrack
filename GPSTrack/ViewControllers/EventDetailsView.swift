//
//  EventDetailsView.swift
//  GPSTrack
//
//  Created by Albert Zhang on 4/28/16.
//  Copyright © 2016 Albert Zhang. All rights reserved.
//

import UIKit

class EventDetailsView: BaseView, UITableViewDelegate, UITableViewDataSource {
    let _titleLabel:UILabel
    let _descLabel:UILabel
    let _createTimeLabel:UILabel
    let _runningLabel:UILabel

    let _locationsTable:UITableView
    var locationsTable:UITableView {
        get {
            return _locationsTable
        }
    }

    let _toolBar:UIToolbar


    override init() {
        _titleLabel = UILabel()
        _descLabel = UILabel()
        _descLabel.font = UIFont.systemFontOfSize(13)
        _createTimeLabel = UILabel()
        _createTimeLabel.font = UIFont.systemFontOfSize(12)
        _runningLabel = UILabel()
        _locationsTable = UITableView()
        _toolBar = UIToolbar()

        super.init()

        addSubview(_titleLabel)
        addSubview(_descLabel)
        addSubview(_createTimeLabel)
        addSubview(_runningLabel)
        addSubview(_locationsTable)
        addSubview(_toolBar)

        _locationsTable.dataSource = self
        _locationsTable.delegate = self
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func createLayout(topLayoutGuide topLayoutGuide: UILayoutSupport, bottomLayoutGuide: UILayoutSupport) {
        _titleLabel.translatesAutoresizingMaskIntoConstraints = false
        _descLabel.translatesAutoresizingMaskIntoConstraints = false
        _createTimeLabel.translatesAutoresizingMaskIntoConstraints = false
        _runningLabel.translatesAutoresizingMaskIntoConstraints = false
        _locationsTable.translatesAutoresizingMaskIntoConstraints = false
        _toolBar.translatesAutoresizingMaskIntoConstraints = false

        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-[_titleLabel]-|",
            options: NSLayoutFormatOptions(rawValue: 0),
            metrics: nil,
            views: ["_titleLabel": _titleLabel]))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-[_descLabel]-|",
            options: NSLayoutFormatOptions(rawValue: 0),
            metrics: nil,
            views: ["_descLabel": _descLabel]))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-[_createTimeLabel]-|",
            options: NSLayoutFormatOptions(rawValue: 0),
            metrics: nil,
            views: ["_createTimeLabel": _createTimeLabel]))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-[_runningLabel]-|",
            options: NSLayoutFormatOptions(rawValue: 0),
            metrics: nil,
            views: ["_runningLabel": _runningLabel]))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-0-[_locationsTable]-0-|",
            options: NSLayoutFormatOptions(rawValue: 0),
            metrics: nil,
            views: ["_locationsTable": _locationsTable]))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-0-[_toolBar]-0-|",
            options: NSLayoutFormatOptions(rawValue: 0),
            metrics: nil,
            views: ["_toolBar": _toolBar]))

        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "V:[topLayoutGuide]-"
                + "[_titleLabel]-[_descLabel]-[_createTimeLabel]-[_runningLabel]"
                + "-[_locationsTable]-[_toolBar]"
                + "-0-[bottomLayoutGuide]",
            options: NSLayoutFormatOptions(rawValue: 0),
            metrics: nil,
            views: ["_titleLabel": _titleLabel,
                "_descLabel": _descLabel,
                "_createTimeLabel": _createTimeLabel,
                "_runningLabel": _runningLabel,
                "_locationsTable": _locationsTable,
                "_toolBar": _toolBar,
                "topLayoutGuide": topLayoutGuide,
                "bottomLayoutGuide": bottomLayoutGuide]))

        _locationsTable.setContentCompressionResistancePriority(749, forAxis: .Vertical)
    }


    typealias EventDetailsViewAddToolBarItemHandler = (Void) -> Void
    var toolBarItems = [UIBarButtonItem]()
    var toolBarItemActions = [String: EventDetailsViewAddToolBarItemHandler]()

    func addToolBarItem(title title:String, _ handler:EventDetailsViewAddToolBarItemHandler) {
        let item = UIBarButtonItem(title: title, style: .Plain, target: self,
                                   action: #selector(EventDetailsView.onToolBarItemAction(_:)))
        toolBarItems.append(item)
        _toolBar.items = toolBarItems
        toolBarItemActions[title] = handler
    }

    func onToolBarItemAction(item:UIBarButtonItem) {
        guard let itemTitle = item.title else { return }
        guard let handler = toolBarItemActions[itemTitle] else { return }
        handler()
    }

    private var _event:Event?
    var event:Event?{
        get {
            return _event
        }
        set(value) {
            _event = value
            _titleLabel.text = value?.title
            _descLabel.text = value?.desc
            if let sd = value?.startDate {
                _createTimeLabel.text = "Start at "
                    + NSDateFormatter.localizedStringFromDate(sd,
                                                              dateStyle: .MediumStyle,
                                                              timeStyle: .MediumStyle)
            } else {
                _createTimeLabel.text = ""
            }
            
            _runningLabel.text = (value?.isRunning?.boolValue == true) ? "Running" : "Not running"

            recordes = _event?.locationRecords
            _locationsTable.reloadData()
        }
    }


    // MARK: -

    var recordes:[LocationRecord]?

    private func reload() {
        recordes = DataManager.manager().getAllLocationRecords()
    }

    // MARK: -

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let recs = recordes {
            return recs.count
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
