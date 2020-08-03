//
//  Extension.swift
//  Intuit
//
//  Created by Chinh Vu on 8/3/20.
//  Copyright © 2020 urameshiyaa. All rights reserved.
//

import Foundation

extension AXUIElement {
	func getAttribute<T>(_ attribute: String) -> T? {
		var value: CFTypeRef?
		let error = AXUIElementCopyAttributeValue(self, attribute as CFString, &value)
		switch error {
		case .success:
			assert(value != nil)
			return value as? T
		case .noValue:
			return nil
		default:
			assertionFailure("Unable to get attribute \(attribute), error \(error.rawValue)")
			return nil
		}
	}
	
	func setAttribute<T>(_ attribute: String, to value: T) -> Bool {
		let error = AXUIElementSetAttributeValue(self, attribute as CFString, value as CFTypeRef)
		assert(error == .success)
		return error == .success
	}
}
