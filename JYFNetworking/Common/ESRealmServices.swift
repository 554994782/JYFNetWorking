//
//  ESRealmServices.swift
//  ESNetworking
//
//  Created by jiang on 2018/2/1.
//  Copyright © 2018年 EasyHome. All rights reserved.
//

import Foundation
import RxSwift
import RealmSwift

public struct ESRealmServices {
    fileprivate static var disposeBag = DisposeBag()
    
    public static var currentUserId: String? {
        return ESUserDefaults.getCurrentUserId()
    }
    
}

public extension ESRealmServices {
    static var userRealm: Realm? {
        return try! Realm(configuration: getRealmConfigurationForUserInfo())
    }
    
    static func getRealmConfigurationForUserInfo() -> Realm.Configuration {
        var config = Realm.Configuration()
        config.schemaVersion = 1 //current version is 1 for app version 2.0
        config.migrationBlock = { migration, oldSchemaVersion in

        }
        config.fileURL = config.fileURL!.deletingLastPathComponent().appendingPathComponent("UserInfoCached-\(ESApiConfig.netEnvType).realm")
        config.objectTypes = [UserInfo.self]
        return config
    }
    
    public static func saveUserInfo(_ userInfo: UserInfo) {
        try! userRealm?.write({
            userRealm?.create(UserInfo.self, value: userInfo, update: true)
        })
    }
    
    public static func removeUserInfo() {
        try! userRealm?.write({
            userRealm?.deleteAll()
        })
    }
    
    public static func loadUserInfo() -> UserInfo? {
        let result = userRealm?.objects(UserInfo.self)
        if result?.isEmpty ?? false {
            return nil
        } else {
            return result?.first
        }
    }
    
}

public extension ESRealmServices {
    static var uuidRealm: Realm? {
        return try! Realm(configuration: getRealmConfigurationForUUID())
    }
    
    static func getRealmConfigurationForUUID() -> Realm.Configuration {
        var config = Realm.Configuration()
        config.schemaVersion = 1
        config.fileURL = config.fileURL!.deletingLastPathComponent().appendingPathComponent("UUIDCached-\(ESApiConfig.netEnvType).realm")
        config.objectTypes = [UUIDInfo.self]
        return config
    }
    
    public static func saveUUID(_ uuid: String) {
        let uuidInfo = UUIDInfo()
        uuidInfo.uuid = uuid;
        try! uuidRealm?.write({
            uuidRealm?.create(UUIDInfo.self, value: uuidInfo, update: true)
        })
    }
    
    public static func removeUUID() {
        try! uuidRealm?.write({
            uuidRealm?.deleteAll()
        })
    }
    
    public static func loadUUID() -> String {
        let result = uuidRealm?.objects(UUIDInfo.self)
        if result?.isEmpty ?? false {
            return ""
        } else {
            return result?.first?.uuid ?? ""
        }
    }
    
}


