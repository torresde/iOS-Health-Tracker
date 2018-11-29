//
//  Set+CoreDataProperties.swift
//  Health Tracker
//
//  Created by Naveen Varadharaj on 11/29/18.
//  Copyright © 2018 CS4278FinalProject. All rights reserved.
//
//

import Foundation
import CoreData


extension Set {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Set> {
        return NSFetchRequest<Set>(entityName: "Set")
    }

    @NSManaged public var reps: Int16
    @NSManaged public var weights: Int16

}
