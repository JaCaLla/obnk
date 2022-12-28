//
//  UIApplicationExtension.swift
//  obnk
//
//  Created by Javier Calatrava on 28/12/22.
//

import UIKit

extension UIApplication {
    
    var keyWindow: UIWindow? {
        return UIApplication
            .shared
            .connectedScenes
            .compactMap { ($0 as? UIWindowScene)?.keyWindow }
            .first
    }
    
}
