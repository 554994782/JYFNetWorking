//
//  JYFRealmCasJYF.swift
//  JYFNetworking
//
//  Created by jiang on 2018/2/1.
//  Copyright © 2018年 EasyHome. All rights rJYFerved.
//

import Foundation
import RealmSwift

//用户信息
open class UserInfo: Object {
    @objc dynamic open var memberType: String = ""//用户角色
    @objc dynamic open var memberId: String = ""//用户id
    @objc dynamic open var avatar: String = ""//用户头像
    @objc dynamic open var xToken: String = ""//x_token
    @objc dynamic open var phone: String = ""//手机电话号码
    @objc dynamic open var nickName: String  = ""//nickName昵称
    @objc dynamic open var userName: String  = ""//userName昵称
    @objc dynamic open var uid: String = ""//uid
    @objc dynamic open var nimToken: String = ""//云信token
    
    override open static func primaryKey() -> String?  {
        return "memberId"
    }
}

//设备唯一标示
open class UUIDInfo: Object {
    @objc dynamic open var uuid: String = ""//UUID
}
