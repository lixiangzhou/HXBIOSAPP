//
//  HXBKeyChain.swift
//  ZZHxb
//
//  Created by lxz on 2017/12/18.
//  Copyright © 2017年 lixiangzhou. All rights reserved.
//

import Foundation
import KeychainAccess

let HXBKeychain = HXBKeychainClass.shared

extension hxb {
    struct keychain {
        struct key {
            static let token = "token"
            static let phone = "phone"
        }
    }
}

struct HXBKeychainClass {
    
    static let shared: Keychain = {
        return Keychain(service: HXBNetworkConfig.baseUrl)
            .synchronizable(true)
            .accessibility(.afterFirstUnlock)
    }()
    
}

// MARK: -
extension HXBKeychainClass {
    subscript(key: String) -> Any? {
        get {
            return HXBKeychainClass.shared[key]
        }
    }
    
    subscript(key: String) -> String? {
        get {
            return (try? HXBKeychainClass.shared.get(key)).flatMap { $0 }
        }
        
        set {
            if let value = newValue {
                do {
                    try HXBKeychainClass.shared.set(value, key: key)
                } catch {}
            } else {
                do {
                    try HXBKeychainClass.shared.remove(key)
                } catch {}
            }
        }
    }
    
    subscript(string key: String) -> String? {
        get {
            return self[key]
        }
        
        set {
            self[key] = newValue
        }
    }
    
    subscript(data key: String) -> Data? {
        get {
            return (try? HXBKeychainClass.shared.getData(key)).flatMap { $0 }
        }
        
        set {
            if let value = newValue {
                do {
                    try HXBKeychainClass.shared.set(value, key: key)
                } catch {}
            } else {
                do {
                    try HXBKeychainClass.shared.remove(key)
                } catch {}
            }
        }
    }
    
    subscript(attributes key: String) -> Attributes? {
        get {
            return (try? HXBKeychainClass.shared.get(key) { $0 }).flatMap { $0 }
        }
    }
}
