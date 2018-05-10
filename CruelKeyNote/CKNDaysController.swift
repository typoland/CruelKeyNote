//
//  CKNDaysController.swift
//  CruelKeyNote
//
//  Created by Łukasz Dziedzic on 21/03/15.
//  Copyright (c) 2015 Łukasz Dziedzic. All rights reserved.
//

import Foundation
import AppKit
/*
struct CKNHorizontalPosition {
var x:CGFloat = 0
var width:CGFloat = 0
}
*/
class CKNDaysController:NSArrayController {
    
    func arraySortedByKey(key:NSString) -> NSArray {
        let daysSortDescriptor:NSSortDescriptor = NSSortDescriptor(key: key as String, ascending: true)
        return (self.arrangedObjects as! NSArray).sortedArray(using: [daysSortDescriptor]) as NSArray
    }
    
    func totalDuration () -> TimeInterval {
        var duration:TimeInterval = 0
        for day in self.arrangedObjects as! [Day] {
            duration += day.duration
        }
        return duration
    }
    
    func currentEvent () -> Event? {
        for day in self.arrangedObjects as! [Day] {
            
            let  endingTime = NSDate(timeInterval: day.duration, since: day.startDate as Date)
            
            if (NSDate().compare(day.startDate as Date)  == ComparisonResult.orderedDescending) && (NSDate().compare(endingTime as Date) == ComparisonResult.orderedAscending) {
                //print("Date is OK")
                var eventsDuration:TimeInterval = 0
                for event in day.events!.array as! [Event] {
                    let eventStart = day.startDate.addingTimeInterval(eventsDuration)
                    let eventEnd = day.startDate.addingTimeInterval(eventsDuration+event.duration)
                    //print("\(eventStart)\n\(eventEnd)\n\(NSDate())")
                    if (NSDate().compare(eventStart as Date) == ComparisonResult.orderedDescending) && (NSDate().compare(eventEnd as Date) == ComparisonResult.orderedAscending) {
                        //print ("event is OK too")
                        return event
                    }
                    eventsDuration += event.duration
                }
                
            }
        }
        return nil
    }
}
