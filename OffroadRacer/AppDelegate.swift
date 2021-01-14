//
//  AppDelegate.swift
//  OffroadRacer
//
//  Created by Tom on 1/11/21.
//


import Cocoa

@main
class AppDelegate: NSObject, NSApplicationDelegate {
    
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
    }
    
    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }
    
    // Make the application close completely when closing the window
    func applicationShouldTerminateAfterLastWindowClosed (_ theApplication: NSApplication) -> Bool { return true }
    
}
