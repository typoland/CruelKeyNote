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
    
    func rearangeDayViews(dayViews:[Day:CKNDayView], inSuperview superview:NSView) {
        let dayGap:CGFloat = 3
        let eventGap:CGFloat = 1
        let margin:CGFloat = 0
        
        var xPos:CGFloat = margin
        
        let availableWidth = superview.frame.width - dayGap*CGFloat(self.arrangedObjects.count-1)-2 * margin
        for day in self.arraySortedByKey("startDate") as! [Day] {
            
            let width = availableWidth * CGFloat(day.duration) / CGFloat(totalDuration())
            if let view = dayViews[day] {
                
                let size = view.frame.size
                //let origin = view.frame.origin
                view.setFrameSize(NSMakeSize(width, size.height))
                view.setFrameOrigin(NSMakePoint(xPos, superview.frame.size.height - view.frame.size.height))
                var eventXPos:CGFloat = 0
                let eventsWidth = view.frame.width - CGFloat( (day.events?.count)!-1) * eventGap
                for event:Event in day.events?.array as! [Event] {
                    let eventView = view.eventsViews[event]
                    let eventWidth = eventsWidth * CGFloat(event.duration) / CGFloat(day.duration)
                    eventView?.setFrameOrigin(NSPoint(x: eventXPos, y: (eventView?.frame.origin.y)!))
                    eventView?.setFrameSize(NSMakeSize(eventWidth, view.frame.height - 52))
                    eventXPos += eventWidth + eventGap
                }
            }
            xPos = xPos+width+dayGap
        }
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