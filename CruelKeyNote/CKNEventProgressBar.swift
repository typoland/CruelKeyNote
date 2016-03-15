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
    override func drawRect(dirtyRect: NSRect) {
        if event != nil {
            //Swift.print("drawing bar")
            let (start, _) = (event!.day?.eventTimes(event!))!
            
            let currentDuration = NSDate().timeIntervalSinceDate(start as NSDate)
            let width = superview!.frame.width * CGFloat(currentDuration) / CGFloat(event!.duration)
            //Swift.print (currentDuration, width)

            NSColor.redColor().set()
            let rect = NSMakeRect(0, 0, width, dirtyRect.height)
            NSBezierPath(roundedRect: rect, xRadius: 5, yRadius: 5).fill()
        }
    }
}