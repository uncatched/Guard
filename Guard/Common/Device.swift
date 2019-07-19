//
//  Device.swift
//  Guard
//
//  Created by Denys on 6/26/19.
//  Copyright © 2019 Litvinskii Denis. All rights reserved.
//

import UIKit

final class Device {
    
    static var identifier: String = {
        var systemInfo = utsname()
        uname(&systemInfo)
        let mirror = Mirror(reflecting: systemInfo.machine)
        
        let identifier = mirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8, value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
        return identifier
    }()
    
    static var touchIdDevices: [String] {
        return ["iPhone6,1", "iPhone6,2", "iPhone7,2", "iPhone7,1", "iPhone8,1", "iPhone8,2", "iPhone9,1", "iPhone9,3", "iPhone9,2", "iPhone9,4", "iPhone8,4", "iPhone10,1", "iPhone10,4", "iPhone10,2", "iPhone10,5", "iPad5,3", "iPad5,4", "iPad6,11", "iPad6,12", "iPad7,5", "iPad7,6", "iPad4,7", "iPad4,8", "iPad4,9", "iPad5,1", "iPad5,2", "iPad6,3", "iPad6,4", "iPad6,7", "iPad6,8", "iPad7,1", "iPad7,2", "iPad7,3", "iPad7,4"]
    }
    
    static var faceIdDevices: [String] {
        return ["iPhone10,3", "iPhone10,6", "iPhone11,2", "iPhone11,4", "iPhone11,6", "iPhone11,8", "iPad8,1", "iPad8,2", "iPad8,3", "iPad8,4", "iPad8,5", "iPad8,6", "iPad8,7", "iPad8,8"]
    }
    
    static var description: String {
        switch identifier {
        case "iPod5,1": return "iPod Touch 5"
        case "iPod7,1": return "iPod Touch 6"
        case "iPhone3,1", "iPhone3,2", "iPhone3,3": return "iPhone 4"
        case "iPhone4,1": return "iPhone 4s"
        case "iPhone5,1", "iPhone5,2": return "iPhone 5"
        case "iPhone5,3", "iPhone5,4": return "iPhone 5c"
        case "iPhone6,1", "iPhone6,2": return "iPhone 5s"
        case "iPhone7,2": return "iPhone 6"
        case "iPhone7,1": return "iPhone 6 Plus"
        case "iPhone8,1": return "iPhone 6s"
        case "iPhone8,2": return "iPhone 6s Plus"
        case "iPhone9,1", "iPhone9,3": return "iPhone 7"
        case "iPhone9,2", "iPhone9,4": return "iPhone 7 Plus"
        case "iPhone8,4": return "iPhone SE"
        case "iPhone10,1", "iPhone10,4": return "iPhone 8"
        case "iPhone10,2", "iPhone10,5": return "iPhone 8 Plus"
        case "iPhone10,3", "iPhone10,6": return "iPhone X"
        case "iPhone11,2": return "iPhone Xs"
        case "iPhone11,4", "iPhone11,6": return "iPhone Xs Max"
        case "iPhone11,8": return "iPhone Xr"
        case "iPad2,1", "iPad2,2", "iPad2,3", "iPad2,4": return "iPad 2"
        case "iPad3,1", "iPad3,2", "iPad3,3": return "iPad 3"
        case "iPad3,4", "iPad3,5", "iPad3,6": return "iPad 4"
        case "iPad4,1", "iPad4,2", "iPad4,3": return "iPad Air"
        case "iPad5,3", "iPad5,4": return "iPad Air 2"
        case "iPad6,11", "iPad6,12": return "iPad 5"
        case "iPad7,5", "iPad7,6": return "iPad 6"
        case "iPad2,5", "iPad2,6", "iPad2,7": return "iPad Mini"
        case "iPad4,4", "iPad4,5", "iPad4,6": return "iPad Mini 2"
        case "iPad4,7", "iPad4,8", "iPad4,9": return "iPad Mini 3"
        case "iPad5,1", "iPad5,2": return "iPad Mini 4"
        case "iPad6,3", "iPad6,4": return "iPad Pro (9.7-inch)"
        case "iPad6,7", "iPad6,8": return "iPad Pro (12.9-inch)"
        case "iPad7,1", "iPad7,2": return "iPad Pro (12.9-inch) (2nd generation)"
        case "iPad7,3", "iPad7,4": return "iPad Pro (10.5-inch)"
        case "iPad8,1", "iPad8,2", "iPad8,3", "iPad8,4": return "iPad Pro (11-inch)"
        case "iPad8,5", "iPad8,6", "iPad8,7", "iPad8,8": return "iPad Pro (12.9-inch) (3rd generation)"
        case "i386", "x86_64": return "Simulator"
        default: return "Unknown"
        }
    }
    
