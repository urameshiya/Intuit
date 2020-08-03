//
//  KeyCombination.swift
//  Intuit
//
//  Created by Chinh Vu on 8/3/20.
//  Copyright © 2020 urameshiyaa. All rights reserved.
//

import AppKit

enum Key: ExpressibleByStringLiteral {
	static let option = Key.modifierFlag(.option)
	static let cmd = Key.modifierFlag(.command)
	static let ctrl = Key.modifierFlag(.control)
	static let shift = Key.modifierFlag(.shift)
	static func f(_ num: Int) -> Key {
		return character(.init(Unicode.Scalar(NSF1FunctionKey + num - 1)!))
	}
	
	case modifierFlag(NSEvent.ModifierFlags)
	case character(Character)
	
	init(stringLiteral value: StringLiteralType) {
		self = .character(Character(value.lowercased()))
	}
}

struct KeyCombination: ExpressibleByArrayLiteral {
	let modifierFlags: NSEvent.ModifierFlags
	let characters: Set<Character>

	init(arrayLiteral keys: Key...) {
		var modifiers = NSEvent.ModifierFlags()
		var characters = Set<Character>()
		for key in keys {
			switch key {
			case .character(let character):
				characters.insert(character)
			case .modifierFlag(let flag):
				modifiers.insert(flag)
			}
		}
		modifierFlags = modifiers
		self.characters = characters
	}

	func matches(event: NSEvent) -> Bool {
		guard event.modifierFlags.contains(modifierFlags) else {
			return false
		}
		
		let eventCharacters = event.charactersIgnoringModifiers?.lowercased() ?? ""
		
		var matchCount = 0
		for char in eventCharacters {
			guard characters.contains(char) else {
				return false
			}
			matchCount += 1
		}
		return matchCount == characters.count
	}
}
