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
let CKNEventViewClickOn = NSNotification.Name (rawValue: "com.typoland.cruelKeyNote.eventClickOn")
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
    
    override func mouseDown(with theEvent: NSEvent) {
        NotificationCenter.default.post(name: CKNEventViewClickOn, object: self.event)
        eventClicked = true
    }
    override func mouseUp(with theEvent: NSEvent) {
        NotificationCenter.default.post(name: CKNEventViewClickOn, object: nil)
        eventClicked = false
    }
    
    override func draw(_ dirtyRect: NSRect) {
        //NSColor.blueColor().set()
        
        var stringAttr = [NSAttributedStringKey:Any]()
        if let event = event {
            
            let (eventStartTime, eventEndTime) = event.day!.eventTimes(event: event)
            if eventClicked {
                NSColor.red.set()
            } else if NSDate().compare(eventStartTime as Date) == ComparisonResult.orderedAscending {
                NSColor.lightGray.set()
                stringAttr[NSAttributedStringKey.foregroundColor] = NSColor.black
            } else if (NSDate().compare(eventStartTime as Date) == ComparisonResult.orderedDescending) && (NSDate().compare(eventEndTime as Date) == ComparisonResult.orderedAscending)  {
                NSColor.white.set()
                CKNCurrentEvent = event
            } else {
                NSColor.darkGray.set()
            }
               
                    
            
            
            NSBezierPath(roundedRect: dirtyRect, xRadius: 5.0, yRadius: 5.0).fill()
            let paragraphStyle:NSMutableParagraphStyle = NSMutableParagraphStyle()
            paragraphStyle.maximumLineHeight = 14.0
            
            let font: NSFont = NSFont(name: "LatoOT Regular", size: 13.0)!
            
            let descriptorDict : [NSFontDescriptor.AttributeName : Any] = [
                .featureSettings:[
                    [
                        NSFontDescriptor.FeatureKey.typeIdentifier: kNumberCaseType,
                        NSFontDescriptor.FeatureKey.selectorIdentifier: kLowerCaseNumbersSelector
                    ],
                    [
                        NSFontDescriptor.FeatureKey.typeIdentifier: kNumberSpacingType,
                        NSFontDescriptor.FeatureKey.selectorIdentifier: kProportionalNumbersSelector
                    ],
                    [
                        NSFontDescriptor.FeatureKey.typeIdentifier: kLigaturesType,
                        NSFontDescriptor.FeatureKey.selectorIdentifier: kCommonLigaturesOnSelector
                    ],
                    [
                        NSFontDescriptor.FeatureKey.typeIdentifier: kLigaturesType,
                        NSFontDescriptor.FeatureKey.selectorIdentifier: kRareLigaturesOnSelector
                    ]
                ]
            ]
            
            let fontDescriptor = font.fontDescriptor.addingAttributes(descriptorDict)
            
            stringAttr [NSAttributedStringKey.foregroundColor] = NSColor.black
            stringAttr [NSAttributedStringKey.font] = NSFont(descriptor: fontDescriptor, size: 13.0)!
            stringAttr [NSAttributedStringKey.paragraphStyle] = paragraphStyle
            
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "H:mm" //NSDateFormatterStyle.NoStyle
            //dateFormatter.timeStyle = NSDateFormatterStyle.ShortStyle
            
            let eventTimeStartString = dateFormatter.string(from: eventStartTime as Date)
            
            eventTimeStartString.draw(at: NSMakePoint(dirtyRect.origin.x+3, dirtyRect.origin.y+2), withAttributes: stringAttr)
            
            if let title = event.title  {
                title.draw(in: NSMakeRect(dirtyRect.origin.x+3, dirtyRect.origin.y+3,  dirtyRect.width-6, dirtyRect.height-6), withAttributes: stringAttr)
            }
        }
    }
}
