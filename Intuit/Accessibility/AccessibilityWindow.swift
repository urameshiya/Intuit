//
//  AccessibilityWindow.swift
//  Intuit
//
//  Created by Chinh Vu on 8/2/20.
//  Copyright © 2020 urameshiyaa. All rights reserved.
//

import AppKit

class AccessibilityWindow {
	let applicationElement: AXUIElement
	let windowElement: AXUIElement
	
	private init(application: AXUIElement,
		 window: AXUIElement) {
		applicationElement = application
		windowElement = window
	}
	
	func makeFrontmost() {
		guard applicationElement.setAttribute(kAXFrontmostAttribute, to: true) else {
			print("Unable to activate application")
			return
		}
		guard applicationElement.setAttribute(kAXFocusedWindowAttribute, to: windowElement) else {
			return
		}
	}
}

extension AccessibilityWindow {
	static func getFrontmost() -> AccessibilityWindow? {
		guard let frontmost = NSWorkspace.shared.frontmostApplication else {
			return nil
		}
		let application = AXUIElementCreateApplication(frontmost.processIdentifier)
		
		let window: AXUIElement? = application.getAttribute(kAXFocusedWindowAttribute)
		
		return window == nil ? nil : AccessibilityWindow(application: application, window: window!)
	}
}
