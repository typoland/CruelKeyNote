//
//  CKNMainView.swift
//  CruelKeyNote
//
//  Created by Łukasz Dziedzic on 21/03/15.
//  Copyright (c) 2015 Łukasz Dziedzic. All rights reserved.
//

import Foundation
import AppKit
import CoreData

class CKNMainView:NSView {


    
    @IBOutlet weak var daysController:CKNTimeArrayController? = nil
    //@IBOutlet weak  var  imageView: NSImageView?=nil
    
    var image:NSImage?=nil
    var timer:NSTimer?=nil
    var now:NSDate=NSDate()
    let imageView:NSImageView = NSImageView(frame: NSMakeRect(0,0,0,0))
    var stringAttributes:[String:String] = [String:String]()
    
    let marginLeft:CGFloat = 5.0
    let marginRight:CGFloat = 5.0
    let margin:CGFloat = 10.0
    let dayGap:CGFloat = 5.0
    let daysBarHeight:CGFloat = 40.0
    
    

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        timer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: Selector("changeTime"), userInfo: nil, repeats: true)
     }
    override func awakeFromNib() {
        //imageView.setFrameSize(NSMakeSize( self.frame.size.width,  self.frame.size.height/2))
        imageView.imageScaling = NSImageScaling.ScaleProportionallyUpOrDown
        self.addSubview(imageView)
    }
    
    override func drawRect(rect: NSRect) {
        //println("View Updated")
        Swift.print("Time passing...")
        

        
        NSColor.blackColor().set()
        NSRectFill(rect)
        now = NSDate()
        //image:NSImage = NSImage.alloc.initWithData:(NSData *)imageData];

        //image = NSImage.im imageNamed: [event valueForKey: @"imageName"]];

        
        //var dateFormatter:NSDateFormatter = NSDateFormatter()
        //var stringAttributes = []
        
        var totalTime:NSDate = NSDate(timeIntervalSince1970: 0)
        //var duration:NSTimeInterval
        
        if let days:[Day] = daysController?.arrangedObjects as? [Day] {
            Swift.print("Counting Time")
            for day in days {
                totalTime = totalTime.dateByAddingTimeInterval(day.duration)
            }
        }
        
       let daysHeightSize = daysBarHeight - dayGap
       let daysOriginY = rect.size.height - daysBarHeight;
        var availableWidth:CGFloat = 0
        if daysController != nil {
            availableWidth = rect.size.width - (marginLeft + marginRight + (CGFloat(daysController!.arrangedObjects.count) - 1) * dayGap);
        }
        var dayOriginX = marginLeft;
        //var dayWidthSize:CGFloat;
        
        var currentEventStartDate:NSDate;
        var currentEventDuration:Double;
        var stringAttr = [String:AnyObject]()
        
        imageView.setFrameOrigin(NSMakePoint(0, 40))
        imageView.setFrameSize(NSMakeSize( rect.size.width,  rect.size.height-100))
        
        if let sortedDays:[Day] = daysController?.arraySortedByKey("startDate")  as? [Day] {
            //Swift.print(sortedDays)
            for thisDay in sortedDays {
                //Swift.print("This Day \(thisDay)")
                //let presentationDate:NSDate = thisDay.startDate
                
               // let dayWidthSize = availableWidth / CGFloat( totalTime.timeIntervalSince1970 * thisDay.duration)
                let dayWidthSize =   availableWidth * CGFloat(thisDay.duration) / CGFloat(totalTime.timeIntervalSince1970)
                
                
                let endingTime = NSDate(timeInterval: thisDay.duration, sinceDate: thisDay.startDate)
                
                if now.compare(thisDay.startDate)  == NSComparisonResult.OrderedAscending {
                    NSColor.lightGrayColor().set()
                } else if (now.compare(thisDay.startDate)  == NSComparisonResult.OrderedDescending) && (now.compare(endingTime) == NSComparisonResult.OrderedAscending) {
                    NSColor.redColor().set()
                } else {
                    NSColor.darkGrayColor().set()
                }
                Swift.print(NSMakeRect(dayOriginX, daysOriginY, dayWidthSize, daysHeightSize))
                NSBezierPath(roundedRect: NSMakeRect(dayOriginX, daysOriginY, dayWidthSize, daysHeightSize), xRadius: 5.0, yRadius: 5.0).fill()
                
                stringAttr[NSFontAttributeName] = NSFont(name: "LatoOT Black", size: 24)
                stringAttr[NSForegroundColorAttributeName] = NSColor.whiteColor()
                
                if let weekDay:NSString = thisDay.startDate.descriptionWithCalendarFormat("%A", timeZone: nil, locale: NSUserDefaults.standardUserDefaults().dictionaryRepresentation()) {
                    weekDay.drawAtPoint ( NSMakePoint(dayOriginX+dayGap, daysOriginY), withAttributes: stringAttr)

                }
                
                var allEventsDuration = 0.0
                
                
                for event in thisDay.events! {
                    allEventsDuration += event.duration
                }
                
                let eventGap:CGFloat = 1.0
                let eventsBarHeight:CGFloat = 70
                let eventsAvailableWidth = dayWidthSize-CGFloat(thisDay.events!.count-1)*eventGap;
                var dayTimePassedBy:Double = 0;
                let eventsHeightSize:CGFloat = eventsBarHeight-dayGap;
                let eventsOriginY:CGFloat = rect.size.height-daysBarHeight-eventsHeightSize-eventGap;
                var eventOriginX:CGFloat = dayOriginX;
                let titleSize:CGFloat = 60.0;
                let titleY = rect.size.height - daysBarHeight - eventsBarHeight - titleSize;
                
                
                for event in thisDay.events!.array as! [Event] {
                    let eventWidthSize = CGFloat(event.duration) / CGFloat(thisDay.duration) * eventsAvailableWidth
                    let eventStartTime = NSDate(timeInterval: dayTimePassedBy, sinceDate:  thisDay.startDate)
                    let eventEndTime =   NSDate(timeInterval: dayTimePassedBy+event.duration, sinceDate:thisDay.startDate);

                    if now.compare(eventStartTime) == NSComparisonResult.OrderedAscending {
                        NSColor.lightGrayColor().set()
                        stringAttr[NSForegroundColorAttributeName] = NSColor.blackColor()
                    } else if (now.compare(eventStartTime) == NSComparisonResult.OrderedDescending) && (now.compare(eventEndTime) == NSComparisonResult.OrderedAscending)  {
                        let currentEventStartTime = eventStartTime
                        let currentEventDuration = event.duration
                        NSColor.redColor().set()
                        
                        stringAttr[NSFontAttributeName] = NSFont(name: "LatoOT Light", size: 24)
                        stringAttr[NSForegroundColorAttributeName] = NSColor.whiteColor()
                        Swift.print("event", event)
                        if let title:NSString = event.title  {
                            Swift.print("Let's try", title.className)
                            title.drawAtPoint( NSMakePoint(marginLeft, titleY), withAttributes: stringAttr)
                            

                        }
                        if event.media != nil {
                        image = NSImage(data:(event.media!))
                        }
                        
                    } else {
                        NSColor.darkGrayColor().set()
                        //stringAttr[NSForegroundColorAttributeName] = NSColor.blackColor()
                        
                    }
                
                    
                    let eventRect = NSMakeRect(eventOriginX, eventsOriginY,  eventWidthSize, eventsHeightSize);
                    NSBezierPath(roundedRect: eventRect, xRadius: 5.0, yRadius: 5.0).fill()
                    
                    let paragraphStyle:NSMutableParagraphStyle = NSMutableParagraphStyle()
                    paragraphStyle.maximumLineHeight = 14.0
                    stringAttr[NSForegroundColorAttributeName] = NSColor.blackColor()
                    stringAttr[NSFontAttributeName] = NSFont(name: "ClanHeadNarrow Bold", size: 13.0)
                    stringAttr[NSParagraphStyleAttributeName] = paragraphStyle
                    let dateFormatter = NSDateFormatter()
                    dateFormatter.dateFormat = "" //NSDateFormatterStyle.NoStyle
                    dateFormatter.timeStyle = NSDateFormatterStyle.ShortStyle
                    
                    let eventTimeStartString:NSString = dateFormatter.stringFromDate(eventStartTime)
                    //eventStartTime.descriptionWithLocale(NSUserDefaults.standardUserDefaults().dictionaryRepresentation())
                   // let e3ventTimeStartString:NSString = eventStartTime.descriptionWithCalendarFormat("%H:%M", timeZone: nil, locale: NSUserDefaults.standardUserDefaults().dictionaryRepresentation())!
                    
                    eventTimeStartString.drawAtPoint(NSMakePoint(eventOriginX+eventGap, eventsOriginY), withAttributes: stringAttr)
                    if let title:NSString = event.title  {
                        title.drawInRect(NSMakeRect(eventOriginX+3, eventsOriginY+3,  eventWidthSize-6, eventsHeightSize-6), withAttributes: stringAttr)
                    }

                    eventOriginX += eventWidthSize+eventGap;
                    dayTimePassedBy += event.duration;

                }
                dayOriginX += dayWidthSize+dayGap

            }
            //tu
            if image != nil {
                imageView.image = image
            }
        }
    }
    
    func changeTime() {
        self.needsDisplay=true
       
    }

}
