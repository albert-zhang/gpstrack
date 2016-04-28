//
//  LocationRecord+CoreDataProperties.swift
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

extension LocationRecord {

    @NSManaged var altitude: NSNumber?
    @NSManaged var latitude: NSNumber?
    @NSManaged var longitude: NSNumber?
    @NSManaged var timestamp: NSDate?
    @NSManaged var events: NSSet?

}
