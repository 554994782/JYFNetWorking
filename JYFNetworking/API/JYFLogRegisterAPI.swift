//
//  ESLogRegisterAPI.swift
//  ESNetworking
//
//  Created by jiang on 2018/2/1.
//  Copyright © 2018年 EasyHome. All rights reserved.
//

import Foundation
import Moya
import Alamofire

public enum ESLogRegisterAPI {
    case Login(String, String)//登录
    case register(String, String, String)//注册
    
}

extension ESLogRegisterAPI: TargetType {
    public var baseURL: URL {
        return URL.init(string: ESApiConfig.baseUrl)!
    }
    
    public var path: String {//请求链接，第一个单引号之后，第一个？之前的部分
        switch self {
        case .Login(_, _):
            return ESApiConfig.logRegister + "/v2/login"
        case .register(_, _, _):
            return ESApiConfig.logRegister + "/v1/users"
        }
    }
    
    public var method: Alamofire.HTTPMethod {
        switch self {
        case .Login(_, _):
            return .post
        case .register(_, _, _):
            return .post
        }
    }
    
    public var sampleData: Data {
        return "{}".data(using: String.Encoding.utf8)!
    }
    
    public var task: Task {
        return  Task.requestCompositeParameters(bodyParameters: self.bodyParameters, bodyEncoding: URLEncoding.httpBody, urlParameters: self.parameters)
    }
    
    public var headers: [String : String]? {
        let secStr = ESSecurityServices.createSign(path: self.path, method: self.method, bodyParameters: self.bodyParameters, parameters: self.parameters)
        let header = ESApiContext.getHeader(signStr: secStr)
        return header
    }
    
    var bodyParameters: [String: Any] {
        switch self {
        case .Login(let userName, let password):
            return ["userName":userName, "password":password]
        case .register(let mobile, let smsCode, let cleartextPassword):
            return ["mobile":mobile, "smsCode":smsCode, "cleartextPassword":cleartextPassword]
        }
    }
    
    var parameters: [String: Any] {
        return ["source": "shejijia", "platform": "app-ios", "activity": "normal"]
        
//        switch self {
//        case .Login:
//            return ["source": "shejijia", "platform": "app-ios", "activity": "normal"]
//        default:
//            return [:]
//        }
    }
    
}

