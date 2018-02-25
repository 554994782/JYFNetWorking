//
//  API.swift
//  JYFNetworking
//
//  Created by jiang on 2018/1/30.
//  Copyright © 2018年 EasyHome. All rights rJYFerved.
//

import Foundation
import Moya

private func JSONRJYFponseDataFormatter(data: Data) -> Data {
    do {
        let dataAsJSON = try JSONSerialization.jsonObject(with: data, options: [])
        let prettyData =  try JSONSerialization.data(withJSONObject: dataAsJSON, options: .prettyPrinted)
        return prettyData
    } catch {
        return data //fallback to original data if it cant be serialized
    }
}

private let networkLoggerPlugin = NetworkLoggerPlugin(verbose: true, responseDataFormatter: JSONRJYFponseDataFormatter)

private let networkActivityPlugin = NetworkActivityPlugin { change, target  -> () in
    switch change {
    case .ended:
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    case .began:
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
}

public enum API { // swiftlint:disable:this type_name
    
    static let apiContext = JYFApiContext.sharedInstance
    
    private enum APIDebug {
        static let JYFCaseProvider = MoyaProvider<JYFCaseAPI>(plugins: [networkActivityPlugin, networkLoggerPlugin])
        static let JYFLogRegisterProvider = MoyaProvider<JYFLogRegisterAPI>(plugins: [networkActivityPlugin, networkLoggerPlugin])

    }
    
    private enum APIRelease {
        static let JYFCaseProvider = MoyaProvider<JYFCaseAPI>(plugins: [networkActivityPlugin])
        static let JYFLogRegisterProvider = MoyaProvider<JYFLogRegisterAPI>(plugins: [networkActivityPlugin])
    }
    

    
    public static var JYFCaseProvider: MoyaProvider<JYFCaseAPI> {
        if apiContext.isReleaseModel {
            return APIRelease.JYFCaseProvider
        } else {
            return APIDebug.JYFCaseProvider
        }
    }
    
    public static var JYFLogRegisterProvider: MoyaProvider<JYFLogRegisterAPI> {
        if apiContext.isReleaseModel {
            return APIRelease.JYFLogRegisterProvider
        } else {
            return APIDebug.JYFLogRegisterProvider
        }
    }
    
}

