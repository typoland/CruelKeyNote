//
//  CKNPanel.swift
//  BeBrief
//
//  Created by Łukasz Dziedzic on 21/03/16.
//  Copyright © 2016 tyPoland. All rights reserved.
//

import Foundation
import AppKit

class CKNPanel: NSPanel {
    @IBOutlet weak var daysController:CKNDaysController!
    @IBOutlet weak var eventsController:CKNEventsController!
}