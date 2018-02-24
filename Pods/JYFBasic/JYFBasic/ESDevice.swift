//
//  ESDevice.swift
//  ESBasic
//
//  Created by jiang on 2018/1/24.
//  Copyright © 2018年 EasyHome. All rights reserved.
//

import Foundation
import UIKit

public let SCREEN_WIDTH = UIScreen.main.bounds.size.width
public let SCREEN_HEIGHT = UIScreen.main.bounds.size.height
public let SCREEN_SCALE = SCREEN_WIDTH / 375.0
public let TABBAR_HEIGHT = 49
public let STATUSBAR_HEIGHT = UIApplication.shared.statusBarFrame.size.height
public let NAVBAR_HEIGHT = STATUSBAR_HEIGHT+44
public let DECORATION_SEGMENT_HEIGHT = 40
public let BOTTOM_SAFEAREA_HEIGHT = (STATUSBAR_HEIGHT == 44) ? 17 : 0


public struct ESDevice {
    
    public enum ESDeviceSizeType: String {
        case Unknow
        case Iphone4
        case Iphone5
        case Iphone6And7And8
        case IphonePlus
        case Iphone8
        case IphoneX
    }
    
    public static func isInBackground() -> Bool {
        return UIApplication.shared.applicationState != UIApplicationState.active
    }
    
    public static func isIphone() -> Bool {
        let deviceModel = UIDevice.current.model
        if deviceModel.contains("iPhone") {
            return true
        } else {
            return false
        }
    }
    
    public static func deviceSizeType() -> ESDeviceSizeType {
        switch (SCREEN_WIDTH, SCREEN_HEIGHT) {
        case (320, 480):
            return ESDeviceSizeType.Iphone4
        case (320, 568):// 5/5s/5c/se
            return ESDeviceSizeType.Iphone5
        case (375, 667):// 6/6s/7s/8
            return ESDeviceSizeType.Iphone6And7And8
        case (414, 736)://6p/6sp/7p/8p
            return ESDeviceSizeType.IphonePlus
        case (375, 812):
            return ESDeviceSizeType.IphoneX
        default:
            return ESDeviceSizeType.Unknow
        }
    }
    
    public static func deviceModel() -> String {
        
        let deviceModel = UIDevice.current.model
        
        if deviceModel.contains("iPod") {
            return "iPod Touch"
        } else if deviceModel.contains("iPad") {
            return "iPad"
        } else if deviceModel.contains("iPhone") {
            return "iPhone"
        } else {
            return "Unknown"
        }
    }
    
    public static func deviceVersion() -> Float {
        return Float(UIDevice.current.systemVersion) ?? 0.0
    }

    public static func createUUID() -> String {
        return UUID().uuidString
    }
}
