//
//  APICharacter.swift
//  obnk
//
//  Created by Javier Calatrava on 27/12/22.
//

import Foundation

internal final class APICharacters: APIService<ResponseAPI> {
    
    // MARK: - Overridden
    override func getCommnad() -> String {
        return "characters"
    }
}
