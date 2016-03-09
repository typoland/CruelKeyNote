//
//  Day+CoreDataProperties.swift
//  CruelKeyNote
//
//  Created by Łukasz Dziedzic on 08/03/16.
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
    @NSManaged var events: NSOrderedSet?
    
    func addEventObject(value: Event) {
        print("it works")
        self.mutableSetValueForKey("events").addObject(value)
    }
    
   
    
    
    /*
    - (void)insertObject:(SubItem *)value inSubitemsAtIndex:(NSUInteger)idx;
    - (void)removeObjectFromSubitemsAtIndex:(NSUInteger)idx;
    - (void)insertSubitems:(NSArray *)value atIndexes:(NSIndexSet *)indexes;
    - (void)removeSubitemsAtIndexes:(NSIndexSet *)indexes;
    - (void)replaceObjectInSubitemsAtIndex:(NSUInteger)idx withObject:(SubItem *)value;
    - (void)replaceSubitemsAtIndexes:(NSIndexSet *)indexes withSubitems:(NSArray *)values;
    ---- (void)addSubitemsObject:(SubItem *)value;
    - (void)removeSubitemsObject:(SubItem *)value;
    - (void)addSubitems:(NSOrderedSet *)values;
    - (void)removeSubitems:(NSOrderedSet *)values;
*/
}
