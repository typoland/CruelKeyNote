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
    @IBOutlet weak  var  imageView: NSImageView?=nil
    
    var image:NSImage?=nil
    var timer:NSTimer?=nil
    var now:NSDate=NSDate()

    required init?(coder: NSCoder) {
        Swift.print("Init? coder MainView \(coder)")
        super.init(coder: coder)
        timer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: Selector("changeTime"), userInfo: nil, repeats: true)
     }

    override func drawRect(dirtyRect: NSRect) {
        //println("View Updated")
        //Swift.print("Time passing...")
        NSColor.blackColor().set()
        NSRectFill(dirtyRect)
        now = NSDate()
        var dateFormatter:NSDateFormatter = NSDateFormatter()
        var stringAttributes = []
        
        var totalTime:NSDate = NSDate(timeIntervalSince1970: 0)
        var duration:NSTimeInterval
        
        if let days:[NSManagedObject] = daysController?.arrangedObjects as? [NSManagedObject] {
            for day in days {
                Swift.print("day \(day)")
                duration = day.valueForKey("duration") as! NSTimeInterval
                totalTime = totalTime.dateByAddingTimeInterval(duration)
                
                
            }
        }
        
    }
    
    func changeTime() {
        self.needsDisplay=true
       
    }

}
