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
// Insert code here to add functionality to your managed object subclass
    
    func eventTimes(event:Event) -> (NSDate, NSDate) {
        var duration:NSTimeInterval = 0
        for loopEvent:Event in events?.array as! [Event] {
            if loopEvent === event {
                return (NSDate(timeInterval: duration, sinceDate: startDate), NSDate(timeInterval: duration+event.duration, sinceDate: startDate))
            } else {
                duration += event.duration
                
            }
        }
        return (NSDate(), NSDate())
    }
}
