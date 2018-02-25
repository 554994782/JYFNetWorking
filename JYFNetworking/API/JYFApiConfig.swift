//
//  JYFApiConfig.swift
//  JYFNetworking
//
//  Created by jiang on 2018/1/31.
//  Copyright © 2018年 EasyHome. All rights rJYFerved.
//

import Foundation

public enum NetEnvType: String {
    case alpha = "NetEnvTypeAlpha"
    case uat = "NetEnvTypeUAT"
    case product = "NetEnvTypeProduct"
}

public struct JYFApiConfig {
    
    public static var netEnvType: NetEnvType {
        get {
            let envType = JYFUserDefaults.getNetEnvType()
            return envType
        }
        set {}
    }
    
    private static let baseUrlProduct = "api.shejijia.com"
    private static let baseUrlUat = "aly-uat-api.shejijia.com"
    private static let baseUrlAlpha = "aly-alpha-api.shejijia.com"
    private static let h5UrlAlpha = "alpha-www.shejijia.com"
    
    public static var appType : String {
        get {
            let info = Bundle.main.infoDictionary
            let type = info!["AppType"] ?? "";
            return type as! String
        }
        set {}
    }
    
    public static var baseUrl : String {
        get {
            switch self.netEnvType  {
            case .alpha:
                return String(format: "https://%@", baseUrlAlpha)
            case .uat:
                return String(format: "https://%@", baseUrlUat)
            case .product:
                return String(format: "https://%@", baseUrlProduct)
            }
        }
        set {}
    }
    
    public static var logRegister : String {
        get {
            switch self.netEnvType  {
            case .alpha:
                return String(format: "/cas-proxy-sign/guJYFt_user_account/api")
            case .uat:
                return String(format: "/cas-proxy-sign/guJYFt_user_account/api")
            case .product:
                return String(format: "/cas-proxy-sign/guJYFt_user_account/api")
            }
        }
        set {}
    }
    
    
    
    
}
