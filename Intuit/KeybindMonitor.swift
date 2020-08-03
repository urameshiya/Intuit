//
//  KeybindMonitor.swift
//  Intuit
//
//  Created by Chinh Vu on 8/2/20.
//  Copyright © 2020 urameshiyaa. All rights reserved.
//

import AppKit

protocol KeybindEventHandler: AnyObject {
	func keybindTriggered()
}

class KeybindMonitor {
	private var evtMonitor: Any?
	let keyPattern: KeyCombination = [.f(1)]
	unowned let handler: KeybindEventHandler
	
	init(handler: KeybindEventHandler) {
		self.handler = handler
	}
	
	func beginMonitoring() {
		if evtMonitor != nil {
			return
		}
		
		evtMonitor = NSEvent.addGlobalMonitorForEvents(matching: .keyDown, handler: { [unowned self] (event) in
			guard self.keyPattern.matches(event: event) else {
				return
			}
			self.handler.keybindTriggered()
		})
		
		guard evtMonitor != nil else {
			print("Unable to hook key events")
			return
		}
	}
	
	func endMonitoring() {
		if let evtMonitor = evtMonitor {
			NSEvent.removeMonitor(evtMonitor)
			self.evtMonitor = nil
		}
	}
}
