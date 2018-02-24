//
//  SwiftyBeaver.swift
//  ESBasic
//
//  Created by jiang on 2018/1/30.
//  Copyright © 2018年 EasyHome. All rights reserved.
//

import Foundation

public let log = SwiftyBeaver.self

public class SwiftyBeaver {
    
    /// version string of framework
    public static let version = "1.1.1"  // UPDATE ON RELEASE!
    /// build number of framework
    public static let build = 1110 // version 0.7.1 -> 710, UPDATE ON RELEASE!
    
    
    public static let formatter = DateFormatter()
    public static var format = "$C$L$c $DHH:mm:ss.SSS $N.$F:$l\n$M"
    
    public enum Level: Int {
        case verbose = 0
        case debug = 1
        case info = 2
        case warning = 3
        case error = 4
    }
    
    /// returns the current thread name
    class func threadName() -> String {
        
        #if os(Linux)
            // on 9/30/2016 not yet implemented in server-side Swift:
            // > import Foundation
            // > Thread.isMainThread
            return ""
        #else
            if Thread.isMainThread {
                return ""
            } else {
                let threadName = Thread.current.name
                if let threadName = threadName, !threadName.isEmpty {
                    return threadName
                } else {
                    return String(format: "%p", Thread.current)
                }
            }
        #endif
    }
    
    // MARK: Levels
    
    /// log something generally unimportant (lowest priority)
    public class func verbose(_ message: @autoclosure () -> Any, _
        file: String = #file, _ function: String = #function, line: Int = #line) {
        custom(level: .verbose, message: message, file: file, function: function, line: line)
    }
    
    /// log something which help during debugging (low priority)
    public class func debug(_ message: @autoclosure () -> Any, _
        file: String = #file, _ function: String = #function, line: Int = #line) {
        custom(level: .debug, message: message, file: file, function: function, line: line)
    }
    
    /// log something which you are really interested but which is not an issue or error (normal priority)
    public class func info(_ message: @autoclosure () -> Any, _
        file: String = #file, _ function: String = #function, line: Int = #line) {
        custom(level: .info, message: message, file: file, function: function, line: line)
    }
    
    /// log something which may cause big trouble soon (high priority)
    public class func warning(_ message: @autoclosure () -> Any, _
        file: String = #file, _ function: String = #function, line: Int = #line) {
        custom(level: .warning, message: message, file: file, function: function, line: line)
    }
    
    /// log something which will keep you awake at night (highest priority)
    public class func error(_ message: @autoclosure () -> Any, _
        file: String = #file, _ function: String = #function, line: Int = #line) {
        custom(level: .error, message: message, file: file, function: function, line: line)
    }
    
    /// custom logging to manually adjust values, should just be used by other frameworks
    public class func custom(level: SwiftyBeaver.Level, message: @autoclosure () -> Any,
                             file: String = #file, function: String = #function, line: Int = #line) {
        dispatch_send(level: level, message: message, thread: threadName(),
                      file: file, function: function, line: line)
    }
    
    /// internal helper which dispatches send to dedicated queue if minLevel is ok
    class func dispatch_send(level: SwiftyBeaver.Level, message: @autoclosure () -> Any,
                             thread: String, file: String, function: String, line: Int) {
        let str = formatMessage(format, level: level, msg: "\(message())", thread: thread,
                                file: file, function: function, line: line)
        print(str)
    }

    public static var levelString = LevelString()
    
    /// set custom log level colors for each level
    public static var levelColor = LevelColor()
    
    public struct LevelString {
        public var verbose = "VERBOSE"
        public var debug = "DEBUG"
        public var info = "INFO"
        public var warning = "WARNING"
        public var error = "ERROR"
    }
    
    // For a colored log level word in a logged line
    // empty on default
    public struct LevelColor {
        public var verbose = "💜"     // silver
        public var debug = "💙"       // green
        public var info = "💚"        // blue
        public var warning = "💛"     // yellow
        public var error = "❤️"        // red
    }
    
