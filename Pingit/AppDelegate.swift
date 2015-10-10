//
//  AppDelegate.swift
//  Test
//
//  Created by Jack Vaughn on 9/27/15.
//  Copyright © 2015 Jack Vaughn. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    
    //IBOutlets
    @IBOutlet weak var menu: NSMenu!
    @IBOutlet weak var computerNameItem: NSMenuItem!
    @IBOutlet weak var actionItem: NSMenuItem!
    
    //Global Variables
    let menuSpace = NSStatusBar.systemStatusBar().statusItemWithLength(-1)
    var timerKiller = false
    var notifiedCount = 0
    
    func applicationDidFinishLaunching(aNotification: NSNotification) {
        setIcon(name: "online")
    }
    
    func applicationWillTerminate(aNotification: NSNotification) {
    }
    
    @IBAction func actionClicked(sender: AnyObject) {
        if (actionItem.title == "Check computer in clipboard.....") {
            startChecking()
            actionItem.title = "Stop checking....."
        } else {
            stopChecking()
            actionItem.title = "Check computer in clipboard....."
            computerNameItem.title = "No computer to check"
        }
    }
    
    @IBAction func quitClicked(sender: NSMenuItem) {
        NSApplication.sharedApplication().terminate(self)
    }
    
    func startChecking() {
        timerKiller = false
        let pasteboardContent:String? = NSPasteboard.generalPasteboard().stringForType("public.utf8-plain-text")
        if let _ = pasteboardContent {
            computerNameItem.title = "Checking \(pasteboardContent!)....."
        }
        let timerQueue = dispatch_queue_create("org.rcsnc.startChecking", dispatch_queue_attr_make_with_qos_class(DISPATCH_QUEUE_SERIAL, QOS_CLASS_BACKGROUND, 0))
        _ = DispatchTimer.scheduledTimerWithTimeInterval(milliseconds: 3000, queue: timerQueue, repeats: true) { (timer:DispatchTimer) in
            if (self.timerKiller) {
                timer.invalidate()
                let icon = NSImage(named: "normal")
                icon!.template = true
                self.menuSpace.image = icon
                self.menuSpace.menu = self.menu
            } else {
                if (self.ping(pasteboardContent) == "invalid") {
                    timer.invalidate()
                }
            }
        }
    }
    
    func stopChecking() {
        timerKiller = true
        notifiedCount = 0
        setIcon(name: "online")
    }
    
    func ping(pasteboardContent: String?) -> String {
        if let pasteboardString = pasteboardContent {
            
            let task = NSTask()
            task.launchPath = "/sbin/ping"
            task.arguments = ["-c", "2", pasteboardString]
            
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
        return ""
    }
    
    func online() -> String {
        setIcon(name: "online")
        if (notifiedCount % 10 == 0) {
            notify(title: "Computer Online", message: "The computer is online")
        }
        notifiedCount++
        return "online"
    }
    
    func offline() -> String {
        setIcon(name: "offline")
        notifiedCount = 0
        return "offline"
    }
    
    func invalid() -> String {
        setIcon(name: "x")
        notify(title: "Computer Name Invalid", message: "Either the computer name is not valid or the computer has not been on the network this week.")
        return "invalid"
    }
    
    func notify(title title: String, message: String) {
        let notification:NSUserNotification = NSUserNotification()
        notification.title = title
        notification.informativeText = message
        notification.soundName = NSUserNotificationDefaultSoundName
        
        let center:NSUserNotificationCenter = NSUserNotificationCenter.defaultUserNotificationCenter()
        center.scheduleNotification(notification)
    }
}