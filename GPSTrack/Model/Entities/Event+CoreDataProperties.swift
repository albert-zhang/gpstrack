//
//  Event+CoreDataProperties.swift
//  GPSTrack
//
//  Created by Albert Zhang on 4/7/16.
//  Copyright © 2016 Albert Zhang. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Event {

    @NSManaged var automationInfo: NSObject?
    @NSManaged var desc: String?
    @NSManaged var endDate: NSDate?
    @NSManaged var isRunning: NSNumber?
    @NSManaged var startDate: NSDate?
    @NSManaged var title: String?
    @NSManaged var recordes: NSSet?

}
