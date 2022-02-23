//
//  Components.swift
//  ASAPTY
//
//  Created by Pavel Kuznetsov on 23.02.2022.
//

import Foundation

struct Constants {
    // UserDefaults keys
    static let firstRunKey = "asapty_first_run_key"
    static let attributionSendKey = "asapty_attribution_send_key"
    // Server APIs
    static let serverAPI = "https://asapty.com/_api/mmpEvents/"
    static let serverDEVAPI = "https://dev.asapty.com/_api/mmpEvents/"
    static let appleAttributionAPI = "https://api-adservices.apple.com/api/v1/"
}

final class Storage {
    static var firstRunDate: Date = {
        if let date: Date = Storage.value(forKey: Constants.firstRunKey) {
            return date
        }
        
        let date = Date()
        Storage.storeValue(value: date, forKey: Constants.firstRunKey)
        return date
    }()
    
    class func storeValue<T>(value: T, forKey key: String) {
        UserDefaults.standard.set(value, forKey: key)
    }
    
    class func value<T>(forKey key: String) -> T? {
        guard let value = UserDefaults.standard.value(forKey: key) as? T else { return nil }
        return value
    }
    
    class func deleteValue(forKey key: String) {
        UserDefaults.standard.removeObject(forKey: key)
    }
}

struct ModelAdapter {
    private struct Keys {
        static let asaptyid = "asaptyid"
        static let source = "source"
        static let campaignid = "campaignid"
        static let installTime = "install_time"
        static let adgroupid = "adgroupid"
        static let keywordid = "keywordid"
        static let orgname = "orgname"
        static let iadCreativeId = "iad-creative-id"
    }
    static func adapt(appleResponse: [String: Any], token: String, installDate: String) -> [String: String] {
        var result: [String: String] = [:]
        result[Keys.asaptyid] = token
        result[Keys.source] = "sdk"
        if let campaignId = appleResponse["campaignId"] as? Int {
            result[Keys.campaignid] = "\(campaignId)"
        }
        result[Keys.installTime] = installDate
        if let adGroupId = appleResponse["adGroupId"] as? Int {
            result[Keys.adgroupid] = "\(adGroupId)"
        }
        if let keywordId = appleResponse["keywordId"] as? Int {
            result[Keys.keywordid] = "\(keywordId)"
        }
        if let orgId = appleResponse["orgId"] as? Int {
            result[Keys.orgname] = "\(orgId)"
        }
        if let adId = appleResponse["adId"] as? Int {
            result[Keys.iadCreativeId] = "\(adId)"
        }
        return result
    }
}
