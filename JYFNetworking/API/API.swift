//
//  API.swift
//  ESNetworking
//
//  Created by jiang on 2018/1/30.
//  Copyright © 2018年 EasyHome. All rights reserved.
//

import Foundation
import Moya

private func JSONResponseDataFormatter(data: Data) -> Data {
    do {
        let dataAsJSON = try JSONSerialization.jsonObject(with: data, options: [])
        let prettyData =  try JSONSerialization.data(withJSONObject: dataAsJSON, options: .prettyPrinted)
        return prettyData
    } catch {
        return data //fallback to original data if it cant be serialized
    }
}

private let networkLoggerPlugin = NetworkLoggerPlugin(verbose: true, responseDataFormatter: JSONResponseDataFormatter)

private let networkActivityPlugin = NetworkActivityPlugin { change, target  -> () in
    switch change {
    case .ended:
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    case .began:
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
}

public enum API { // swiftlint:disable:this type_name
    
    static let apiContext = ESApiContext.sharedInstance
    
    private enum APIDebug {
        static let ESCaseProvider = MoyaProvider<ESCaseAPI>(plugins: [networkActivityPlugin, networkLoggerPlugin])
        static let ESLogRegisterProvider = MoyaProvider<ESLogRegisterAPI>(plugins: [networkActivityPlugin, networkLoggerPlugin])

    }
    
    private enum APIRelease {
        static let ESCaseProvider = MoyaProvider<ESCaseAPI>(plugins: [networkActivityPlugin])
        static let ESLogRegisterProvider = MoyaProvider<ESLogRegisterAPI>(plugins: [networkActivityPlugin])
    }
    

    
    public static var ESCaseProvider: MoyaProvider<ESCaseAPI> {
        if apiContext.isReleaseModel {
            return APIRelease.ESCaseProvider
        } else {
            return APIDebug.ESCaseProvider
        }
    }
    
    public static var ESLogRegisterProvider: MoyaProvider<ESLogRegisterAPI> {
        if apiContext.isReleaseModel {
            return APIRelease.ESLogRegisterProvider
        } else {
            return APIDebug.ESLogRegisterProvider
        }
    }
    
}

