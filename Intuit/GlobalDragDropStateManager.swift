//
//  DragDropStateManager.swift
//  Intuit
//
//  Created by Chinh Vu on 8/2/20.
//  Copyright © 2020 urameshiyaa. All rights reserved.
//

import AppKit

protocol DragDropHandler: AnyObject {
	func dragBegan()
	func dragEnded()
}

class GlobalDragDropStateManager {
	private let pasteboard = NSPasteboard(name: .drag)
	private var lastChangeCount = -1
	private var evtMonitor: Any!
	private(set) var isDragging = false
	weak var handler: DragDropHandler?
	
	init() {
		lastChangeCount = pasteboard.changeCount
		
		evtMonitor = NSEvent.addGlobalMonitorForEvents(matching: [.leftMouseDragged,
																  .leftMouseUp]) { [unowned self] (event) in
			switch event.type {
			case .leftMouseDragged:
				guard self.lastChangeCount != self.pasteboard.changeCount else {
					return
				}
				self.lastChangeCount = self.pasteboard.changeCount
				self.startDrag()
			case .leftMouseUp:
				self.endDragIfNeeded()
			default:
				assertionFailure()
				return
			}
		}
		
		guard evtMonitor != nil else {
			preconditionFailure("Could not hook mouse event. I'm pretty much useless")
		}
	}
	
	func startDrag() {
		guard !isDragging else {
			return
		}
		isDragging = true
		handler?.dragBegan()
	}
	
	func endDragIfNeeded() {
		guard isDragging else {
			return
		}
		isDragging = false
		handler?.dragEnded()
	}
}
