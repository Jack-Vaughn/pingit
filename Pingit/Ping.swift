//
//  Ping.swift
//  Pingit
//
//  Created by Vaughn, Jack on 10/9/15.
//  Copyright © 2015 Rutherford County Schools. All rights reserved.
//

import Cocoa

extension AppDelegate {
    
    func ping(host: String) -> String {
        let task = NSTask()
        task.launchPath = "/sbin/ping"
        task.arguments = ["-c", "2", host]
        
        let pipe = NSPipe()
        task.standardOutput = pipe
        
        let file = pipe.fileHandleForReading
        
        task.launch()
        
        let data = file.readDataToEndOfFile()
        
        let string = NSString(data: data, encoding: NSUTF8StringEncoding)!
        
        if string.rangeOfString("0 packets received").location != NSNotFound {
            return offline()
        } else  if string.length == 0 {
            return invalid()
        } else {
            return online()
        }
    }
    
    func online() -> String {
        if (!Storage.timerKiller) {
            setIcon(name: "online")
            if (Storage.onlineNotificationCount % 10 == 0) {
                Notifications().notify(title: "Computer Online", message: "The computer is currently online")
            }
            Storage.onlineNotificationCount++
            Storage.offlineNotification = false
            return "online"
        } else {
            return ""
        }
    }
    
    func offline() -> String {
        setIcon(name: "offline")
        if Storage.offlineNotification {
            Notifications().notify(title: "Computer Offline", message: "The computer is currently offline")
        }
        Storage.offlineNotification = false
        Storage.onlineNotificationCount = 0
        return "offline"
    }
    
    func invalid() -> String {
        setIcon(name: "x")
        Notifications().notify(title: "Computer Name Invalid", message: "Either the computer name is not valid or the computer has not been on the network this week.")
        return "invalid"
    }

}
