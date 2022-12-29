//
//  ThreadExtension.swift
//  obnk
//
//  Created by Javier Calatrava on 28/12/22.
//

import Foundation

extension Thread {
  var isRunningXCTest: Bool {
    for key in self.threadDictionary.allKeys {
      guard let keyAsString = key as? String else {
        continue
      }
    
      if keyAsString.split(separator: ".").contains("xctest") {
        return true
      }
    }
    return false
  }
}
