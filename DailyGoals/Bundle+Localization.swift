// Bundle+Localization.swift

import Foundation

private var bundleKey: UInt8 = 0

extension Bundle {
    static let once: Void = { // Swizzle only once
        object_setClass(Bundle.main, PrivateBundle.self)
    }()
    
    static func setLanguage(_ language: String) {
        Bundle.once
        objc_setAssociatedObject(Bundle.main, &bundleKey, Bundle(path: Bundle.main.path(forResource: language, ofType: "lproj") ?? ""), .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }
}

private class PrivateBundle: Bundle {
    override func localizedString(forKey key: String, value: String?, table tableName: String?) -> String {
        if let bundle = objc_getAssociatedObject(self, &bundleKey) as? Bundle {
            return bundle.localizedString(forKey: key, value: value, table: tableName)
        } else {
            return super.localizedString(forKey: key, value: value, table: tableName)
        }
    }
}
