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
    @IBOutlet weak var versionItem: NSMenuItem!
    @IBOutlet weak var computerNameItem: NSMenuItem!
    @IBOutlet weak var statusItem: NSMenuItem!
    @IBOutlet weak var screenshareItem: NSMenuItem!
    
    func applicationDidFinishLaunching(aNotification: NSNotification) {
        setIcon(name: "normal")
        let version = NSBundle.mainBundle().objectForInfoDictionaryKey("CFBundleShortVersionString")!
        versionItem.title = "Pingit v\(version)"
    }
    
    @IBAction func statusClicked(sender: AnyObject) {
        storeClipboardContent()
        if (statusItem.title == "Check status of computer in clipboard.....") {
            startChecking()
        } else {
            stopChecking()
        }
    }
    
    @IBAction func screenshareClicked(sender: AnyObject) {
        if (screenshareItem.title == "Screenshare computer in clipboard....") {
            storeClipboardContent()
            NSWorkspace.sharedWorkspace().openURL(NSURL(string: "vnc://\(Storage.clipboardContent)")!)
        } else {
            NSWorkspace.sharedWorkspace().openURL(NSURL(string: "vnc://\(Storage.currentComputer)")!)
        }
    }
    
    func storeClipboardContent() {
        Storage.clipboardContent = Pasteboard().getContent()
    }
    
    @IBAction func quitClicked(sender: NSMenuItem) {
        NSApplication.sharedApplication().terminate(self)
    }
    
    func applicationWillTerminate(aNotification: NSNotification) {
    }
}