//
//  TimeIntervalTransformer.swift
//  CruelKeyNote
//
//  Created by Łukasz Dziedzic on 12/03/16.
//  Copyright © 2016 Łukasz Dziedzic. All rights reserved.
//

import Foundation
import AppKit

infix operator ^^ { }
func ^^ (radix: Int, power: Int) -> Int {
    return Int(pow(Double(radix), Double(power)))
}

@objc(TimeIntervalTransformer) class TimeIntervalTransformer : NSValueTransformer {
    
    override class func transformedValueClass() -> AnyClass {
        return NSString.self
    }
    
    override class func allowsReverseTransformation() -> Bool {
        return true;
    }
    
    override func transformedValue(value: AnyObject?) -> AnyObject? {
        if value != nil {
            let seconds = (value as! Float)
            
            let HH =  trunc(seconds / 3600)
            let MM = trunc((seconds - HH*3600)  / 60)
            return String(format: "%.0f:%02.0f", HH, MM)
            
        } else {
            return ""
        }
    }
    
    override func reverseTransformedValue(value: AnyObject?)  -> AnyObject? {
        let timeString:String = ( value as! String )
        let HHMMSS = timeString.componentsSeparatedByString(":")
        var seconds = 0
        
        for i in Range(0..<HHMMSS.count) {
            let value:Int? = Int(HHMMSS [i] as String)
            if value != nil {
                seconds = seconds + Int(HHMMSS [i] as String)! * (60 ^^ (HHMMSS.count-i))
            } else {
                
                let alert:NSAlert = NSAlert()
                alert.messageText = "Wrong value!"
                alert.informativeText = "Proper value is:\n\tHH:MM for hours\n\tMM for minutes"
                alert.runModal()
                
            }
        }
        
        
        return seconds
    }
    
}