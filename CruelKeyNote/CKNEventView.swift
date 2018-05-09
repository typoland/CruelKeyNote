//
//  CKNEventView.swift
//  CruelKeyNote
//
//  Created by Łukasz Dziedzic on 15/03/16.
//  Copyright © 2016 Łukasz Dziedzic. All rights reserved.
//

import Foundation
import AppKit
var CKNCurrentEvent:Event? = nil
let CKNEventViewClickOn = "com.typoland.cruelKeyNote.eventClickOn"
//let CKNEventViewClickOff = "com.typoland.cruelKeyNote.eventClickOff"

class CKNEventView:NSView {
    var event:Event?
    var eventClicked = false
    init (withEvent:Event) {
        //Swift.print("DayViewInit")
        
        let height:CGFloat = 100.0
        self.event  = withEvent
        super.init(frame: NSMakeRect(20, 20, 20, height))
        
    }
    
    required init?(coder: NSCoder) {
        self.event = nil
        super.init(coder: coder)
        //fatalError("init(coder:) has not been implemented")
    }
    override func mouseDown(theEvent: NSEvent) {
        NSNotificationCenter.defaultCenter().postNotificationName(CKNEventViewClickOn, object: self.event)
        eventClicked = true
    }
    override func mouseUp(theEvent: NSEvent) {
        NSNotificationCenter.defaultCenter().postNotificationName(CKNEventViewClickOn, object: nil)
        eventClicked = false
    }
    
    override func drawRect(dirtyRect: NSRect) {
        //NSColor.blueColor().set()
        
        var stringAttr:[String:AnyObject] = [String:AnyObject]()
        if event != nil {
            
            let (eventStartTime, eventEndTime) = event!.day!.eventTimes(event!)
            if eventClicked {
                NSColor.redColor().set()
            } else if NSDate().compare(eventStartTime) == NSComparisonResult.OrderedAscending {
                NSColor.lightGrayColor().set()
                stringAttr[NSForegroundColorAttributeName] = NSColor.blackColor()
            } else if (NSDate().compare(eventStartTime) == NSComparisonResult.OrderedDescending) && (NSDate().compare(eventEndTime) == NSComparisonResult.OrderedAscending)  {
                NSColor.whiteColor().set()
                CKNCurrentEvent = event
            } else {
                NSColor.darkGrayColor().set()
            }
               
                    
            
            
            NSBezierPath(roundedRect: dirtyRect, xRadius: 5.0, yRadius: 5.0).fill()
            let paragraphStyle:NSMutableParagraphStyle = NSMutableParagraphStyle()
            paragraphStyle.maximumLineHeight = 14.0
            
            let font: NSFont = NSFont(name: "LatoOT Regular", size: 13.0)!
            
            let fontDescriptor = font.fontDescriptor.fontDescriptorByAddingAttributes([
                NSFontFeatureSettingsAttribute: [
                    [
                        NSFontFeatureTypeIdentifierKey: kNumberCaseType,
                        NSFontFeatureSelectorIdentifierKey: kLowerCaseNumbersSelector
                    ],
                    [
                        NSFontFeatureTypeIdentifierKey: kNumberSpacingType,
                        NSFontFeatureSelectorIdentifierKey: kProportionalNumbersSelector
                    ],
                    [
                        NSFontFeatureTypeIdentifierKey: kLigaturesType,
                        NSFontFeatureSelectorIdentifierKey: kCommonLigaturesOnSelector
                    ],
                    [
                        NSFontFeatureTypeIdentifierKey: kLigaturesType,
                        NSFontFeatureSelectorIdentifierKey: kRareLigaturesOnSelector
                    ]
                ]
                ])
            
            stringAttr [NSForegroundColorAttributeName] = NSColor.blackColor()
            stringAttr [NSFontAttributeName] = NSFont(descriptor: fontDescriptor, size: 13.0)!
            stringAttr [NSParagraphStyleAttributeName] = paragraphStyle
            
            
            let dateFormatter = NSDateFormatter()
            dateFormatter.dateFormat = "H:mm" //NSDateFormatterStyle.NoStyle
            //dateFormatter.timeStyle = NSDateFormatterStyle.ShortStyle
            
            let eventTimeStartString:NSString = dateFormatter.stringFromDate(eventStartTime)
            
            eventTimeStartString.drawAtPoint(NSMakePoint(dirtyRect.origin.x+3, dirtyRect.origin.y+2), withAttributes: stringAttr)
            
            if let title:NSString = event!.title  {
                title.drawInRect(NSMakeRect(dirtyRect.origin.x+3, dirtyRect.origin.y+3,  dirtyRect.width-6, dirtyRect.height-6), withAttributes: stringAttr)
            }
        }
    }
}
