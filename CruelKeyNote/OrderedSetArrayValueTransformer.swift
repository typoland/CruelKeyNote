//
//  OrderedSetValueTransformer.swift
//  CruelKeyNote
//
//  Created by Łukasz Dziedzic on 08/03/16.
//  Copyright © 2016 Łukasz Dziedzic. All rights reserved.
//

import Foundation


@objc(OrderedSetArrayValueTransformer) class OrderedSetArrayValueTransformer : NSValueTransformer {
    
    override class func transformedValueClass() -> AnyClass {
        return NSArray.self
    }
    
    func allowsReverseTransformation() -> Bool {
        return true;
        }
    
    override func transformedValue(value: AnyObject?) -> AnyObject? {
        print("OrderedSetArrayValueTransformer ➔ to Array")
        print ((value as! NSOrderedSet).array)
        return (value as! NSOrderedSet).array
    }

    override func reverseTransformedValue(value: AnyObject?) -> AnyObject? {
        print("OrderedSetArrayValueTransformer ⬅︎ reverse")
        //print (NSOrderedSet(array: value as! [AnyObject]))
        return NSOrderedSet(array: value as! [AnyObject])
    }

}


