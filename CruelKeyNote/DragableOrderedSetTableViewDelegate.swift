//
//  DragableOrderedSetTableViewDelegate.swift
//  OrderedSetTestSwift
//
//  Created by Łukasz Dziedzic on 10/03/16.
//  Copyright © 2016 Łukasz Dziedzic. All rights reserved.
//

import Foundation
import AppKit

class DragableOrderedSetTableViewDelegate: NSObject {
    @IBOutlet weak var tableView:NSTableView!
    @IBOutlet weak var arrayController:NSArrayController!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        tableView.registerForDraggedTypes([arrayController.entityName!])
        tableView.setDraggingSourceOperationMask(NSDragOperation.Move, forLocal: true)
    }
    
    func tableView( tableView: NSTableView,
        writeRowsWithIndexes rowIndexes: NSIndexSet,
        toPasteboard pasteboard: NSPasteboard) -> Bool {
            
            let data:NSData = NSKeyedArchiver.archivedDataWithRootObject(rowIndexes)
            pasteboard.declareTypes([arrayController.entityName!], owner: self)
            pasteboard.setData(data, forType: arrayController.entityName!)
            return true
    }
    
    func tableView(tableView: NSTableView,
        validateDrop info: NSDraggingInfo,
        proposedRow row: Int,
        proposedDropOperation dropOperation: NSTableViewDropOperation) -> NSDragOperation {
            if info.draggingSource() as! NSTableView == tableView {
                if dropOperation == NSTableViewDropOperation.On {
                    tableView.setDropRow(row, dropOperation: NSTableViewDropOperation.Above)}
                if ((NSApplication.sharedApplication().currentEvent?.modifierFlags.contains(NSEventModifierFlags.AlternateKeyMask)) != nil)  {
                    return NSDragOperation.Copy
                } else {
                    return NSDragOperation.Move
                }
                
            } else {
                return NSDragOperation.None
            }
    }
   
    func tableView(tableView: NSTableView,
        acceptDrop info: NSDraggingInfo,
        row: Int,
         dropOperation: NSTableViewDropOperation) -> Bool {
            let bindinginfo:NSDictionary = arrayController.infoForBinding("contentArray")!
            
            let set:NSMutableOrderedSet = bindinginfo.objectForKey(NSObservedObjectKey)!.mutableOrderedSetValueForKeyPath(bindinginfo.objectForKey(NSObservedKeyPathKey) as! String)
            // let set:NSMutableOrderedSet
            let pasteboard:NSPasteboard = info.draggingPasteboard()
            let rowData:NSData = pasteboard.dataForType(arrayController.entityName!)!
            let rowIndexes:NSIndexSet = NSKeyedUnarchiver.unarchiveObjectWithData(rowData) as! NSIndexSet
            if rowIndexes.firstIndex > row {
                set.moveObjectsAtIndexes(rowIndexes, toIndex: row)
            } else {
                set.moveObjectsAtIndexes(rowIndexes, toIndex: row-rowIndexes.count)
            }
            
    return true
    }

}
/*
- (BOOL)tableView:(NSTableView *)aTableView acceptDrop:(id <NSDraggingInfo>)info row:(int)row dropOperation:(NSTableViewDropOperation)operation {
    
    NSDictionary *bindingInfo = [self.arrayController infoForBinding:@"contentArray"];
    NSMutableOrderedSet *s = [[bindingInfo objectForKey:NSObservedObjectKey] mutableOrderedSetValueForKeyPath:[bindingInfo objectForKey:NSObservedKeyPathKey]];
    
    NSPasteboard *pasteboard = [info draggingPasteboard];
    NSData *rowData = [pasteboard dataForType:[self.arrayController entityName]];
    NSIndexSet *rowIndexes = [NSKeyedUnarchiver unarchiveObjectWithData:rowData];
    if ([rowIndexes firstIndex] > row) {
        // we're moving up
        [s moveObjectsAtIndexes:rowIndexes toIndex:row];
    } else {
        // we're moving down
        [s moveObjectsAtIndexes:rowIndexes toIndex:row-[rowIndexes count]];
    }
    
    return YES;
}
*/




