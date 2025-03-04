//
//  UIInputViewController+Ext.swift
//  Unity-iPhone
//
//  Created by Andrei Sava on 27.02.2025.
//


import UIKit

extension UIInputViewController {
    @discardableResult @objc func openURL(_ url: URL) -> Bool {
       var responder: UIResponder? = self
        while responder != nil {
            if let application = responder as? UIApplication {
                if #available(iOS 18.0, *) {
                    return application.perform(#selector(UIApplication.open(_:options:)), with: url, with: [:]) != nil
                } else {
                    return application.perform(#selector(openURL(_:)), with: url) != nil
                }
            }
            responder = responder?.next
        }
        return false
    }
}