    static var diagonal: Double {
        switch identifier {
        case "iPod5,1": return 4
        case "iPod7,1": return 4
        case "iPhone3,1", "iPhone3,2", "iPhone3,3": return 3.5
        case "iPhone4,1": return 3.5
        case "iPhone5,1", "iPhone5,2": return 4
        case "iPhone5,3", "iPhone5,4": return 4
        case "iPhone6,1", "iPhone6,2": return 4
        case "iPhone7,2": return 4.7
        case "iPhone7,1": return 5.5
        case "iPhone8,1": return 4.7
        case "iPhone8,2": return 5.5
        case "iPhone9,1", "iPhone9,3": return 4.7
        case "iPhone9,2", "iPhone9,4": return 5.5
        case "iPhone8,4": return 4
        case "iPhone10,1", "iPhone10,4": return 4.7
        case "iPhone10,2", "iPhone10,5": return 5.5
        case "iPhone10,3", "iPhone10,6": return 5.8
        case "iPhone11,2": return 5.8
        case "iPhone11,4", "iPhone11,6": return 6.5
        case "iPhone11,8": return 6.1
        case "iPad2,1", "iPad2,2", "iPad2,3", "iPad2,4": return 9.7
        case "iPad3,1", "iPad3,2", "iPad3,3": return 9.7
        case "iPad3,4", "iPad3,5", "iPad3,6": return 9.7
        case "iPad4,1", "iPad4,2", "iPad4,3": return 9.7
        case "iPad5,3", "iPad5,4": return 9.7
        case "iPad6,11", "iPad6,12": return 9.7
        case "iPad7,5", "iPad7,6": return 9.7
        case "iPad2,5", "iPad2,6", "iPad2,7": return 7.9
        case "iPad4,4", "iPad4,5", "iPad4,6": return 7.9
        case "iPad4,7", "iPad4,8", "iPad4,9": return 7.9
        case "iPad5,1", "iPad5,2": return 7.9
        case "iPad6,3", "iPad6,4": return 9.7
        case "iPad6,7", "iPad6,8": return 12.9
        case "iPad7,1", "iPad7,2": return 12.9
        case "iPad7,3", "iPad7,4": return 10.5
        case "iPad8,1", "iPad8,2", "iPad8,3", "iPad8,4": return 11
        case "iPad8,5", "iPad8,6", "iPad8,7", "iPad8,8": return 12.9
        default: return 0.0
        }
    }
    
    static var ppi: Int {
        switch identifier {
        case "iPod5,1": return 326
        case "iPod7,1": return 326
        case "iPhone3,1", "iPhone3,2", "iPhone3,3": return 326
        case "iPhone4,1": return 326
        case "iPhone5,1", "iPhone5,2": return 326
        case "iPhone5,3", "iPhone5,4": return 326
        case "iPhone6,1", "iPhone6,2": return 326
        case "iPhone7,2": return 326
        case "iPhone7,1": return 401
        case "iPhone8,1": return 326
        case "iPhone8,2": return 401
        case "iPhone9,1", "iPhone9,3": return 326
        case "iPhone9,2", "iPhone9,4": return 401
        case "iPhone8,4": return 326
        case "iPhone10,1", "iPhone10,4": return 326
        case "iPhone10,2", "iPhone10,5": return 401
        case "iPhone10,3", "iPhone10,6": return 458
        case "iPhone11,2": return 458
        case "iPhone11,4", "iPhone11,6": return 458
        case "iPhone11,8": return 326
        case "iPad2,1", "iPad2,2", "iPad2,3", "iPad2,4": return 132
        case "iPad3,1", "iPad3,2", "iPad3,3": return 264
        case "iPad3,4", "iPad3,5", "iPad3,6": return 264
        case "iPad4,1", "iPad4,2", "iPad4,3": return 264
        case "iPad5,3", "iPad5,4": return 264
        case "iPad6,11", "iPad6,12": return 264
        case "iPad7,5", "iPad7,6": return 264
        case "iPad2,5", "iPad2,6", "iPad2,7": return 163
        case "iPad4,4", "iPad4,5", "iPad4,6": return 326
        case "iPad4,7", "iPad4,8", "iPad4,9": return 326
        case "iPad5,1", "iPad5,2": return 326
        case "iPad6,3", "iPad6,4": return 264
        case "iPad6,7", "iPad6,8": return 264
        case "iPad7,1", "iPad7,2": return 264
        case "iPad7,3", "iPad7,4": return 264
        case "iPad8,1", "iPad8,2", "iPad8,3", "iPad8,4": return 264
        case "iPad8,5", "iPad8,6", "iPad8,7", "iPad8,8": return 264
        default: return 0
        }
    }
    