    public static func levelWord(_ level: SwiftyBeaver.Level) -> String {
        
        var str = ""
        
        switch level {
        case SwiftyBeaver.Level.debug:
            str = levelString.debug
            
        case SwiftyBeaver.Level.info:
            str = levelString.info
            
        case SwiftyBeaver.Level.warning:
            str = levelString.warning
            
        case SwiftyBeaver.Level.error:
            str = levelString.error
            
        default:
            // Verbose is default
            str = levelString.verbose
        }
        return str
    }
    public static func colorForLevel(_ level: SwiftyBeaver.Level) -> String {
        var color = ""
        
        switch level {
        case SwiftyBeaver.Level.debug:
            color = levelColor.debug
            
        case SwiftyBeaver.Level.info:
            color = levelColor.info
            
        case SwiftyBeaver.Level.warning:
            color = levelColor.warning
            
        case SwiftyBeaver.Level.error:
            color = levelColor.error
            
        default:
            color = levelColor.verbose
        }
        return color
    }
    
    public static func formatMessage(_ format: String, level: SwiftyBeaver.Level, msg: String, thread: String,
                       file: String, function: String, line: Int) -> String {
        let phrases: [String] = format.components(separatedBy: "$")
        var text = ""
        for phrase in phrases {
            if !phrase.isEmpty {
                let firstChar = phrase[phrase.startIndex]
                let rangeAfterFirstChar = phrase.index(phrase.startIndex, offsetBy: 1)..<phrase.endIndex
                let remainingPhrase = phrase[rangeAfterFirstChar]
                
                switch firstChar {
                case "L":
                    text += levelWord(level) + remainingPhrase
                case "M":
                    text += msg + remainingPhrase
                case "m":
                    // json-encoded message
                    let dict = ["message": msg]
                    let jsonString = jsonStringFromDict(dict)
                    text += jsonStringValue(jsonString, key: "message") + remainingPhrase
                case "T":
                    text += thread + remainingPhrase
                case "N":
                    // name of file without suffix
                    text += fileNameWithoutSuffix(file) + remainingPhrase
                case "n":
                    // name of file with suffix
                    text += fileNameOfFile(file) + remainingPhrase
                case "F":
                    text += function + remainingPhrase
                case "l":
                    text += String(line) + remainingPhrase
                case "D":
                    // start of datetime format
                    text += formatDate(String(remainingPhrase))
                case "d":
                    text += remainingPhrase
                case "Z":
                    // start of datetime format in UTC timezone
                    text += formatDate(String(remainingPhrase), timeZone: "UTC")
                case "z":
                    text += remainingPhrase
                case "C":
                    // color code ("" on default)
                    text += "" + colorForLevel(level) + remainingPhrase
                case "c":
                    text += "" + remainingPhrase
                default:
                    text += phrase
                }
            }
        }
        return text
    }
    
    /// returns the filename of a path
    public static func fileNameOfFile(_ file: String) -> String {
        let fileParts = file.components(separatedBy: "/")
        if let lastPart = fileParts.last {
            return lastPart
        }
        return ""
    }
    
    /// returns the filename without suffix (= file ending) of a path
    public static func fileNameWithoutSuffix(_ file: String) -> String {
        let fileName = fileNameOfFile(file)
        
        if !fileName.isEmpty {
            let fileNameParts = fileName.components(separatedBy: ".")
            if let firstPart = fileNameParts.first {
                return firstPart
            }
        }
        return ""
    }
    
    /// returns a formatted date string
    /// optionally in a given abbreviated timezone like "UTC"
    public static func formatDate(_ dateFormat: String, timeZone: String = "") -> String {
        if !timeZone.isEmpty {
            formatter.timeZone = TimeZone(abbreviation: timeZone)
        }
        formatter.dateFormat = dateFormat
        //let dateStr = formatter.string(from: NSDate() as Date)
        let dateStr = formatter.string(from: Date())
        return dateStr
    }
    
    /// returns the json-encoded string value
    /// after it was encoded by jsonStringFromDict
    public static func jsonStringValue(_ jsonString: String?, key: String) -> String {
        guard let str = jsonString else {
            return ""
        }
        // remove the leading {"key":" from the json string and the final }
        let offset = key.count + 5
        let endIndex = str.index(str.startIndex,
                                 offsetBy: str.count - 2)
        let range = str.index(str.startIndex, offsetBy: offset)..<endIndex
        return String(str[range])
    }
    
    public static func jsonStringFromDict(_ dict: [String: Any]) -> String? {
        var jsonString: String?
        
        // try to create JSON string
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: dict, options: [])
            jsonString = String(data: jsonData, encoding: .utf8)
        } catch {
            print("SwiftyBeaver could not create JSON from dict.")
        }
        return jsonString
    }
    
}

