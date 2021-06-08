//
//  Device.swift
//  
//
//  Created by Ostap on 08.06.2021.
//

#if canImport(UIKit)
import UIKit
#elseif canImport(AppKit)
import AppKit
#else
import WatchKit
#endif

public enum UserInterfaceIdiom {
    case phone, pad, mac, watch, tv
    
    #if canImport(UIKit)
    public init?(_ idiom: UIUserInterfaceIdiom) {
        switch idiom {
        case .phone:
            self = .phone
        case .pad:
            self = .pad
        case .mac:
            self = .mac
        case .tv:
            self = .tv
        default:
            return nil
        }
    }
    #endif
}

public struct Device {
    public static let current = Device()
    
    public var userInterfaceIdiom: UserInterfaceIdiom {
        #if os(macOS)
        return .mac
        #elseif os(watchOS)
        return .watch
        #else
        return .init(UIDevice.current.userInterfaceIdiom)!
        #endif
    }
}

