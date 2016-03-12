//
//  Day+CoreDataProperties.swift
//  CruelKeyNote
//
//  Created by Łukasz Dziedzic on 11/03/16.
//  Copyright © 2016 Łukasz Dziedzic. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Day {

    @NSManaged var duration: Float
    @NSManaged var startDate: NSTimeInterval
    @NSManaged var title: String?
    @NSManaged var events: NSOrderedSet?

}
