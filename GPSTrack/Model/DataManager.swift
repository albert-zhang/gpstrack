//
//  DataManager.swift
//  GPSTrack
//
//  Created by Albert Zhang on 3/31/16.
//  Copyright © 2016 Albert Zhang. All rights reserved.
//

import UIKit
import BNRCoreDataStack
import CoreLocation


enum EntityNames : String {
    case LocationRecord = "LocationRecord"
    case Event          = "Event"
}


/**
 Ref: https://github.com/bignerdranch/CoreDataStack
 */

class DataManager: NSObject {

    private static var singleton:DataManager?
    static func manager() -> DataManager{
        if singleton == nil {
            singleton = DataManager()
        }
        return singleton!
    }

    private var coreDataStack:CoreDataStack?

    override init() {
        super.init()

        CoreDataStack.constructSQLiteStack(withModelName: "Model") { result in
            switch result {
            case .Success(let stack):
                self.coreDataStack = stack
            case .Failure(let error):
                print(error)
            }
        }
    }

    func save() {
        if let context = coreDataStack?.mainQueueContext {
            do {
                try context.save()
            } catch let error {
                print("context save error: \(error)")
            }
        }
    }

    // MARK: -

    private func insertEntity(name name:String) -> NSManagedObject? {
        if let context = coreDataStack?.mainQueueContext {
            let obj = NSEntityDescription.insertNewObjectForEntityForName(name, inManagedObjectContext: context)
            return obj
        }
        return nil
    }

    func insertLocationRecord(location location:CLLocation) -> LocationRecord? {
        if let obj = insertEntity(name: EntityNames.LocationRecord.rawValue) as? LocationRecord {
            obj.latitude = location.coordinate.latitude
            obj.longitude = location.coordinate.longitude
            obj.altitude = location.altitude
            obj.timestamp = NSDate()
            return obj
        }
        return nil
    }

    func insertEvent(title title:String, desc:String) -> Event? {
        if let obj = insertEntity(name: EntityNames.Event.rawValue) as? Event {
            obj.title = title
            obj.desc = desc
            obj.startDate = NSDate()
            obj.isRunning = NSNumber(bool: true)
            return obj
        }
        return nil
    }

    // MARK: -

    private func executeFetch(entityName entityName:String,
                                         predicate:NSPredicate?,
                                         sortDescriptor:NSSortDescriptor?,
                                         offset:Int?,
                                         limit:Int?) -> [AnyObject]?
    {
        let req = NSFetchRequest(entityName: entityName)
        if let pred = predicate {
            req.predicate = pred
        }
        if let sdr = sortDescriptor {
            req.sortDescriptors = [sdr]
        }
        if let ofst = offset {
            req.fetchOffset = ofst
        }
        if let lmt = limit {
            req.fetchLimit = lmt
        }

        var rs:Array<AnyObject>? = nil

        if let context = coreDataStack?.mainQueueContext {
            context.performBlockAndWait({
                do {
                    rs = try context.executeFetchRequest(req)
                } catch let error {
                    print("executeFetch error: \(error)")
                    rs = nil
                }
            })
        }

        return rs
    }

    func getEvents(isRunning isRunning:Bool?) -> [Event]? {
        var pred:NSPredicate?
        if let b = isRunning {
            pred = NSPredicate(format: "isRunning = %@", b)
        }

        let rs = executeFetch(entityName: EntityNames.Event.rawValue, predicate: pred,
                              sortDescriptor: nil, offset: nil, limit: nil) as? [Event]
        return rs
    }

    func getAllLocationRecords() -> [LocationRecord]? {
        let rs = executeFetch(entityName: EntityNames.LocationRecord.rawValue,
                              predicate: nil, sortDescriptor: nil, offset: nil, limit: nil)
        return rs as? [LocationRecord]
    }
}
