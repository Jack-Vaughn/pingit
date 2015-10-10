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
        setIcon(name: "online")
        if (Storage.notifiedCount % 10 == 0) {
            Notifications().notify(title: "Computer Online", message: "The computer is online")
        }
        Storage.notifiedCount++
        return "online"
    }
    
    func offline() -> String {
        setIcon(name: "offline")
        Storage.notifiedCount = 0
        return "offline"
    }
    
    func invalid() -> String {
        setIcon(name: "x")
        Notifications().notify(title: "Computer Name Invalid", message: "Either the computer name is not valid or the computer has not been on the network this week.")
        return "invalid"
    }

}
