//
//  AppnomixKeyboardSDK.swift
//  Unity-iPhone
//
//  Created by Andrei Sava on 03.03.2025.
//

import SwiftUI

@objc public class AppnomixKeyboardSDK: NSObject {
    @objc public static let instance = AppnomixKeyboardSDK()

    var sharedUserDefaults: UserDefaults? {
        UserDefaults(suiteName: "YOUR_APP_GROUP_ID_HERE")
    }
    private override init() {
        super.init()
        
        setup()
    }
    
    @objc public func setup() {
        if let bundleIdentifier = Bundle.main.bundleIdentifier {
            sharedUserDefaults?.set(bundleIdentifier, forKey: TypeProSharedSettingsKeys.appBundleID)
        }
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(showSwiftUIView),
            name: NSNotification.Name("AppnomixShowOnboarding"),
            object: nil)
    }
    
    @objc func showSwiftUIView() {
        
        let swiftUIView = UIHostingController(rootView: ContentView())

        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let window = windowScene.windows.first {
            window.rootViewController = swiftUIView
            window.makeKeyAndVisible()
        }
     }

}
