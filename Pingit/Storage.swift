//
//  Storage.swift
//  Pingit
//
//  Created by Vaughn, Jack on 10/9/15.
//  Copyright © 2015 Rutherford County Schools. All rights reserved.
//

import Cocoa

struct Storage {
    static let menuSpace = NSStatusBar.systemStatusBar().statusItemWithLength(-1)
    
    static var timerKiller = false
    
    static var clipboardContent = String()
    
    static var onlineNotificationCount = 0
    
    static var offlineNotification = true
}