//
//  Day.swift
//  CruelKeyNote
//
//  Created by Łukasz Dziedzic on 11/03/16.
//  Copyright © 2016 Łukasz Dziedzic. All rights reserved.
//

import Foundation
import CoreData

@objc(Day)
class Day: NSManagedObject {
    override func awakeFromInsert() {
        self.startDate = NSDate()
        self.duration = 0
    }
// Insert code here to add functionality to your managed object subclass
    
    func eventTimes(event:Event) -> (NSDate, NSDate) {
        
        var duration:NSTimeInterval = 0
        
        for searchEvent:Event in events?.array as! [Event] {
            if searchEvent === event {
                return (NSDate(timeInterval: duration, sinceDate: startDate), NSDate(timeInterval: duration+event.duration, sinceDate: startDate))
             }
            duration += searchEvent.duration
        }
        return (NSDate(), NSDate())
    }
}
