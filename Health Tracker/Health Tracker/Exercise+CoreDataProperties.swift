//
//  Exercise+CoreDataProperties.swift
//  Health Tracker
//
//  Created by Naveen Varadharaj on 11/29/18.
//  Copyright © 2018 CS4278FinalProject. All rights reserved.
//
//

import Foundation
import CoreData


extension Exercise {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Exercise> {
        return NSFetchRequest<Exercise>(entityName: "Exercise")
    }

    @NSManaged public var type: String?

}
