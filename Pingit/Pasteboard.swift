//
//  Pasteboard.swift
//  Pingit
//
//  Created by Vaughn, Jack on 10/9/15.
//  Copyright © 2015 Rutherford County Schools. All rights reserved.
//

import Cocoa

class Pasteboard: NSObject {

    func getContent() -> String { //returns empty string if content is nil
        let pasteboardContent:String? = NSPasteboard.generalPasteboard().stringForType("public.utf8-plain-text")
        if let _ = pasteboardContent {
            return pasteboardContent!
        } else {
            return ""
        }
    }
    
}
