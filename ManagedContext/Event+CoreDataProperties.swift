//
//  Event+CoreDataProperties.swift
//  CruelKeyNote
//
//  Created by Łukasz Dziedzic on 09/03/16.
//  Copyright © 2016 Łukasz Dziedzic. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Event {

    @NSManaged var caption: String?
    @NSManaged var duration: Float
    @NSManaged var id: Int16
    @NSManaged var imageName: String?
    @NSManaged var title: String?
    @NSManaged var day: Day?

}
