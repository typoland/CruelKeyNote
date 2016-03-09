//
//  Day.swift
//  CruelKeyNote
//
//  Created by Łukasz Dziedzic on 21/03/15.
//  Copyright (c) 2015 Łukasz Dziedzic. All rights reserved.
//

import Foundation
import CoreData

class CKNDay: NSManagedObject {

    @NSManaged var duration: NSNumber
    @NSManaged var startDate: NSDate
    @NSManaged var events: NSOrderedSet

}