    static var ratio: (width: Double, height: Double) {
        switch identifier {
        case "iPod5,1": return (width: 9, height: 16)
        case "iPod7,1": return (width: 9, height: 16)
        case "iPhone3,1", "iPhone3,2", "iPhone3,3": return (width: 2, height: 3)
        case "iPhone4,1": return (width: 2, height: 3)
        case "iPhone5,1", "iPhone5,2": return (width: 9, height: 16)
        case "iPhone5,3", "iPhone5,4": return (width: 9, height: 16)
        case "iPhone6,1", "iPhone6,2": return (width: 9, height: 16)
        case "iPhone7,2": return (width: 9, height: 16)
        case "iPhone7,1": return (width: 9, height: 16)
        case "iPhone8,1": return (width: 9, height: 16)
        case "iPhone8,2": return (width: 9, height: 16)
        case "iPhone9,1", "iPhone9,3": return (width: 9, height: 16)
        case "iPhone9,2", "iPhone9,4": return (width: 9, height: 16)
        case "iPhone8,4": return (width: 9, height: 16)
        case "iPhone10,1", "iPhone10,4": return (width: 9, height: 16)
        case "iPhone10,2", "iPhone10,5": return (width: 9, height: 16)
        case "iPhone10,3", "iPhone10,6": return (width: 9, height: 19.5)
        case "iPhone11,2": return (width: 9, height: 19.5)
        case "iPhone11,4", "iPhone11,6": return (width: 9, height: 19.5)
        case "iPhone11,8": return (width: 9, height: 19.5)
        case "iPad2,1", "iPad2,2", "iPad2,3", "iPad2,4": return (width: 3, height: 4)
        case "iPad3,1", "iPad3,2", "iPad3,3": return (width: 3, height: 4)
        case "iPad3,4", "iPad3,5", "iPad3,6": return (width: 3, height: 4)
        case "iPad4,1", "iPad4,2", "iPad4,3": return (width: 3, height: 4)
        case "iPad5,3", "iPad5,4": return (width: 3, height: 4)
        case "iPad6,11", "iPad6,12": return (width: 3, height: 4)
        case "iPad7,5", "iPad7,6": return (width: 3, height: 4)
        case "iPad2,5", "iPad2,6", "iPad2,7": return (width: 3, height: 4)
        case "iPad4,4", "iPad4,5", "iPad4,6": return (width: 3, height: 4)
        case "iPad4,7", "iPad4,8", "iPad4,9": return (width: 3, height: 4)
        case "iPad5,1", "iPad5,2": return (width: 3, height: 4)
        case "iPad6,3", "iPad6,4": return (width: 3, height: 4)
        case "iPad6,7", "iPad6,8": return (width: 3, height: 4)
        case "iPad7,1", "iPad7,2": return (width: 3, height: 4)
        case "iPad7,3", "iPad7,4": return (width: 3, height: 4)
        case "iPad8,1", "iPad8,2", "iPad8,3", "iPad8,4": return (width: 139, height: 199)
        case "iPad8,5", "iPad8,6", "iPad8,7", "iPad8,8": return (width: 512, height: 683)
        default: return (width: 0, height: 0)
        }
    }
    
    static var hasBiometricSensor: Bool {
        return touchIdDevices.contains(identifier) || faceIdDevices.contains(identifier)
    }
    
    static let rootURL = URL(fileURLWithPath: "/")
    
    static var volumeTotalCapacity: Int? {
        return (try? Device.rootURL.resourceValues(forKeys: [.volumeTotalCapacityKey]))?.volumeTotalCapacity
    }
    
    static var volumeAvailableCapacity: Int? {
        return (try? rootURL.resourceValues(forKeys: [.volumeAvailableCapacityKey]))?.volumeAvailableCapacity
    }
}

extension UIDevice {
    
    enum NetworkInterface: String {
        case wifi = "en0"
        case cellular = "pdp_ip0"
    }
    
    func getWiFiAddress(for networkInterface: NetworkInterface) -> String? {
        var address : String?
        
        // Get list of all interfaces on the local machine:
        var ifaddr : UnsafeMutablePointer<ifaddrs>?
        guard getifaddrs(&ifaddr) == 0 else { return nil }
        guard let firstAddr = ifaddr else { return nil }
        
        // For each interface ...
        for ifptr in sequence(first: firstAddr, next: { $0.pointee.ifa_next }) {
            let interface = ifptr.pointee
            
            // Check for IPv4 or IPv6 interface:
            let addrFamily = interface.ifa_addr.pointee.sa_family
            if addrFamily == UInt8(AF_INET) || addrFamily == UInt8(AF_INET6) {
                
                // Check interface name:
                let name = String(cString: interface.ifa_name)
                if  name == networkInterface.rawValue {
                    
                    // Convert interface address to a human readable string:
                    var hostname = [CChar](repeating: 0, count: Int(NI_MAXHOST))
                    getnameinfo(interface.ifa_addr, socklen_t(interface.ifa_addr.pointee.sa_len),
                                &hostname, socklen_t(hostname.count),
                                nil, socklen_t(0), NI_NUMERICHOST)
                    address = String(cString: hostname)
                }
            }
        }
        freeifaddrs(ifaddr)
        
        return address
    }
}
