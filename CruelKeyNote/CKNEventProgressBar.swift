//
//  CKNEventProgressBar.swift
//  CruelKeyNote
//
//  Created by Łukasz Dziedzic on 15/03/16.
//  Copyright © 2016 Łukasz Dziedzic. All rights reserved.
//

import Foundation
import AppKit

class CKNEventProgressBar:NSView {
    
    var event:Event?
    
    init(withEvent:Event?) {
        self.event = withEvent
        super.init(frame: NSMakeRect(0, 0, 0, 30))
        
    }
    
    required init?(coder: NSCoder) {
        self.event = nil
        super.init(coder: coder)
        //fatalError("init(coder:) has not been implemented")
    }
    
    func refreshSize () {
        if let superview = self.superview  {
            let width = superview.frame.width
            self.setFrameSize(NSMakeSize(width, self.frame.height))
        }
    }
    
    override func draw(_ dirtyRect: NSRect) {
        if event != nil {
            //Swift.print("drawing bar")
            let (start, end) = (event!.day?.eventTimes(event: event!))!
            
            let currentDuration = NSDate().timeIntervalSince((start as NSDate) as Date)
            let width = superview!.frame.width * CGFloat(currentDuration) / CGFloat(event!.duration)
            //Swift.print (currentDuration, width)
            
            NSColor.red.set()
            let rect = NSMakeRect(0, 0, width, dirtyRect.height)
            NSBezierPath(roundedRect: rect, xRadius: 5, yRadius: 5).fill()
            
            let stringAttr:[NSAttributedStringKey:Any]  =  [
                NSAttributedStringKey.font: NSFont(name: "LatoOT-Bold", size: 24)!,
                NSAttributedStringKey.foregroundColor : NSColor.white]
            /*let stringAttr:[String:AnyObject] = [
                NSFontAttributeName : NSFont(name: "LatoOT Bold", size: 24)!,
                NSForegroundColorAttributeName : NSColor.whiteColor()]
 */
            //Swift.print("event", event)
            var titleFrameSize = NSMakeSize(0, 0)
            if let title:NSString = event!.title as NSString?  {
                //Swift.print("Let's try", title.className)
                title.draw( at: NSMakePoint(5, 1), withAttributes: stringAttr)
                titleFrameSize = title.size(withAttributes: stringAttr)
            }
            
            //let timeFromStartTillNow:NSTimeInterval = start.timeIntervalSinceDate(NSDate())
            //Swift.print (NSDate().timeIntervalSinceDate(end))
           //let intervalToString:TimeIntervalTransformer = TimeIntervalTransformer ()
            //let unitFlags:NSCalendar.Unit = NSCalendar.Unit([.hour, .minute, .second])
            let components: Set<Calendar.Component> = [.hour, .minute, .second]
            let breakdownInfo:DateComponents = Calendar.current.dateComponents(components, from: Date(), to: end as Date)

            
            let eventToEndString:NSString = NSString(format: "%02d:%02d", breakdownInfo.minute!, breakdownInfo.second!)
            let textTimeFrameSize = eventToEndString.size(withAttributes: stringAttr)
            var posX = width-textTimeFrameSize.width-5
            if posX < titleFrameSize.width + 20 {
                posX = titleFrameSize.width + 20
            }
            eventToEndString.draw(at: NSMakePoint(posX, 1), withAttributes: stringAttr)
        }
    }

}
