//
//  AppDelegate.swift
//  Pingit
//
//  Created by Vaughn, Jack on 10/9/15.
//  Copyright © 2015 Rutherford County Schools. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    
    //IBOutlets
    @IBOutlet weak var menu: NSMenu!
    @IBOutlet weak var computerNameItem: NSMenuItem!
    @IBOutlet weak var actionItem: NSMenuItem!
    
    func applicationDidFinishLaunching(aNotification: NSNotification) {
        setIcon(name: "normal")
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