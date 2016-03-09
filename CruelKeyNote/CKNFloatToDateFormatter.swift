//
//  CKNFloatToDateFormatter.swift
//  CruelKeyNote
//
//  Created by Łukasz Dziedzic on 22/03/15.
//  Copyright (c) 2015 Łukasz Dziedzic. All rights reserved.
//

import Foundation

class CKNFLoatToDateFormatter: NSFormatter {
    
    override func stringForObjectValue(obj: AnyObject) -> String? {
        
        if let number:NSNumber = obj as? NSNumber {
            let seconds:Double = (obj as NSNumber).doubleValue
            let hours:Double = seconds/360// as int64
            let minutes:Double = (seconds - hours*3600)/60 //as int64
            return (NSString(format: "%0.2li:%0.2li", hours, minutes) )
        } else {
            return nil
        }
    }
    
    override func getObjectValue(obj: AutoreleasingUnsafeMutablePointer<AnyObject?>, forString string: String, errorDescription error: AutoreleasingUnsafeMutablePointer<NSString?>) -> Bool {
        var returnValue = false
        var hours:String, minutes:String
        
        var chunks: NSArray = [string.componentsSeparatedByString(":")]
        var length:Int = chunks.count
        
        if (length == 1) {
            minutes = chunks[0] as String
            hours = "0"
            
        } else if (length == 2) {
            minutes = chunks[1] as String
            hours = chunks[0] as String
        }
        
        var minutesResult:Int? = minutes.toInt()
        var hoursResult:Int? = hours.toInt()

        
        if ((minutesResult != nil) & (hoursResult != nil)) {
            /*
            let v:Float = (minutesResult*60+hoursResult*3600);
            obj = &v
*/
            returnValue = true
        } else {
           // error = "Fuck It"
            returnValue =  false
        }
       return returnValue
    }
   
}