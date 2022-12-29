//
//  APIManagerError.swift
//  obnk
//
//  Created by Javier Calatrava on 27/12/22.
//

import Foundation

enum APIManagerError: Error, Equatable {

    case noURLBuilt
    case busy
    case fetching
    case jsonDecoding
    case noData
    case noOK
    case noAPICharacters

    var description: String {
        switch self {
        case .noURLBuilt: return "Not possible build url"
        case .busy: return "Call is on process already"
        case .fetching: return "Error fetching data"
        case .jsonDecoding: return "Error with json decoding"
        case .noData: return "No data received"
        case .noOK: return "Server response not OK"
        case .noAPICharacters: return "No noAPICharacters service defined"
        }
    }
}
