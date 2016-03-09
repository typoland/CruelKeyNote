//
//  Event.swift
//  CruelKeyNote
//
//  Created by Łukasz Dziedzic on 21/03/15.
//  Copyright (c) 2015 Łukasz Dziedzic. All rights reserved.
//

import Foundation
import CoreData

class CKNEvent: NSManagedObject {

    @NSManaged var caption: String
    @NSManaged var duration: NSNumber
    @NSManaged var id: NSNumber
    @NSManaged var imageName: String
    @NSManaged var title: String
    @NSManaged var day: CKNDay

}
