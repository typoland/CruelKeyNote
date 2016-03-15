//
//  DayView.swift
//  CruelKeyNote
//
//  Created by Łukasz Dziedzic on 15/03/16.
//  Copyright © 2016 Łukasz Dziedzic. All rights reserved.
//

import Foundation
import AppKit

struct CKNColors {
    static var past:NSColor = NSColor.darkGrayColor()
    static var now:NSColor = NSColor.redColor()
    static var future:NSColor = NSColor.lightGrayColor()
}

class CKNDayView:NSView {
    var day:Day?
    var eventsViews:[Event:CKNEventView] = [Event:CKNEventView] ()
    //var totalDuration:NSTimeInterval
    
    var dayFormatter:NSDateFormatter = NSDateFormatter()
    //var availableWidth:CGFloat = 0
    
    init (withDay:Day) {
        //Swift.print("DayViewInit")
        
        let height:CGFloat = 100.0
        self.day = withDay
        dayFormatter.dateFormat = "EEEE"
        super.init(frame: NSMakeRect(20, 20, 20, height))
        
    }
    
    required init?(coder: NSCoder) {
        //Swift.print("Init Coder!!!")
        day = nil
        dayFormatter.dateFormat = "EEEE"
        super.init(coder: coder)
    }
    override func awakeFromNib() {
        Swift.print("Will not work AWAKE!!!")
    }
    
    
    
    
    override func drawRect(dirtyRect: NSRect) {

        if let thisDay = day {
            let  endingTime = NSDate(timeInterval: thisDay.duration, sinceDate: thisDay.startDate)
            
            if NSDate().compare(thisDay.startDate) == NSComparisonResult.OrderedAscending {
                CKNColors.future.set()
            } else if (NSDate().compare(thisDay.startDate)  == NSComparisonResult.OrderedDescending) && (NSDate().compare(endingTime) == NSComparisonResult.OrderedAscending) {
                CKNColors.now.set()
            } else {
                CKNColors.past.set()
            }
            
            let dayBarSize:CGFloat = 30
            let dayRect = NSMakeRect(dirtyRect.origin.x, dirtyRect.size.height - dayBarSize, dirtyRect.width, 30)
            NSBezierPath(roundedRect: dayRect, xRadius: 5.0, yRadius: 5.0).fill()
            
            let attr:[String:AnyObject]  =  [
                NSFontAttributeName : NSFont(name: "LatoOT Black", size: 24)!,
                NSForegroundColorAttributeName : NSColor.whiteColor()]
            
            if let weekDay:NSString = dayFormatter.stringFromDate(thisDay.startDate) {
                //Swift.print(thisDay.startDate, weekDay)
                weekDay.drawAtPoint(NSMakePoint(5, dirtyRect.size.height-(dayBarSize-1)), withAttributes: attr)
            }
            
           
           
        }
    }
}