//
//  DeviceInfo.swift
//  Finder
//
//  Created by Anthony Viriya on R 2/01/05.
//  Copyright © Reiwa 2 AVL. All rights reserved.
//

import Foundation

class DeviceInfo{
    static let modelName: String = {
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let identifier = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8, value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
        return identifier
    }()
}
