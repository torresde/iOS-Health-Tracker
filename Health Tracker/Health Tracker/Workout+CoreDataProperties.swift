//
//  Workout+CoreDataProperties.swift
//  Health Tracker
//
//  Created by Naveen Varadharaj on 11/29/18.
//  Copyright © 2018 CS4278FinalProject. All rights reserved.
//
//

import Foundation
import CoreData


extension Workout {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Workout> {
        return NSFetchRequest<Workout>(entityName: "Workout")
    }

    @NSManaged public var name: String?
    //@NSManaged public var date: NSDate?

}
