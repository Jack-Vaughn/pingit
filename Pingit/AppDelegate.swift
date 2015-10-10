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
    
    func applicationDidFinishLaunching(aNotification: NSNotification) {
        setIcon(name: "online")
    }
    
    @IBAction func actionClicked(sender: AnyObject) {
        if (actionItem.title == "Check computer in clipboard.....") {
            startChecking()
        } else {
            stopChecking()
        }
    }
    
    @IBAction func quitClicked(sender: NSMenuItem) {
        NSApplication.sharedApplication().terminate(self)
    }
    
    func applicationWillTerminate(aNotification: NSNotification) {
    }
}