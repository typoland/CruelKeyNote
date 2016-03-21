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
        return (self.arrangedObjects as! NSArray).sortedArrayUsingDescriptors([daysSortDescriptor])
    }
    
    func totalDuration () -> NSTimeInterval {
        var duration:NSTimeInterval = 0
        for day in self.arrangedObjects as! [Day] {
            duration += day.duration
        }
        return duration
    }
    
    func currentEvent () -> Event? {
        for day in self.arrangedObjects as! [Day] {
            
            let  endingTime = NSDate(timeInterval: day.duration, sinceDate: day.startDate)
            
            if (NSDate().compare(day.startDate)  == NSComparisonResult.OrderedDescending) && (NSDate().compare(endingTime) == NSComparisonResult.OrderedAscending) {
                //print("Date is OK")
                var eventsDuration:NSTimeInterval = 0
                for event in day.events!.array as! [Event] {
                    let eventStart = day.startDate.dateByAddingTimeInterval(eventsDuration)
                    let eventEnd = day.startDate.dateByAddingTimeInterval(eventsDuration+event.duration)
                    //print("\(eventStart)\n\(eventEnd)\n\(NSDate())")
                    if (NSDate().compare(eventStart) == NSComparisonResult.OrderedDescending) && (NSDate().compare(eventEnd) == NSComparisonResult.OrderedAscending) {
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