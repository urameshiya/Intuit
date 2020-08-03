//
//  AppDelegate.swift
//  Intuit
//
//  Created by Chinh Vu on 8/2/20.
//  Copyright © 2020 urameshiyaa. All rights reserved.
//

import Cocoa
import SwiftUI

class AppDelegate: NSObject, NSApplicationDelegate, DragDropHandler, KeybindEventHandler {

	var window: NSWindow!
	var dragDrop: GlobalDragDropStateManager!
	var keyMonitor: KeybindMonitor!
	var savedWindow: AccessibilityWindow?

	func applicationDidFinishLaunching(_ aNotification: Notification) {
		askForAccessibilityPermission()
		
		keyMonitor = .init(handler: self)
		
		dragDrop = .init()
		dragDrop.handler = self
		
		keyMonitor.beginMonitoring()
	}

	func applicationWillTerminate(_ aNotification: Notification) {
		// Insert code here to tear down your application
	}
	
	func askForAccessibilityPermission() {
		let options: CFDictionary = [kAXTrustedCheckOptionPrompt.takeRetainedValue() as String: true] as CFDictionary
		let isTrusted = AXIsProcessTrustedWithOptions(options)
		print("Accessibility is \(isTrusted ? "enabled" : "disabled")")
	}
	
	func dragBegan() {
		print("Dragging")
	}

	func dragEnded() {
		print("Drag ended")
		savedWindow = nil
	}
	
	func keybindTriggered() {
		if dragDrop.isDragging {
			print("Showing window")
			savedWindow?.makeFrontmost()
		} else {
			print("Window saved")
			savedWindow = AccessibilityWindow.getFrontmost()
		}
	}
}

