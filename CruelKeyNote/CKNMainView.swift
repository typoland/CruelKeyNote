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


    
    @IBOutlet weak var daysController:CKNDaysController? = nil
    //@IBOutlet weak  var  imageView: NSImageView?=nil
    
    var image:NSImage?=nil
    var timer:NSTimer?=nil
    var now:NSDate=NSDate()
    let imageView:NSImageView = NSImageView(frame: NSMakeRect(0,0,0,0))
    let progressBar:CKNEventProgressBar = CKNEventProgressBar(withEvent: nil)
    var dayViews:[Day:CKNDayView] = [Day:CKNDayView]()
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
        //imageView.setFrameSize(NSMakeSize( self.frame.size.width,  self.frame.size.height/2)
        //Swift.print("MainView Awake from nib")
        imageView.imageScaling = NSImageScaling.ScaleProportionallyUpOrDown
        organizeLayout()
        daysController!.addObserver(self, forKeyPath: "arrangedObjects", options: NSKeyValueObservingOptions([.Old, .New]), context: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "viewChanged:", name: NSViewFrameDidChangeNotification, object: nil)
        
    }
    func viewChanged (notification:NSNotification) {
        daysController?.rearangeDayViews(dayViews, inSuperview: self)
        progressBar.refreshSize()
        imageView.setFrameOrigin(NSMakePoint(0, 30))
        imageView.setFrameSize(NSMakeSize( self.frame.size.width,  self.frame.size.height-110))
    }
    
    override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
        Swift.print("observing")
        organizeLayout()
        self.needsDisplay = true
    }
    
    func availableWidth() -> CGFloat {
        if daysController != nil {
            return self.frame.size.width - (marginLeft + marginRight + (CGFloat(daysController!.arrangedObjects.count) - 1) * dayGap);
        } else {
            return 0
        }
    }
        
    func organizeLayout () {
        for subview in self.subviews {
            subview.removeFromSuperviewWithoutNeedingDisplay()
        }
        self.addSubview(imageView)
        self.addSubview(progressBar)
        
        dayViews = [Day:CKNDayView]()

        if daysController != nil {
            
            
            if let sortedDays:[Day] = daysController?.arraySortedByKey("startDate")  as? [Day] {
                for day:Day in sortedDays {
                    let dayView = CKNDayView(withDay: day)
                    
                    for event:Event in day.events?.array as! [Event] {
                        let eventView:CKNEventView = CKNEventView(withEvent: event)
                        dayView.addSubview(eventView)
                        dayView.eventsViews[event] = eventView
                    }
                    
                    self.addSubview(dayView)
                    dayViews[day] = dayView
                    
                    //Swift.print("Add Subview \(dayView.day)")
                    //dayView.needsDisplay = true
                }
                
            }
        }
        NSNotificationCenter.defaultCenter().postNotificationName(NSViewFrameDidChangeNotification, object: self)
    }
        
    override func drawRect(rect: NSRect) {
        
        NSColor.blackColor().set()
        NSRectFill(rect)
        
        
    }
    
        
    func changeTime() {
        CKNCurrentEvent = daysController?.currentEvent()
        
        if CKNCurrentEvent != nil {
            imageView.image = NSImage(data: CKNCurrentEvent!.media!)
            progressBar.event = CKNCurrentEvent
            //Swift.print(imageView.image)
            
        } else {
            imageView.image = nil
        }
        self.needsDisplay=true
       
    }

}
