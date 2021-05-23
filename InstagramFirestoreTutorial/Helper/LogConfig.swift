//
//  CocoaLumberjack.swift
//  InstagramFirestoreTutorial
//
//  Created by bean Milky on 2021/05/23.
//

import Foundation
import CocoaLumberjack

public func InfoLog(_ message: String, file: StaticString = #file, function: StaticString = #function, line: UInt = #line) {
    let logMessage = DDLogMessage(message: message, level: .info, flag: .info, context: 0, file: String(describing: file), function: String(describing: function), line: line, tag: nil, options: [], timestamp: nil)
    DDLog.sharedInstance.log(asynchronous: false, message: logMessage)
}

public func ErrorLog(_ message: String, file: StaticString = #file, function: StaticString = #function, line: UInt = #line) {
    let logMessage = DDLogMessage(message: message, level: .error, flag: .error, context: 0, file: String(describing: file), function: String(describing: function), line: line, tag: nil, options: [], timestamp: nil)
    DDLog.sharedInstance.log(asynchronous: false, message: logMessage)
}
