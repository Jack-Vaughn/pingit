//
//  Checking.swift
//  Pingit
//
//  Created by Vaughn, Jack on 10/9/15.
//  Copyright © 2015 Rutherford County Schools. All rights reserved.
//

import Foundation
import Cocoa

extension AppDelegate {
    
    func startChecking() {
        actionItem.title = "Stop checking....."
        
        Storage.timerKiller = false
        
        Storage.clipboardContent = Pasteboard().getContent()
        computerNameItem.title = "Checking \(Storage.clipboardContent)....."
        
        let timerQueue = dispatch_queue_create("org.rcsnc.startChecking", dispatch_queue_attr_make_with_qos_class(DISPATCH_QUEUE_SERIAL, QOS_CLASS_BACKGROUND, 0))
        _ = DispatchTimer.scheduledTimerWithTimeInterval(milliseconds: 3000, queue: timerQueue, repeats: true) { (timer:DispatchTimer) in
            if (Storage.timerKiller) {
                timer.invalidate()
                self.setIcon(name: "normal")
            } else {
                if (self.ping(Storage.clipboardContent) == "invalid") {
                    timer.invalidate()
                }
            }
        }
    }
    
    func stopChecking() {
        actionItem.title = "Check computer in clipboard....."
        computerNameItem.title = "No computer to check"
        Storage.timerKiller = true
        Storage.notifiedCount = 0
        setIcon(name: "online")
    }
}
