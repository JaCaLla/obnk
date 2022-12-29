//
//  ImagesCache.swift
//  obnk
//
//  Created by Javier Calatrava on 29/12/22.
//

import Foundation

internal final class ImagesCache: NSCache<AnyObject, AnyObject> {
    // MARK: - Constants
    static let shared = ImagesCache()

    // MARK: - Lifecycle/Overridden
    private override init() {
        super.init()
    }
}
