//
//  ESApiContext.swift
//  ESNetworking
//
//  Created by jiang on 2018/1/31.
//  Copyright © 2018年 EasyHome. All rights reserved.
//

import UIKit
import ESBasic

public class ESApiContext {

    public var isReleaseModel: Bool = false {
        willSet {
             ESUserDefaults.saveNetEnvType(netEnvType: NetEnvType.product)
        }
    }
    
    public static let sharedInstance = ESApiContext()
    private init() { }

    public static func getHeader(signStr: String) -> Dictionary<String, String> {
        let userInfo = ESRealmServices.loadUserInfo()
        let channel = "10103"
        let uuid = ESRealmServices.loadUUID() 
        var platform = ""
        if userInfo?.memberType == "designer" {
            platform = "designer"
        } else if userInfo?.memberType == "member" {
            platform = "proprietor"
        }
        let system = "iOS"
        let version = ESAppInfo.appVersion
        
        var headerDic : [String: String] = ["X-Member-Id" :userInfo?.memberId ?? "",
        "X-Token"     :userInfo?.xToken ?? "",
        "X-Channel"   :channel,
        "X-Session-Id":uuid,
        "platform"    :platform,
        "version"     :version,
        "system"      :system,
        "X-Region"    :"",
        "X-Sign"      :signStr]
        
//        [JRLocationServices sharedInstance].locationCityInfo.cityCode
        
        if ESUserDefaults.getStaticApplocation() {
            headerDic["X-Region"] = "110100"
        }
        return headerDic
    }
    
}


