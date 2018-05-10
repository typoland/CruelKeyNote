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
    @IBOutlet weak var eventsController:CKNEventsController!
    //@IBOutlet weak  var  imageView: NSImageView?=nil
    
    var image:NSImage? = nil
    var timer:Timer? = nil
    var now:Date = Date()
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
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(CKNMainView.changeTime), userInfo: nil, repeats: true)
    }
    
    override func awakeFromNib() {
        //imageView.setFrameSize(NSMakeSize( self.frame.size.width,  self.frame.size.height/2)
        //Swift.print("MainView Awake from nib")
        imageView.imageScaling = NSImageScaling.scaleProportionallyUpOrDown
        
        daysController!.addObserver(self, forKeyPath: "arrangedObjects", options: NSKeyValueObservingOptions([.old, .new]), context: nil)
        daysController!.addObserver(self, forKeyPath: "arrangedObjects.events", options: NSKeyValueObservingOptions([.old, .new]), context: nil)
        daysController!.addObserver(self, forKeyPath: "arrangedObjects.duration", options: NSKeyValueObservingOptions([.old, .new]), context: nil)
        
        daysController!.addObserver(self, forKeyPath: "arrangedObjects.startDate", options: NSKeyValueObservingOptions([.old, .new]), context: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(CKNMainView.viewChanged(_:)), name: NSWindow.didResizeNotification, object: nil)
        //self.window?.addObserver(self, forKeyPath: "needsDisplay", options: NSKeyValueObservingOptions ([.New, .Old]), context: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(CKNMainView.eventClicked(_:)), name: CKNEventViewClickOn, object: nil)
        
        organizeLayout()
        rearangeDayViews()
        
    }
    
    @objc func eventClicked (_ notification:NSNotification) {
        //Swift.print(notification.object)
        let event:Event? = notification.object as? Event
        if event?.managedObjectContext == daysController?.managedObjectContext {
            
            clickedEvent = event
            let app:AppDelegate = NSApplication.shared.delegate as! AppDelegate
            let panelEventsController = app.panel.eventsController
            //
            let panelDaysController = app.panel.daysController
            if panelDaysController != nil {
                panelEventsController?.setSelectedObjects([event!])
                panelDaysController?.setSelectedObjects([event!.day!])
            }
        } else {
            clickedEvent = nil
            
        }
        changeTime()
    }
    
    @objc func viewChanged (_ notification:NSNotification) {
        //Swift.print (notification.object)
        rearangeDayViews()
        progressBar.refreshSize()
        imageView.setFrameOrigin(NSMakePoint(0, 30))
        imageView.setFrameSize(NSMakeSize( self.frame.size.width,  self.frame.size.height-110))
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        //Swift.print("observing", keyPath)
        organizeLayout()
        self.needsDisplay = true
    }
    
    func availableWidth() -> CGFloat {
        if let daysController = daysController {
            return self.frame.size.width - (marginLeft + marginRight + (CGFloat((daysController.arrangedObjects as! [AnyObject]).count) - 1) * dayGap);
        } else {
            return 0
        }
    }
    
    func organizeLayout () {
        //Swift.print("organize Layout")
        for subview in self.subviews {
            subview.removeFromSuperviewWithoutNeedingDisplay()
        }
        self.addSubview(imageView)
        self.addSubview(progressBar)
        
        dayViews = [Day:CKNDayView]()
        
        if daysController != nil {
            
            
            if let sortedDays:[Day] = daysController?.arraySortedByKey(key: "startDate")  as? [Day] {
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
        rearangeDayViews()
        //NSNotificationCenter.defaultCenter().postNotificationName(NSViewFrameDidChangeNotification, object: self)
    }
    
    override func draw(_ rect: NSRect) {
        
        NSColor.black.set()
        NSBezierPath(rect: rect).fill()
        //NSRectFill(rect)
        
    }
    
    
    func rearangeDayViews() {
        //Swift.print("rearranging")
        let dayGap:CGFloat = 3
        let eventGap:CGFloat = 1
        let margin:CGFloat = 0
        
        var xPos:CGFloat = margin
        
        if let daysController = daysController {
            let availableWidth = self.frame.width - dayGap*CGFloat((daysController.arrangedObjects as! [Any]).count-1)-2 * margin
            //Swift.print(daysController!.arraySortedByKey("startDate") )
            for day in daysController.arraySortedByKey(key: "startDate") as! [Day] {
                let width = availableWidth * CGFloat(day.duration) / CGFloat(daysController.totalDuration())
                if let view = dayViews[day] {
                    
                    let size = view.frame.size
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
            // }
            
        }
    }
    
    @objc func changeTime() {
        CKNCurrentEvent = daysController?.currentEvent()
        if clickedEvent != nil {
            imageView.image = clickedEvent!.image() //NSImage(data: clickedEvent!.media!)
            
            
        } else if CKNCurrentEvent != nil {
            imageView.image = CKNCurrentEvent!.image()
            progressBar.event = CKNCurrentEvent
            //Swift.print(imageView.image)
            
        } else {
            imageView.image = nil
            progressBar.event = nil
        }
        self.needsDisplay=true
    }
}



