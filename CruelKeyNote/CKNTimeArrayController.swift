//
//  CKNTimeArrayController.swift
//  CruelKeyNote
//
//  Created by Łukasz Dziedzic on 21/03/15.
//  Copyright (c) 2015 Łukasz Dziedzic. All rights reserved.
//

import Foundation
import AppKit

 class CKNTimeArrayController:NSArrayController {
    
    func arraySortedByKey(key:NSString) -> NSArray {
        let daysSortDescriptor:NSSortDescriptor = NSSortDescriptor(key: key as String, ascending: true)
        return (self.arrangedObjects as! NSArray).sortedArrayUsingDescriptors([daysSortDescriptor])
    }

}