//
//  ESAppInfo.swift
//  ESBasic
//
//  Created by jiang on 2018/1/30.
//  Copyright © 2018年 EasyHome. All rights reserved.
//

import UIKit

public struct ESAppInfo {
    
    public static var appVersion: String {
        guard let dictionary = Bundle.main.infoDictionary,
            let version = dictionary["CFBundleShortVersionString"] as? String else {
                return ""
        }
        return version
    }
    
    public static var appVersionCode: String {
        guard let dictionary = Bundle.main.infoDictionary,
            let versionCode = dictionary["CFBundleVersion"] as? String else {
                return ""
        }
        return versionCode
    }
    
    public static var appShortVersion: String {
        guard let dictionary = Bundle.main.infoDictionary,
            let shortVersion = dictionary["CFBundleShortVersionString"] as? String else {
                return ""
        }
        return shortVersion
    }
    
    public static var appName: String {
        guard let dictionary = Bundle.main.infoDictionary,
            let appName = dictionary["CFBundleDisplayName"] as? String else {
                return ""
        }
        return appName
    }
    
    public static var appBundleID: String {
        guard let dictionary = Bundle.main.infoDictionary,
            let appBundleID = dictionary["CFBundleIdentifier"] as? String else {
                return ""
        }
        return appBundleID
    }
    
    public static func appInfoDescription() {
        log.info("appBundleID:\(appBundleID)")
        log.info("appName:\(appName)")
        log.info("appVersion:\(appVersion)")
        log.info("appVersionCode:\(appVersionCode)")
        log.info("appShortVersion:\(appShortVersion)")
        
    }
}
