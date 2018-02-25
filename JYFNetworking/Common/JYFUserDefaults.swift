//
//  JYFUserDefaults.swift
//  JYFNetworking
//
//  Created by jiang on 2018/2/1.
//  Copyright © 2018年 EasyHome. All rights rJYFerved.
//

import Foundation

public struct JYFUserDefaults {
    private static let kSuiteName               = "JYFSuiteName"
    private static let kNetEnvKey               = "NetEnvKey"
    private static let kCurrentUserIdKey        = "CurrentUserIdKey"
    private static let kCurrentAppVersionKey    = "CurrentAppVersionKey"
    private static let kApplocationKey          = "ApplocationKey"
    
    private static let defaults = UserDefaults(suiteName: kSuiteName)!
    
    //几套环境
    public static func saveNetEnvType(netEnvType: NetEnvType) {
        defaults.set(netEnvType.rawValue, forKey: kNetEnvKey)
        defaults.synchronize()
    }
    public static func getNetEnvType() -> NetEnvType {
        if let netEnvType: NetEnvType = defaults.value(forKey: kNetEnvKey) as? NetEnvType, netEnvType.rawValue.count > 0 {
            return netEnvType
        }
        return NetEnvType.alpha
    }
    
    //最近用户id
    public static func saveCurrentUserId(userId: String) {
        defaults.set(userId, forKey: kCurrentUserIdKey)
        defaults.synchronize()
    }
    public static func getCurrentUserId() -> String? {
        if let userId: String = defaults.value(forKey: kCurrentUserIdKey) as? String, userId.count > 0 {
            return userId
        }
        return nil
    }
    
    //最近版本号 : 可用于第一次安装app的判断，如引导页
    public static func saveCurrentAppVersion(appVersion: String) {
        defaults.set(appVersion, forKey: kCurrentAppVersionKey)
        defaults.synchronize()
    }
    public static func getCurrentAppVersion() -> String? {
        if let appVersion: String = defaults.value(forKey: kCurrentAppVersionKey) as? String, appVersion.count > 0 {
            return appVersion
        }
        return nil
    }
    
    //写死地址标识
    public static func setStaticApplocation(isStatic: Bool) {
        defaults.set(isStatic, forKey: kApplocationKey)
        defaults.synchronize()
    }
    public static func getStaticApplocation() -> Bool {
        let isStatic = defaults.bool(forKey: kApplocationKey)
        return isStatic
    }
    
}
