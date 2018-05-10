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
    static var past:NSColor = NSColor.darkGray
    static var now:NSColor = NSColor.red
    static var future:NSColor = NSColor.lightGray
}

class CKNDayView:NSView {
    var day:Day?
    var eventsViews:[Event:CKNEventView] = [Event:CKNEventView] ()
    //var totalDuration:NSTimeInterval
    
    var dayFormatter:DateFormatter = DateFormatter()
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
    
    
    
    
    
    override func draw(_ dirtyRect: NSRect) {

        if let thisDay = day {
            let  endingTime = NSDate(timeInterval: thisDay.duration, since: thisDay.startDate as Date)
            
            if NSDate().compare(thisDay.startDate as Date) == ComparisonResult.orderedAscending {
                CKNColors.future.set()
            } else if (NSDate().compare(thisDay.startDate as Date)  == ComparisonResult.orderedDescending) && (NSDate().compare(endingTime as Date) == ComparisonResult.orderedAscending) {
                CKNColors.now.set()
            } else {
                CKNColors.past.set()
            }
            
            let dayBarSize:CGFloat = 30
            let dayRect = NSMakeRect(dirtyRect.origin.x, dirtyRect.size.height - dayBarSize, dirtyRect.width, 30)
            NSBezierPath(roundedRect: dayRect, xRadius: 5.0, yRadius: 5.0).fill()
            
            let attr:[NSAttributedStringKey:Any]  =  [
                 NSAttributedStringKey.font: NSFont(name: "LatoOT-Bold", size: 24)!,
                NSAttributedStringKey.foregroundColor : NSColor.white]
            
            let weekDay = dayFormatter.string(from: (thisDay.startDate as Date))
                //Swift.print(thisDay.startDate, weekDay)
            weekDay.draw(at: NSMakePoint(5, dirtyRect.size.height-(dayBarSize-1)), withAttributes: attr)
            
            
           
           
        }
    }
}
