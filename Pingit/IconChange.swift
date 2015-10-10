//
//  IconChange.swift
//  Pingit
//
//  Created by Vaughn, Jack on 10/9/15.
//  Copyright © 2015 Rutherford County Schools. All rights reserved.
//

import Cocoa

extension AppDelegate {
    func setIcon(name name: String) {
        let icon = NSImage(named: name)
        icon!.template = true
        Storage.menuSpace.image = icon
        Storage.menuSpace.menu = menu
    }
}
