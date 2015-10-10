//
//  StartStop.swift
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
        
        pingOnTimer(id: "org.rcnsc.quick_check", milliseconds: 1, repeats: false)
        pingOnTimer(id: "org.rcsnc.check_on_interval", milliseconds: 3000, repeats: true)
    }
    
    func stopChecking() {
        actionItem.title = "Check computer in clipboard....."
        computerNameItem.title = "No computer to check"
        
        Storage.timerKiller = true
        
        Storage.onlineNotificationCount = 0
        Storage.offlineNotification = true
        
        setIcon(name: "normal")
    }
    
    func pingOnTimer(id id: String, milliseconds: UInt, repeats: Bool) {
        let timerQueue = dispatch_queue_create(id, dispatch_queue_attr_make_with_qos_class(DISPATCH_QUEUE_SERIAL, QOS_CLASS_BACKGROUND, 0))
        _ = DispatchTimer.scheduledTimerWithTimeInterval(milliseconds: milliseconds, queue: timerQueue, repeats: repeats) { (timer:DispatchTimer) in
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
}
