//
//  KeyboardViewController.swift
//  Keyboard
//
//  Created by Andrei Sava on 27.02.2025.
//

import UIKit
import AppnomixSDK
import SwiftUI

class KeyboardViewController: AppnomixUIInputViewController {
    override var sharedUserDefaults: UserDefaults? {
        UserDefaults(suiteName: "YOUR_APP_GROUP_ID_HERE")
    }
    
    override var clientId: String {
        "YOUR_CLIENT_ID_HERE"
    }
    
    override var authToken: String {
        "YOUR_AUTH_TOKEN_HERE"
    }
    override var urlAppScheme: String? { "YOUR_APP_SCHEME_HERE" }
    override var source: String {
        sharedUserDefaults?.string(forKey: TypeProSharedSettingsKeys.appBundleID) ?? ""
    }
    
    override var allowFullAccessConfiguration: AllowFullAccessConfiguration? {
        return AllowFullAccessConfiguration(
            notificationTitle: "Allow Full Access to get recommendations →",
            notificationBackground: Color(.blue1),
            notificationTextColor: .white,
            tutorialTitle: "How to allow Full Access",
            tutorialSteps: [
                "Open **Settings**",
                "Click on **YOUR_APP_NAME_HERE**",
                "Click on **Keyboards**",
                "Turn on **Allow Full Access**"
            ],
            tutorialStepsBackground: Color(uiColor: .lightGray),
            tutorialStepsTextColor: .black,
            openSettingsButtonLabel: "Open Settings",
            openSettingsButtonTextColor: .accentColor
        )
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        set(smartbarIcon: Image("typepro_logo"))
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
}
