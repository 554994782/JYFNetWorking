//
//  ESMoyaProvider.swift
//  ESNetworking
//
//  Created by jiang on 2018/2/2.
//  Copyright © 2018年 EasyHome. All rights reserved.
//

import Foundation
import RxSwift
import Moya
import Alamofire

public class ESMoyaProvider<Target>: MoyaProvider<Target> where Target: TargetType {
    
    //override designated initializer
    override public init(endpointClosure: @escaping EndpointClosure = MoyaProvider.defaultEndpointMapping,
                         requestClosure: @escaping RequestClosure = MoyaProvider.defaultRequestMapping,
                         stubClosure: @escaping StubClosure = MoyaProvider.neverStub,
                         callbackQueue: DispatchQueue? = nil,
                         manager: Manager = MoyaProvider<Target>.defaultAlamofireManager(),
                         plugins: [PluginType] = [],
                         trackInflights: Bool = false) {
        
        super.init(endpointClosure: endpointClosure, requestClosure: requestClosure, stubClosure: stubClosure, callbackQueue: callbackQueue, manager: manager, plugins: plugins, trackInflights: trackInflights)
    }
    
    
}

