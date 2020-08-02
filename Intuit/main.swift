//
//  main.swift
//  Intuit
//
//  Created by Chinh Vu on 8/2/20.
//  Copyright © 2020 urameshiyaa. All rights reserved.
//

import AppKit

let app: NSApplication = NSApplication.shared
let appDelegate = AppDelegate()  // Instantiates the class the @NSApplicationMain was attached to
app.delegate = appDelegate
_ = NSApplicationMain(CommandLine.argc, CommandLine.unsafeArgv)

