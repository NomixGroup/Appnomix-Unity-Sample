//
//  ContentView.swift
//  Unity-iPhone
//
//  Created by Andrei Sava on 27.02.2025.
//


import SwiftUI
import AppnomixSDK
import AppTrackingTransparency

struct ContentView: View {
    @Environment(\.scenePhase) var scenePhase

    var configuration: KeyboardActivationViewConfiguration {
        KeyboardActivationViewConfiguration(
            sharedGroupUserDefaults: sharedUserDefaults!,
            activateInSettingsTitle: "**Step 1 of 2: Set up YOUR_APP_NAME_HERE**",
            activateInSettingsSteps: [
                StepConfiguration(text: "Select **Keyboards**", image: Image("keyboard_icon")),
                StepConfiguration(text: "Enable **YOUR_APP_NAME_HERE**", image: Image("enable_icon")),
                StepConfiguration(text: "Enable **Full Access**", image: Image("enable_icon")),
                StepConfiguration(text: "Come back here", image: Image("come_back_icon"))
            ],
            activateInSettingsButtonLabel: "Set up now",
            activateInSettingsButtonColor: Color(.buttonPrimary),
            activateInSettingsButtonTextColor: Color(.textPrimary),
            activateInSettingsIcon: Image("logo_with_text"),
            activateOnKeyboardTitle: "**Step 2 of 2: Switch to YOUR_APP_NAME_HERE**",
            activateOnKeyboardSteps: [
                StepConfiguration(text: "Hold **Globe key** on the keyboard", image: Image("globe_icon")),
                StepConfiguration(text: "Select **YOUR_APP_NAME_HERE**", image: Image("select_icon")),
            ],
            activateOnKeyboardButtonLabel: "Done",
            activateOnKeyboardButtonColor: Color(.buttonPrimary),
            activateOnKeyboardButtonTextColor: Color(.textPrimary),
            activateOnKeyboardIcon: Image("logo_with_text"),
            openSystemSettings: openSystemSettings,
            keyboardBundleId: "YOUR_KEYBOARD_BUNDLE_ID_HERE"
        )
    }
    
    var sharedUserDefaults: UserDefaults? {
        AppnomixKeyboardSDK.instance.sharedUserDefaults
    }
    
    var clientId: String {
        "YOUR_CLIENT_ID_HERE"
    }
    
    var authToken: String {
        "YOUR_AUTH_TOKEN_HERE"
    }
    var source: String {
        sharedUserDefaults?.string(forKey: TypeProSharedSettingsKeys.appBundleID) ?? Bundle.main.bundleIdentifier ?? ""
    }

    
    var body: some View {
        OnboardingView(
            configuration: configuration,
            onboardingConfiguration: OnboardingConfiguration(
                sharedUserDefaults: sharedUserDefaults,
                clientId: clientId,
                authToken: authToken,
                source: source)
        )
            .onChange(of: scenePhase) { newPhase in
                if newPhase == .active {
                    requestTrackingAuthorization()
                }
            }
            .onAppear {
                requestTrackingAuthorization()
            }
    }
    
    func openSystemSettings() {
        if let settingsURL = URL(string: UIApplication.openSettingsURLString) {
            UIApplication.shared.open(settingsURL)
        }
    }
    
    func requestTrackingAuthorization() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            ATTrackingManager.requestTrackingAuthorization { status in
                switch status {
                case .authorized:
                    print("ATTrackingManager Tracking authorized")
                case .denied:
                    print("ATTrackingManager Tracking denied")
                case .notDetermined:
                    print("ATTrackingManager Tracking not determined")
                case .restricted:
                    print("ATTrackingManager Tracking restricted")
                @unknown default:
                    print("ATTrackingManager Tracking unknown")
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
import SwiftUI
import WebKit
 
struct WebView: UIViewRepresentable {
 
    var url: URL
 
    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }
 
    func updateUIView(_ webView: WKWebView, context: Context) {
        let request = URLRequest(url: url)
        webView.load(request)
    }
}

extension Color {
    init(hex: String) {
        let scanner = Scanner(string: hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted))
        var color: UInt64 = 0
        scanner.scanHexInt64(&color)
        let red = Double((color >> 16) & 0xFF) / 255.0
        let green = Double((color >> 8) & 0xFF) / 255.0
        let blue = Double(color & 0xFF) / 255.0
        self.init(red: red, green: green, blue: blue)
    }
    
    var uiColor: UIColor {
        UIColor(self)
    }
}
