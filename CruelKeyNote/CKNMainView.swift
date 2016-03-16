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


    
    @IBOutlet weak var daysController:CKNDaysController!
    //@IBOutlet weak  var  imageView: NSImageView?=nil
    
    var image:NSImage?=nil
    var timer:NSTimer?=nil
    var now:NSDate=NSDate()
    var clickOnEvent = false
    var clickedEvent:Event? = nil
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
        daysController!.addObserver(self, forKeyPath: "arrangedObjects.events", options: NSKeyValueObservingOptions([.Old, .New]), context: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "viewChanged:", name: NSViewFrameDidChangeNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "eventClicked:", name: CKNEventViewClickOn, object: nil)
        
    }
    func eventClicked (notification:NSNotification) {
        Swift.print(notification.object)
        let event:Event? = notification.object as? Event
        if event?.managedObjectContext == daysController?.managedObjectContext {
            
            clickedEvent = event
            let app:AppDelegate = NSApplication.sharedApplication().delegate as! AppDelegate
            let panelEventsController = app.hudPanelController.eventsController
             let panelDaysController = app.hudPanelController.daysController
            if panelDaysController != nil {
            panelEventsController.setSelectedObjects([event!])
            panelDaysController.setSelectedObjects([event!.day!])
            }
        } else {
            clickedEvent = nil
            
        }
        changeTime()
    }
    
    func viewChanged (notification:NSNotification) {
        rearangeDayViews()
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
    func rearangeDayViews() {
        let dayGap:CGFloat = 3
        let eventGap:CGFloat = 1
        let margin:CGFloat = 0
        
        var xPos:CGFloat = margin
        
        let availableWidth = self.frame.width - dayGap*CGFloat(daysController.arrangedObjects.count-1)-2 * margin
        for day in daysController!.arraySortedByKey("startDate") as! [Day] {
            
            let width = availableWidth * CGFloat(day.duration) / CGFloat(daysController.totalDuration())
            if let view = dayViews[day] {
                
                let size = view.frame.size
                //let origin = view.frame.origin
                view.setFrameSize(NSMakeSize(width, size.height))
                view.setFrameOrigin(NSMakePoint(xPos, self.frame.size.height - view.frame.size.height))
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
        
    func changeTime() {
        CKNCurrentEvent = daysController?.currentEvent()
        if clickedEvent != nil {
            imageView.image = NSImage(data: clickedEvent!.media!)
        } else if CKNCurrentEvent != nil {
            imageView.image = NSImage(data: CKNCurrentEvent!.media!)
            progressBar.event = CKNCurrentEvent
            //Swift.print(imageView.image)
            
        } else {
            imageView.image = nil
        }
        self.needsDisplay=true
       
    }
    /*
    stringAttr[NSFontAttributeName] = NSFont(name: "LatoOT Light", size: 24)
    stringAttr[NSForegroundColorAttributeName] = NSColor.whiteColor()
    //Swift.print("event", event)
    if let title:NSString = event!.title  {
    //Swift.print("Let's try", title.className)
    title.drawAtPoint( NSMakePoint(0, 10), withAttributes: stringAttr)
    */

}
