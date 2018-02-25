//
//  JYFApiContext.swift
//  JYFNetworking
//
//  Created by jiang on 2018/1/31.
//  Copyright © 2018年 EasyHome. All rights rJYFerved.
//

import UIKit
import JYFBasic

public class JYFApiContext {

    public var isReleaseModel: Bool = false {
        willSet {
             JYFUserDefaults.saveNetEnvType(netEnvType: NetEnvType.product)
        }
    }
    
    public static let sharedInstance = JYFApiContext()
    private init() { }

    public static func getHeader(signStr: String) -> Dictionary<String, String> {
        let userInfo = JYFRealmServicJYF.loadUserInfo()
        let channel = "10103"
        let uuid = JYFRealmServicJYF.loadUUID()
        var platform = ""
        if userInfo?.memberType == "dJYFigner" {
            platform = "dJYFigner"
        } else if userInfo?.memberType == "member" {
            platform = "proprietor"
        }
        let system = "iOS"
        let version = JYFAppInfo.appVersion
        
        var headerDic : [String: String] = ["X-Member-Id" :userInfo?.memberId ?? "",
        "X-Token"     :userInfo?.xToken ?? "",
        "X-Channel"   :channel,
        "X-SJYFsion-Id":uuid,
        "platform"    :platform,
        "version"     :version,
        "system"      :system,
        "X-Region"    :"",
        "X-Sign"      :signStr]
        
//        [JRLocationServicJYF sharedInstance].locationCityInfo.cityCode
        
        if JYFUserDefaults.getStaticApplocation() {
            headerDic["X-Region"] = "110100"
        }
        return headerDic
    }
    
}


