//
//  ESCaseAPI.swift
//  ESNetworking
//
//  Created by jiang on 2018/1/31.
//  Copyright © 2018年 EasyHome. All rights reserved.
//

import Foundation
import Moya
import Alamofire

public enum ESCaseAPI {
    case GetLiWuMarketHome
    case GetCaseDetail(String, String, String, String)//案例详情
    
}

extension ESCaseAPI: TargetType {
    public var baseURL: URL {
        return URL.init(string: ESApiConfig.logRegister)!
    }
    
    public var path: String {
        switch self {
        case .GetLiWuMarketHome:
            return "espot/supermarketIndex"
        case .GetCaseDetail(let caseId, _, _, _):
            return "cases/\(caseId)"
        }
    }
    
    public var method: Alamofire.HTTPMethod {
        return .get
    }
    
    public var sampleData: Data {
        return "{}".data(using: String.Encoding.utf8)!
    }
    
    public var task: Task {
        return  Task.requestCompositeParameters(bodyParameters: self.bodyParameters, bodyEncoding: URLEncoding.httpBody, urlParameters: self.parameters)
    }
    
    public var headers: [String : String]? {
        
        return nil
    }
    var bodyParameters: [String: Any] {
        switch self {
        case .GetLiWuMarketHome:
            return [:]
        case .GetCaseDetail( _, let brandId, let caseType, let source):
            return ["brandId":brandId, "caseType":caseType, "source":source]
        }
    }
    
    var parameters: [String: Any] {
        switch self {
        case .GetLiWuMarketHome:
            return [:]
        default:
            return [:]
        }
    }

}

