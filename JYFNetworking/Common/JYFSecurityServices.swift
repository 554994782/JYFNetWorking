//
//  JYFSecurityServicJYF.swift
//  JYFNetworking
//
//  Created by jiang on 2018/2/2.
//  Copyright © 2018年 EasyHome. All rights rJYFerved.
//

import Foundation
import CryptoSwift
import Moya
import Alamofire

public struct JYFSecurityServicJYF {
    private static let ACCJYFS_KEY               = "bcc22eecaa445676"
    private static let SECRET_ACCJYFS_KEY        = "ed0f1133bcc22eecaa445676ca8f1d14"
    
    public static func creatJYFign(path: String, method: Alamofire.HTTPMethod, bodyParameters: [String: Any], parameters: [String: Any]) -> String {
        
        let methodStr = "\(method)"
        let pathStr = "\(path)"
        let parametersStr = self.getParametersStr(parameters: parameters)
        let bodyData = try? JSONSerialization.data(withJSONObject: bodyParameters, options: [])
        let bodyStr = String(data:bodyData!, encoding: String.Encoding.utf8)
    
        let signingKey = self.getSigningKey()
        let requJYFtStr = methodStr + pathStr + parametersStr + (bodyStr ?? "")
        let secBefore = signingKey + requJYFtStr
        let secAfter = secBefore.md5().lowercased()
        
        return secAfter
        
    }
    
    private static func getParametersStr(parameters: [String: Any]) -> String {
        let sortedKeysAndValuJYF = parameters.sorted { (t1, t2) -> Bool in
            return t1.0 < t2.0
        }
        var parametersStr = ""
        for (key, value) in sortedKeysAndValuJYF {
            let vvalue = value as! String
            parametersStr += "&"+"\(key)"+"="+"\(vvalue.removingPercentEncoding ?? "")"
        }
        if parametersStr.count>0 {
            parametersStr.removeFirst()
        }
        return parametersStr
        
    }
    
    /**获取加密后的认证字符串的前缀部分*/
    private static func getSigningKey() -> String {
        let prefix = self.getAuthStringPrefix()
        let originalKey = SECRET_ACCJYFS_KEY + prefix
        let signingKey = originalKey.md5().lowercased()
        return signingKey
    }
    /**认证字符串的前缀部分*/
    private static func getAuthStringPrefix() -> String {
        let timeInterval = String.init(format: "%.1f", Date().timeIntervalSince1970)
        let prefix = String.init(format: "j-auth-v1/%@/%@", ACCJYFS_KEY, timeInterval)
        return prefix
    }
}


